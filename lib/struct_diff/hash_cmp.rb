#!/usr/bin/env ruby
$stderr.puts "FILE LOADED"
# hash_cmp.rb - Print two hashes side by side, with differing values in red and
# matching key/values in green. Hashes are displayed in the order they appear in
# the LHS hash; the RHS has is reordered if necessary.
require 'colorize'
require 'io/console'

module StructDiff
  # ----------------------------------------------------------------------
  # Usage:
  #
  # load File.expand_path("~/devel/scrapbin/ruby/hash_cmp.rb")
  #
  # hash1 = { "a" => { "b" => 64, "c" => 13 }
  # hash2 = { "a" => { "b" => 63, "c" => 13 }
  #
  # hash_cmp hash1, hash2
  #
  # load <this_file>
  # hash_cmp hash1, hash2
  # ----------------------------------------------------------------------

  # def array_deep_dup(array)
  #   array.map do |item|
  #     if item.is_a? Hash
  #       hash_deep_dup item
  #     elsif item.is_a? Array
  #       array_deep_dup item
  #     else
  #       item.dup
  #     end
  #   end
  # end

  # def hash_deep_dup(hash)
  #   Hash[
  #     *hash.keys.dup.map do |key|
  #       [
  #         key,
  #         if hash[key].is_a? Hash
  #           hash_deep_dup(hash[key])
  #         elsif hash[key].is_a? Array
  #           array_deep_dup(hash[key])
  #         else
  #           hash[key].dup
  #         end
  #       ]
  #     end
  #   ]
  # end

  def self.hash_depth(hash, depth=1)
    hash
      .values
      .dup
      .keep_if {|val| val.is_a? Hash }
      .map {|h| hash_depth(h, depth+1) }.max || depth
  end

  def self.longest_indented_key(hash, depth=1)
    indent = "  " * depth
    spaces = indent.size
    [
      hash.keys.map(&:size).max + spaces,
      hash
        .values
        .dup
        .map { |value| value.is_a?(Hash) ? longest_indented_key(value, depth+1) : 0  }
        .max
    ].max
  end

  def self.hash_cmp(h1, h2, tabs=0)
    indent = "  " * tabs
    # TODO - this is wrong. Don't get max_indent. Use longest_indented_key above
    # to calculate where the deepest => will go. If two of those fit on about a
    # third of the screen width, then that's the width of the key in the format
    # string. Divide the remaning two thirds as the value fields. If they DON'T
    # fit... then... um... math.
    # max_indent = "  " * [hash_depth(h1), hash_depth(h2)].max
    # screen_width = $stdout.winsize[1]

    (h1.keys + h2.keys).uniq.each do |key|
      v1, v2 = h1[key], h2[key]
      if v1.is_a?(Hash)
        msg = "%s%20s => %-40s %20s => %-40s" % [indent, key, "{", key, "{"]
        puts msg
        hash_cmp(v1, v2, tabs+1)
        msg = "%s%20s    %-40s %20s    %-40s" % [indent, "", "}", "", "}"]
        puts msg
      else
        if key.to_s.size <= 20 && v1.to_s.size <= 40
          msg = "%s%20s => %-40s %20s => %-40s" % [indent, key, v1, key, v2]
        else
          msg = "%s%20s => %-40s\n%s%20s    %40s %20s => %-40s" % [indent, key, v1, indent, "", "", key, v2]
        end
        color = if v1 == v2
                  :green
                else
                  :red
                end
        puts msg.send(color)
      end
    end
  end
end
