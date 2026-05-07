module 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::set_update_fee {
    struct UpdateFee {
        mantissa: u64,
        exponent: u64,
    }

    fun apply_exponent(arg0: u64, arg1: u8) : u64 {
        arg0 * 0x2::math::pow(10, arg1)
    }

    public(friend) fun execute(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::LatestOnly, arg1: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: vector<u8>) {
        let UpdateFee {
            mantissa : v0,
            exponent : v1,
        } = from_byte_vec(arg2);
        assert!(v1 <= 255, 0);
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::set_base_update_fee(arg0, arg1, apply_exponent(v0, (v1 as u8)));
    }

    fun from_byte_vec(arg0: vector<u8>) : UpdateFee {
        let v0 = 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::cursor::new<u8>(arg0);
        0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::cursor::destroy_empty<u8>(v0);
        UpdateFee{
            mantissa : 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::deserialize::deserialize_u64(&mut v0),
            exponent : 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::deserialize::deserialize_u64(&mut v0),
        }
    }

    // decompiled from Move bytecode v6
}

