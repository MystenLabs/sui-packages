module 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::nvc {
    public fun get_asset_id<T0>() : u8 {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::borrow_string(&v0);
        let v2 = 0x1::ascii::string(b"0x2::sui::SUI");
        if (v1 == &v2) {
            return 0
        };
        let v3 = 0x1::ascii::string(b"0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN");
        if (v1 == &v3) {
            return 1
        };
        let v4 = 0x1::ascii::string(b"0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN");
        if (v1 == &v4) {
            return 2
        };
        let v5 = 0x1::ascii::string(b"0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT");
        if (v1 == &v5) {
            return 5
        };
        let v6 = 0x1::ascii::string(b"0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI");
        if (v1 == &v6) {
            return 6
        };
        let v7 = 0x1::ascii::string(b"0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN");
        if (v1 == &v7) {
            return 3
        };
        let v8 = 0x1::ascii::string(b"0x06864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS");
        if (v1 == &v8) {
            return 4
        };
        let v9 = 0x1::ascii::string(b"0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX");
        assert!(v1 == &v9, 20);
        7
    }

    public fun validate_sender(arg0: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg0) != @0x3d3f9909d036722a12753a660a84d2b75ef8a3e77fa887d02d87788271caa828) {
            abort 10
        };
    }

    // decompiled from Move bytecode v6
}

