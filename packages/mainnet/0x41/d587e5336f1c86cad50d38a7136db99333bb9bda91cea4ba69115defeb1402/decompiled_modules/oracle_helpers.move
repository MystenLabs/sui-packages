module 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_helpers {
    public(friend) fun calculate_usd_price_internal(arg0: u64, arg1: u8, arg2: u8) : u64 {
        assert!(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::constants::oracle_buffer() + arg2 > arg1, 13835339607568285697);
        let v0 = (arg0 as u128) * 0x1::u128::pow(10, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::constants::oracle_buffer() + arg2 - arg1) / 0x1::u128::pow(10, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::constants::oracle_buffer());
        assert!(v0 <= 18446744073709551615, 13835621121199833091);
        (v0 as u64)
    }

    public(friend) fun collateral_to_suiusde_amount(arg0: u64, arg1: u8, arg2: u64, arg3: u64) : u64 {
        let v0 = (arg0 as u256) * (arg2 as u256) * 0x1::u256::pow(10, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::constants::default_decimals()) / 0x1::u256::pow(10, arg1) * (arg3 as u256);
        assert!(v0 <= 18446744073709551615, 13835621262933753859);
        (v0 as u64)
    }

    public(friend) fun fee_adjusted_amount(arg0: u64, arg1: u16) : u64 {
        (((arg0 as u128) * ((10000 - (arg1 as u64)) as u128) / 10000) as u64)
    }

    public(friend) fun suiusde_to_collateral_amount(arg0: u64, arg1: u8, arg2: u64, arg3: u64) : u64 {
        let v0 = (arg0 as u256) * (arg3 as u256) * 0x1::u256::pow(10, arg1) / (arg2 as u256) * 0x1::u256::pow(10, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::constants::default_decimals());
        assert!(v0 <= 18446744073709551615, 13835621404667674627);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

