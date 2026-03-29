module 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::set_update_fee {
    struct UpdateFee {
        mantissa: u64,
        exponent: u64,
    }

    fun apply_exponent(arg0: u64, arg1: u8) : u64 {
        arg0 * 0x2::math::pow(10, arg1)
    }

    public(friend) fun execute(arg0: &0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::state::LatestOnly, arg1: &mut 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::state::State, arg2: vector<u8>) {
        let UpdateFee {
            mantissa : v0,
            exponent : v1,
        } = from_byte_vec(arg2);
        assert!(v1 <= 255, 0);
        0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::state::set_base_update_fee(arg0, arg1, apply_exponent(v0, (v1 as u8)));
    }

    fun from_byte_vec(arg0: vector<u8>) : UpdateFee {
        let v0 = 0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::cursor::new<u8>(arg0);
        0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::cursor::destroy_empty<u8>(v0);
        UpdateFee{
            mantissa : 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::deserialize::deserialize_u64(&mut v0),
            exponent : 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::deserialize::deserialize_u64(&mut v0),
        }
    }

    // decompiled from Move bytecode v6
}

