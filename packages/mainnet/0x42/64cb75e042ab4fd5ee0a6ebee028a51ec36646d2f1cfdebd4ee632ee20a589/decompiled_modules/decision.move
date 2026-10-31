module 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::decision {
    public(friend) fun quote_amounts(arg0: vector<u8>, arg1: bool) : (u128, u128, u128) {
        assert!(0x1::vector::length<u8>(&arg0) == 148, 0);
        let v0 = 0x2::bcs::new(arg0);
        let (v1, v2) = if (arg1) {
            (0x2::bcs::peel_u128(&mut v0), 0x2::bcs::peel_u128(&mut v0))
        } else {
            (0x2::bcs::peel_u128(&mut v0), 0x2::bcs::peel_u128(&mut v0))
        };
        (v1, v2, 0x2::bcs::peel_u128(&mut v0))
    }

    public(friend) fun should_sell(arg0: u64, arg1: u128, arg2: u128, arg3: u128, arg4: u64) : bool {
        if (arg0 > 0) {
            if (arg1 == (arg0 as u128)) {
                if (arg3 == 0) {
                    if (arg2 > (arg4 as u128)) {
                        arg2 <= 18446744073709551615
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v7
}

