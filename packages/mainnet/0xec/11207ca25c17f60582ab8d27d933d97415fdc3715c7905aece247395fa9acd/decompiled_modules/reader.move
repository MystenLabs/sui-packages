module 0xec11207ca25c17f60582ab8d27d933d97415fdc3715c7905aece247395fa9acd::reader {
    public fun current<T0, T1>(arg0: &0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>) : (u64, u64, u64, u64, u64, u64, u64, u64, bool, bool) {
        let v0 = 0x1::bcs::to_bytes<0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>>(arg0);
        assert!(0x1::vector::length<u8>(&v0) <= 65536, 930);
        let v1 = 0xec11207ca25c17f60582ab8d27d933d97415fdc3715c7905aece247395fa9acd::cursor::new(v0);
        0xec11207ca25c17f60582ab8d27d933d97415fdc3715c7905aece247395fa9acd::cursor::skip(&mut v1, 32);
        0xec11207ca25c17f60582ab8d27d933d97415fdc3715c7905aece247395fa9acd::cursor::skip(&mut v1, 16);
        0xec11207ca25c17f60582ab8d27d933d97415fdc3715c7905aece247395fa9acd::cursor::skip(&mut v1, 88);
        let v2 = 0xec11207ca25c17f60582ab8d27d933d97415fdc3715c7905aece247395fa9acd::cursor::length(&mut v1);
        assert!(v2 <= 4096, 930);
        0xec11207ca25c17f60582ab8d27d933d97415fdc3715c7905aece247395fa9acd::cursor::skip(&mut v1, v2 * 8);
        let v3 = 0xec11207ca25c17f60582ab8d27d933d97415fdc3715c7905aece247395fa9acd::cursor::length(&mut v1);
        assert!(v3 <= 4096, 930);
        0xec11207ca25c17f60582ab8d27d933d97415fdc3715c7905aece247395fa9acd::cursor::skip(&mut v1, v3 * 8);
        0xec11207ca25c17f60582ab8d27d933d97415fdc3715c7905aece247395fa9acd::cursor::skip(&mut v1, 16);
        assert!(0xec11207ca25c17f60582ab8d27d933d97415fdc3715c7905aece247395fa9acd::cursor::is_empty(&v1), 930);
        (0xec11207ca25c17f60582ab8d27d933d97415fdc3715c7905aece247395fa9acd::cursor::read_u64(&mut v1), 0xec11207ca25c17f60582ab8d27d933d97415fdc3715c7905aece247395fa9acd::cursor::read_u64(&mut v1), 0xec11207ca25c17f60582ab8d27d933d97415fdc3715c7905aece247395fa9acd::cursor::read_u64(&mut v1), 0xec11207ca25c17f60582ab8d27d933d97415fdc3715c7905aece247395fa9acd::cursor::read_u64(&mut v1), 0xec11207ca25c17f60582ab8d27d933d97415fdc3715c7905aece247395fa9acd::cursor::read_u64(&mut v1), 0xec11207ca25c17f60582ab8d27d933d97415fdc3715c7905aece247395fa9acd::cursor::read_u64(&mut v1), 0xec11207ca25c17f60582ab8d27d933d97415fdc3715c7905aece247395fa9acd::cursor::read_u64(&mut v1), 0xec11207ca25c17f60582ab8d27d933d97415fdc3715c7905aece247395fa9acd::cursor::read_u64(&mut v1), 0xec11207ca25c17f60582ab8d27d933d97415fdc3715c7905aece247395fa9acd::cursor::boolean(&mut v1), 0xec11207ca25c17f60582ab8d27d933d97415fdc3715c7905aece247395fa9acd::cursor::boolean(&mut v1))
    }

    public fun pair_bcs<T0, T1>(arg0: &0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>) : vector<u8> {
        0x1::bcs::to_bytes<0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>>(arg0)
    }

    // decompiled from Move bytecode v7
}

