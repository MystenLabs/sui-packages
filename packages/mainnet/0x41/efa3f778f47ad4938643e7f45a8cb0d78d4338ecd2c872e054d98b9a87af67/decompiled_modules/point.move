module 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::point {
    struct Point has copy, drop, store {
        bias: 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::int128::Int128,
        slope: 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::int128::Int128,
        ts: u64,
        blk: u64,
    }

    public fun bias(arg0: &Point) : 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::int128::Int128 {
        arg0.bias
    }

    public fun blk(arg0: &Point) : u64 {
        arg0.blk
    }

    public fun new(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : Point {
        Point{
            bias  : 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::int128::from_u64(arg0),
            slope : 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::int128::from_u64(arg1),
            ts    : arg2,
            blk   : arg3,
        }
    }

    public(friend) fun set_bias(arg0: &mut Point, arg1: 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::int128::Int128) {
        arg0.bias = arg1;
    }

    public(friend) fun set_blk(arg0: &mut Point, arg1: u64) {
        arg0.blk = arg1;
    }

    public(friend) fun set_slope(arg0: &mut Point, arg1: 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::int128::Int128) {
        arg0.slope = arg1;
    }

    public(friend) fun set_ts(arg0: &mut Point, arg1: u64) {
        arg0.ts = arg1;
    }

    public fun slope(arg0: &Point) : 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::int128::Int128 {
        arg0.slope
    }

    public fun ts(arg0: &Point) : u64 {
        arg0.ts
    }

    // decompiled from Move bytecode v6
}

