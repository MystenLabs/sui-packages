module 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::set_update_fee {
    struct UpdateFee {
        mantissa: u64,
        exponent: u64,
    }

    fun apply_exponent(arg0: u64, arg1: u8) : u64 {
        arg0 * 0x2::math::pow(10, arg1)
    }

    public(friend) fun execute(arg0: &0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::state::LatestOnly, arg1: &mut 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::state::State, arg2: vector<u8>) {
        let UpdateFee {
            mantissa : v0,
            exponent : v1,
        } = from_byte_vec(arg2);
        assert!(v1 <= 255, 0);
        0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::state::set_base_update_fee(arg0, arg1, apply_exponent(v0, (v1 as u8)));
    }

    fun from_byte_vec(arg0: vector<u8>) : UpdateFee {
        let v0 = 0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::cursor::new<u8>(arg0);
        0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::cursor::destroy_empty<u8>(v0);
        UpdateFee{
            mantissa : 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::deserialize::deserialize_u64(&mut v0),
            exponent : 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::deserialize::deserialize_u64(&mut v0),
        }
    }

    // decompiled from Move bytecode v6
}

