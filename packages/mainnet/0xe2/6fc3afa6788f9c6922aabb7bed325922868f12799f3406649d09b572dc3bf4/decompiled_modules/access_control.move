module 0xe26fc3afa6788f9c6922aabb7bed325922868f12799f3406649d09b572dc3bf4::access_control {
    entry fun seal_approve(arg0: vector<u8>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0 && 0x2::clock::timestamp_ms(arg1) >= 0x2::bcs::peel_u64(&mut v0), 0);
    }

    // decompiled from Move bytecode v6
}

