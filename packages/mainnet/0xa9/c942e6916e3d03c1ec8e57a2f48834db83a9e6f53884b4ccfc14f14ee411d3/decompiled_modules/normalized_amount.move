module 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::normalized_amount {
    struct NormalizedAmount has copy, drop, store {
        value: u64,
    }

    public fun take_bytes(arg0: &mut 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::cursor::Cursor<u8>) : NormalizedAmount {
        new(0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes32::to_u64_be(0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes32::take_bytes(arg0)))
    }

    public fun to_bytes(arg0: NormalizedAmount) : vector<u8> {
        0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes32::to_bytes(0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes32::from_u256_be(to_u256(arg0)))
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

    fun take_value(arg0: NormalizedAmount) : u64 {
        let NormalizedAmount { value: v0 } = arg0;
        v0
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

