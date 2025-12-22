module 0x1ebc04848010055d4fa2ce89db6ac80cb73de60c1270b6ffc8f8fe282cf82046::access_policy {
    entry fun seal_approve_owner(arg0: vector<u8>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(arg0);
        assert!(0x2::bcs::peel_u8(&mut v0) == 0, 2);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 2);
        assert!(0x2::tx_context::sender(arg1) == 0x2::bcs::peel_address(&mut v0), 1);
    }

    entry fun seal_approve_owner_or_timelock(arg0: vector<u8>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_u8(&mut v0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 2);
        if (0x2::tx_context::sender(arg2) == 0x2::bcs::peel_address(&mut v0)) {
            return
        };
        assert!(0x2::clock::timestamp_ms(arg1) >= 0x2::bcs::peel_u64(&mut v0), 1);
    }

    entry fun seal_approve_public(arg0: vector<u8>) {
        let v0 = 0x2::bcs::new(arg0);
        assert!(0x2::bcs::peel_u8(&mut v0) == 2, 2);
        0x2::bcs::into_remainder_bytes(v0);
    }

    entry fun seal_approve_timelock(arg0: vector<u8>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::bcs::new(arg0);
        assert!(0x2::bcs::peel_u8(&mut v0) == 1, 2);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 2);
        assert!(0x2::clock::timestamp_ms(arg1) >= 0x2::bcs::peel_u64(&mut v0), 3);
    }

    // decompiled from Move bytecode v6
}

