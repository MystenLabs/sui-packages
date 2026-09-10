module 0x27ea255116c73dd78d634d1c54fdb47004d6d83724ddf6fbf33f74d1a686e95::reader {
    public fun current<T0, T1>(arg0: &0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>) : (u64, u64, u64, u64, u64, u64, u64, u64, bool, bool) {
        let v0 = 0x1::bcs::to_bytes<0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>>(arg0);
        assert!(0x1::vector::length<u8>(&v0) <= 65536, 930);
        let v1 = 0x2::bcs::new(v0);
        0x2::bcs::peel_address(&mut v1);
        0x2::bcs::peel_u128(&mut v1);
        0x2::bcs::peel_address(&mut v1);
        0x2::bcs::peel_address(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        let v2 = 0x2::bcs::peel_vec_length(&mut v1);
        assert!(v2 <= 4096, 930);
        let v3 = 0;
        while (v3 < v2) {
            0x2::bcs::peel_u64(&mut v1);
            v3 = v3 + 1;
        };
        let v4 = 0x2::bcs::peel_vec_length(&mut v1);
        assert!(v4 <= 4096, 930);
        v3 = 0;
        while (v3 < v4) {
            0x2::bcs::peel_u64(&mut v1);
            v3 = v3 + 1;
        };
        0x2::bcs::peel_u64(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        let v5 = 0x2::bcs::into_remainder_bytes(v1);
        assert!(0x1::vector::is_empty<u8>(&v5), 930);
        (0x2::bcs::peel_u64(&mut v1), 0x2::bcs::peel_u64(&mut v1), 0x2::bcs::peel_u64(&mut v1), 0x2::bcs::peel_u64(&mut v1), 0x2::bcs::peel_u64(&mut v1), 0x2::bcs::peel_u64(&mut v1), 0x2::bcs::peel_u64(&mut v1), 0x2::bcs::peel_u64(&mut v1), 0x2::bcs::peel_bool(&mut v1), 0x2::bcs::peel_bool(&mut v1))
    }

    public fun pair_bcs<T0, T1>(arg0: &0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>) : vector<u8> {
        0x1::bcs::to_bytes<0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>>(arg0)
    }

    // decompiled from Move bytecode v7
}

