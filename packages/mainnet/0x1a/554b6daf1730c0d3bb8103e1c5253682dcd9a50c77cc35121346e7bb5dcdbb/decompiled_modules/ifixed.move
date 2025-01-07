module 0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::ifixed {
    public fun abs(arg0: u256) : u256 {
        0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::abs(arg0)
    }

    public fun add(arg0: u256, arg1: u256) : u256 {
        0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::add(arg0, arg1)
    }

    public fun div_down(arg0: u256, arg1: u256) : u256 {
        0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::div_down(0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::mul(arg0, 1000000000000000000), arg1)
    }

    public fun div_up(arg0: u256, arg1: u256) : u256 {
        0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::div_up(0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::mul(arg0, 1000000000000000000), arg1)
    }

    public fun greater_than(arg0: u256, arg1: u256) : bool {
        0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::greater_than(arg0, arg1)
    }

    public fun greater_than_eq(arg0: u256, arg1: u256) : bool {
        0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::greater_than_eq(arg0, arg1)
    }

    public fun is_neg(arg0: u256) : bool {
        0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::is_neg(arg0)
    }

    public fun less_than(arg0: u256, arg1: u256) : bool {
        0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::less_than(arg0, arg1)
    }

    public fun less_than_eq(arg0: u256, arg1: u256) : bool {
        0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::less_than_eq(arg0, arg1)
    }

    public fun neg(arg0: u256) : u256 {
        0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::neg(arg0)
    }

    public fun sub(arg0: u256, arg1: u256) : u256 {
        0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::sub(arg0, arg1)
    }

    public fun close_enough(arg0: u256, arg1: u256, arg2: u256) : bool {
        let v0 = 0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::abs(arg0);
        if (0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::less_than(v0, 0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::abs(arg1))) {
            return close_enough(arg1, arg0, arg2)
        };
        0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::less_than_eq(0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::mul(0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::abs(0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::sub(arg0, arg1)), 1000000000000000000), 0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::mul(v0, arg2))
    }

    public fun close_enough_and_compare(arg0: u256, arg1: u256, arg2: u256, arg3: bool) : bool {
        close_enough(arg0, arg1, arg2) && (arg3 && 0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::less_than_eq(arg0, arg1) || 0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::greater_than_eq(arg0, arg1))
    }

    public fun close_enough_int(arg0: u64, arg1: u64, arg2: u256) : bool {
        close_enough(convert_int_to_fixed(arg0), convert_int_to_fixed(arg1), arg2)
    }

    public fun complement(arg0: u256) : u256 {
        if (0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::less_than(arg0, 1000000000000000000)) {
            0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::sub(1000000000000000000, arg0)
        } else {
            0
        }
    }

    public fun convert_balance9_to_fixed(arg0: u64) : u256 {
        0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::mul((arg0 as u256), 1000000000)
    }

    public fun convert_fixed_to_balance9(arg0: u256) : u64 {
        (0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::abs(0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::div(arg0, 1000000000)) as u64)
    }

    public fun convert_fixed_to_int(arg0: u256) : u64 {
        (0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::div_down(arg0, 1000000000000000000) as u64)
    }

    public fun convert_fixed_to_int_up(arg0: u256) : u64 {
        (0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::div_up(arg0, 1000000000000000000) as u64)
    }

    public fun convert_int_to_fixed(arg0: u64) : u256 {
        0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::mul((arg0 as u256), 1000000000000000000)
    }

    public fun from_fraction(arg0: u64, arg1: u64) : u256 {
        div_down(convert_int_to_fixed(arg0), convert_int_to_fixed(arg1))
    }

    public fun mul_down(arg0: u256, arg1: u256) : u256 {
        0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::div_down(0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::mul(arg0, arg1), 1000000000000000000)
    }

    public fun mul_up(arg0: u256, arg1: u256) : u256 {
        0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::div_up(0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::i256::mul(arg0, arg1), 1000000000000000000)
    }

    // decompiled from Move bytecode v6
}

