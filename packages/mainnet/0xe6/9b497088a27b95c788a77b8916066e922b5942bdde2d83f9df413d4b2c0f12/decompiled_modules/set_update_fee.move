module 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::set_update_fee {
    struct UpdateFee {
        mantissa: u64,
        exponent: u64,
    }

    fun apply_exponent(arg0: u64, arg1: u8) : u64 {
        arg0 * 0x2::math::pow(10, arg1)
    }

    public(friend) fun execute(arg0: &0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::state::LatestOnly, arg1: &mut 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::state::State, arg2: vector<u8>) {
        let UpdateFee {
            mantissa : v0,
            exponent : v1,
        } = from_byte_vec(arg2);
        assert!(v1 <= 255, 0);
        0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::state::set_base_update_fee(arg0, arg1, apply_exponent(v0, (v1 as u8)));
    }

    fun from_byte_vec(arg0: vector<u8>) : UpdateFee {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        UpdateFee{
            mantissa : 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::deserialize::deserialize_u64(&mut v0),
            exponent : 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::deserialize::deserialize_u64(&mut v0),
        }
    }

    // decompiled from Move bytecode v6
}

