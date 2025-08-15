module 0x5f69c73f537317b25c13fa1f1919f9c01fe8305d8e09dcf1bc0964ba2191e96b::access_control {
    entry fun seal_approve(arg0: vector<u8>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0 && 0x2::clock::timestamp_ms(arg1) >= 0x2::bcs::peel_u64(&mut v0), 0);
    }

    // decompiled from Move bytecode v6
}

