// jshint node: true
'use strict';

var path = require('path');

module.exports = {
    join: function(array, string, options) {
        string = string || ', ';
        return array.join(string);
    },
    /**
     * {{relative}}
     * Returns the derived relative path from A to B.
     * @param  {string} a Path
     * @param  {string} b Path
     * @return {string}   Path of b relative to a
     * @example:
     *   {{relative [from] [to]}}
     */
    relative: function(from, to, options) {
        if (options && options.hash && options.hash.dirs) from = from + '/.';
        var rp = path.relative(path.dirname(from), path.dirname(to));
        return path.join(rp, path.basename(to));
    },
    debug: function(foo) {
        console.error(foo);
    },

    is: function(a, b, options) {
        if (a === b)
            return options.fn(this);
        else
            return options.inverse(this);
    },
};
