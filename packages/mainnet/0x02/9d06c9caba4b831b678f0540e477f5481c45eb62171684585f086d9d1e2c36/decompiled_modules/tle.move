module 0x29d06c9caba4b831b678f0540e477f5481c45eb62171684585f086d9d1e2c36::tle {
    fun check_policy(arg0: vector<u8>, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        0x1::vector::length<u8>(&v1) == 0 && 0x2::clock::timestamp_ms(arg1) >= 0x2::bcs::peel_u64(&mut v0)
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &0x2::clock::Clock) {
        assert!(check_policy(arg0, arg1), 77);
    }

    // decompiled from Move bytecode v6
}

