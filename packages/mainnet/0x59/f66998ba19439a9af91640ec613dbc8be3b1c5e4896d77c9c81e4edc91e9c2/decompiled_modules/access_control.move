module 0x59f66998ba19439a9af91640ec613dbc8be3b1c5e4896d77c9c81e4edc91e9c2::access_control {
    entry fun seal_approve(arg0: vector<u8>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0 && 0x2::clock::timestamp_ms(arg1) >= 0x2::bcs::peel_u64(&mut v0), 0);
    }

    entry fun seal_approve_all(arg0: vector<u8>) {
        0x2::bcs::into_remainder_bytes(0x2::bcs::new(arg0));
    }

    // decompiled from Move bytecode v6
}

