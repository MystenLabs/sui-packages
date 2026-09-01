module 0xc470410a4790a5a4a5af09599e3ffb5b2ed47433e265ce6f19c7160ab9ebb266::bps {
    struct BPS has copy, drop, store {
        pos0: u16,
    }

    public fun add(arg0: BPS, arg1: BPS) : BPS {
        let BPS { pos0: v0 } = arg0;
        let BPS { pos0: v1 } = arg1;
        let v2 = v0 + v1;
        assert!(v2 <= 10000, 0);
        BPS{pos0: v2}
    }

    public fun apply(arg0: BPS, arg1: u64) : u64 {
        let BPS { pos0: v0 } = arg0;
        (((arg1 as u128) * (v0 as u128) / 10000) as u64)
    }

    public fun apply_ceil(arg0: BPS, arg1: u64) : u64 {
        let BPS { pos0: v0 } = arg0;
        ((((arg1 as u128) * (v0 as u128) + 9999) / 10000) as u64)
    }

    public fun apply_ceil_u128(arg0: BPS, arg1: u128) : u128 {
        let BPS { pos0: v0 } = arg0;
        ((((arg1 as u256) * (v0 as u256) + 9999) / 10000) as u128)
    }

    public fun apply_ceil_u16(arg0: BPS, arg1: u16) : u16 {
        let BPS { pos0: v0 } = arg0;
        ((((arg1 as u32) * (v0 as u32) + 9999) / 10000) as u16)
    }

    public fun apply_ceil_u256(arg0: BPS, arg1: u256) : u256 {
        let BPS { pos0: v0 } = arg0;
        let v1 = (v0 as u256);
        arg1 / 10000 * v1 + (arg1 % 10000 * v1 + 9999) / 10000
    }

    public fun apply_ceil_u32(arg0: BPS, arg1: u32) : u32 {
        let BPS { pos0: v0 } = arg0;
        ((((arg1 as u64) * (v0 as u64) + 9999) / 10000) as u32)
    }

    public fun apply_ceil_u8(arg0: BPS, arg1: u8) : u8 {
        let BPS { pos0: v0 } = arg0;
        ((((arg1 as u32) * (v0 as u32) + 9999) / 10000) as u8)
    }

    public fun apply_u128(arg0: BPS, arg1: u128) : u128 {
        let BPS { pos0: v0 } = arg0;
        (((arg1 as u256) * (v0 as u256) / 10000) as u128)
    }

    public fun apply_u16(arg0: BPS, arg1: u16) : u16 {
        let BPS { pos0: v0 } = arg0;
        (((arg1 as u32) * (v0 as u32) / 10000) as u16)
    }

    public fun apply_u256(arg0: BPS, arg1: u256) : u256 {
        let BPS { pos0: v0 } = arg0;
        let v1 = (v0 as u256);
        arg1 / 10000 * v1 + arg1 % 10000 * v1 / 10000
    }

    public fun apply_u32(arg0: BPS, arg1: u32) : u32 {
        let BPS { pos0: v0 } = arg0;
        (((arg1 as u64) * (v0 as u64) / 10000) as u32)
    }

    public fun apply_u8(arg0: BPS, arg1: u8) : u8 {
        let BPS { pos0: v0 } = arg0;
        (((arg1 as u32) * (v0 as u32) / 10000) as u8)
    }

    public fun complement(arg0: BPS) : BPS {
        let BPS { pos0: v0 } = arg0;
        BPS{pos0: 10000 - v0}
    }

    public fun from_percent(arg0: u8) : BPS {
        assert!(arg0 <= 100, 0);
        BPS{pos0: (arg0 as u16) * 100}
    }

    public fun is_max(arg0: BPS) : bool {
        let BPS { pos0: v0 } = arg0;
        v0 == 10000
    }

    public fun is_zero(arg0: BPS) : bool {
        let BPS { pos0: v0 } = arg0;
        v0 == 0
    }

    public fun max() : BPS {
        BPS{pos0: 10000}
    }

    public fun new(arg0: u16) : BPS {
        assert!(arg0 <= 10000, 0);
        BPS{pos0: arg0}
    }

    public fun split(arg0: BPS, arg1: u64) : (u64, u64) {
        let BPS { pos0: v0 } = arg0;
        let v1 = (((arg1 as u128) * (v0 as u128) / 10000) as u64);
        (v1, arg1 - v1)
    }

    public fun split_u128(arg0: BPS, arg1: u128) : (u128, u128) {
        let BPS { pos0: v0 } = arg0;
        let v1 = (((arg1 as u256) * (v0 as u256) / 10000) as u128);
        (v1, arg1 - v1)
    }

    public fun split_u16(arg0: BPS, arg1: u16) : (u16, u16) {
        let BPS { pos0: v0 } = arg0;
        let v1 = (((arg1 as u32) * (v0 as u32) / 10000) as u16);
        (v1, arg1 - v1)
    }

    public fun split_u256(arg0: BPS, arg1: u256) : (u256, u256) {
        let BPS { pos0: v0 } = arg0;
        let v1 = (v0 as u256);
        let v2 = arg1 / 10000 * v1 + arg1 % 10000 * v1 / 10000;
        (v2, arg1 - v2)
    }

    public fun split_u32(arg0: BPS, arg1: u32) : (u32, u32) {
        let BPS { pos0: v0 } = arg0;
        let v1 = (((arg1 as u64) * (v0 as u64) / 10000) as u32);
        (v1, arg1 - v1)
    }

    public fun split_u8(arg0: BPS, arg1: u8) : (u8, u8) {
        let BPS { pos0: v0 } = arg0;
        let v1 = (((arg1 as u32) * (v0 as u32) / 10000) as u8);
        (v1, arg1 - v1)
    }

    public fun sub(arg0: BPS, arg1: BPS) : BPS {
        let BPS { pos0: v0 } = arg0;
        let BPS { pos0: v1 } = arg1;
        assert!(v0 >= v1, 1);
        BPS{pos0: v0 - v1}
    }

    public fun value(arg0: BPS) : u16 {
        let BPS { pos0: v0 } = arg0;
        v0
    }

    public fun zero() : BPS {
        BPS{pos0: 0}
    }

    // decompiled from Move bytecode v7
}

