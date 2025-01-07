module 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount {
    struct NormalizedAmount has copy, drop, store {
        value: u64,
    }

    public fun cap_decimals(arg0: u8) : u8 {
        if (arg0 > 8) {
            8
        } else {
            arg0
        }
    }

    public fun default() : NormalizedAmount {
        new(0)
    }

    public fun from_raw(arg0: u64, arg1: u8) : NormalizedAmount {
        if (arg0 == 0) {
            default()
        } else if (arg1 > 8) {
            new(arg0 / 0x2::math::pow(10, arg1 - 8))
        } else {
            new(arg0)
        }
    }

    public fun max_decimals() : u8 {
        8
    }

    fun new(arg0: u64) : NormalizedAmount {
        NormalizedAmount{value: arg0}
    }

    public fun take_bytes(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::Cursor<u8>) : NormalizedAmount {
        new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::to_u64_be(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::take_bytes(arg0)))
    }

    fun take_value(arg0: NormalizedAmount) : u64 {
        let NormalizedAmount { value: v0 } = arg0;
        v0
    }

    public fun to_bytes(arg0: NormalizedAmount) : vector<u8> {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::to_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::from_u256_be(to_u256(arg0)))
    }

    public fun to_raw(arg0: NormalizedAmount, arg1: u8) : u64 {
        let v0 = take_value(arg0);
        if (v0 > 0 && arg1 > 8) {
            v0 * 0x2::math::pow(10, arg1 - 8)
        } else {
            v0
        }
    }

    public fun to_u256(arg0: NormalizedAmount) : u256 {
        (take_value(arg0) as u256)
    }

    public fun value(arg0: &NormalizedAmount) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

