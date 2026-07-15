module 0xb0d65560df1e72846e5bd7e8ce1368669f346c786158b658895370e50314ccec::tle {
    fun check_policy(arg0: vector<u8>, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        0x1::vector::length<u8>(&v1) == 0 && 0x2::clock::timestamp_ms(arg1) >= 0x2::bcs::peel_u64(&mut v0)
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &0x2::clock::Clock) {
        assert!(check_policy(arg0, arg1), 77);
    }

    // decompiled from Move bytecode v7
}

