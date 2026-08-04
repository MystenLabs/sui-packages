module 0xdb58d86a55daa5bc436f0f6056a651c9859da1b4f5785f9688b4c3e72ae1cfe0::bps {
    struct BPS has copy, drop, store {
        pos0: u16,
    }

    public fun add(arg0: BPS, arg1: BPS) : BPS {
        let v0 = arg0.pos0 + arg1.pos0;
        assert!(v0 <= 10000, 0);
        BPS{pos0: v0}
    }

    public fun apply(arg0: BPS, arg1: u64) : u64 {
        0x1::u64::mul_div(arg1, (arg0.pos0 as u64), (10000 as u64))
    }

    public fun apply_ceil(arg0: BPS, arg1: u64) : u64 {
        0x1::u64::mul_div_ceil(arg1, (arg0.pos0 as u64), (10000 as u64))
    }

    public fun apply_ceil_u128(arg0: BPS, arg1: u128) : u128 {
        0x1::u128::mul_div_ceil(arg1, (arg0.pos0 as u128), (10000 as u128))
    }

    public fun apply_ceil_u16(arg0: BPS, arg1: u16) : u16 {
        0x1::u16::mul_div_ceil(arg1, arg0.pos0, 10000)
    }

    public fun apply_ceil_u256(arg0: BPS, arg1: u256) : u256 {
        let v0 = arg1 * (arg0.pos0 as u256);
        let v1 = (10000 as u256);
        if (v0 % v1 == 0) {
            v0 / v1
        } else {
            v0 / v1 + 1
        }
    }

    public fun apply_ceil_u32(arg0: BPS, arg1: u32) : u32 {
        0x1::u32::mul_div_ceil(arg1, (arg0.pos0 as u32), (10000 as u32))
    }

    public fun apply_ceil_u8(arg0: BPS, arg1: u8) : u8 {
        (0x1::u16::mul_div_ceil((arg1 as u16), arg0.pos0, 10000) as u8)
    }

    public fun apply_u128(arg0: BPS, arg1: u128) : u128 {
        0x1::u128::mul_div(arg1, (arg0.pos0 as u128), (10000 as u128))
    }

    public fun apply_u16(arg0: BPS, arg1: u16) : u16 {
        0x1::u16::mul_div(arg1, arg0.pos0, 10000)
    }

    public fun apply_u256(arg0: BPS, arg1: u256) : u256 {
        arg1 * (arg0.pos0 as u256) / (10000 as u256)
    }

    public fun apply_u32(arg0: BPS, arg1: u32) : u32 {
        0x1::u32::mul_div(arg1, (arg0.pos0 as u32), (10000 as u32))
    }

    public fun apply_u8(arg0: BPS, arg1: u8) : u8 {
        (0x1::u16::mul_div((arg1 as u16), arg0.pos0, 10000) as u8)
    }

    public fun complement(arg0: BPS) : BPS {
        BPS{pos0: 10000 - arg0.pos0}
    }

    public fun from_percent(arg0: u8) : BPS {
        assert!(arg0 <= 100, 0);
        BPS{pos0: (arg0 as u16) * 100}
    }

    public fun is_max(arg0: BPS) : bool {
        arg0.pos0 == 10000
    }

    public fun is_zero(arg0: BPS) : bool {
        arg0.pos0 == 0
    }

    public fun max() : BPS {
        BPS{pos0: 10000}
    }

    public fun new(arg0: u16) : BPS {
        assert!(arg0 <= 10000, 0);
        BPS{pos0: arg0}
    }

    public fun split(arg0: BPS, arg1: u64) : (u64, u64) {
        let v0 = apply(arg0, arg1);
        (v0, arg1 - v0)
    }

    public fun split_u128(arg0: BPS, arg1: u128) : (u128, u128) {
        let v0 = apply_u128(arg0, arg1);
        (v0, arg1 - v0)
    }

    public fun split_u16(arg0: BPS, arg1: u16) : (u16, u16) {
        let v0 = apply_u16(arg0, arg1);
        (v0, arg1 - v0)
    }

    public fun split_u256(arg0: BPS, arg1: u256) : (u256, u256) {
        let v0 = apply_u256(arg0, arg1);
        (v0, arg1 - v0)
    }

    public fun split_u32(arg0: BPS, arg1: u32) : (u32, u32) {
        let v0 = apply_u32(arg0, arg1);
        (v0, arg1 - v0)
    }

    public fun split_u8(arg0: BPS, arg1: u8) : (u8, u8) {
        let v0 = apply_u8(arg0, arg1);
        (v0, arg1 - v0)
    }

    public fun sub(arg0: BPS, arg1: BPS) : BPS {
        assert!(arg0.pos0 >= arg1.pos0, 1);
        BPS{pos0: arg0.pos0 - arg1.pos0}
    }

    public fun value(arg0: BPS) : u16 {
        arg0.pos0
    }

    public fun zero() : BPS {
        BPS{pos0: 0}
    }

    // decompiled from Move bytecode v7
}

