module 0x5dac9758fc4885e76fd6ef7ecdeaa867bb88c5c22048f080f43f8921e4a028e0::reader {
    public fun current(arg0: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool, arg1: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg2: &0x2::tx_context::TxContext) : (u64, u64, u64, u64, bool, u64) {
        let v0 = 0x1::bcs::to_bytes<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool>(arg0);
        let (v1, v2, v3, v4, v5, v6) = decode_pool(&v0);
        let v7 = 0x1::bcs::to_bytes<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>>(arg1);
        let v8 = decode_metadata(&v7);
        assert!(v4 >= v3 && v8 >= 157564800000000, 1);
        let v9 = v6 || v5 != 0x2::tx_context::epoch(arg2);
        (v4 - v3, v8 - 157564800000000, v1, v2, v9, 100000000)
    }

    fun decode_metadata(arg0: &vector<u8>) : u64 {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 <= 64, 1);
        let v1 = 0;
        let v2 = &mut v1;
        skip(v2, 40, v0);
        let v3 = &mut v1;
        assert!(v1 == v0, 1);
        read_u64_le(arg0, v3)
    }

    fun decode_pool(arg0: &vector<u8>) : (u64, u64, u64, u64, u64, bool) {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 <= 65536, 1);
        let v1 = 0;
        let v2 = &mut v1;
        skip(v2, 32, v0);
        let v3 = &mut v1;
        let v4 = &mut v1;
        let v5 = &mut v1;
        skip(v5, 56, v0);
        let v6 = &mut v1;
        skip(v6, 24, v0);
        let v7 = &mut v1;
        let v8 = &mut v1;
        skip(v8, 8, v0);
        let v9 = &mut v1;
        let v10 = read_uleb128(arg0, v9);
        assert!(v10 <= 1024, 1);
        let v11 = 0;
        while (v11 < v10) {
            let v12 = &mut v1;
            skip(v12, 64, v0);
            let v13 = &mut v1;
            skip_option(arg0, v13, 72, v0);
            let v14 = &mut v1;
            skip_option(arg0, v14, 80, v0);
            let v15 = &mut v1;
            skip(v15, 80, v0);
            v11 = v11 + 1;
        };
        let v16 = &mut v1;
        let v17 = &mut v1;
        let v18 = &mut v1;
        skip(v18, 8, v0);
        let v19 = &mut v1;
        skip(v19, 8, v0);
        let v20 = &mut v1;
        read_bool(arg0, v20);
        let v21 = &mut v1;
        skip(v21, 40, v0);
        let v22 = &mut v1;
        skip(v22, 8, v0);
        let v23 = &mut v1;
        let v24 = &mut v1;
        skip(v24, 40, v0);
        assert!(v1 == v0, 1);
        (read_u64_le(arg0, v3), read_u64_le(arg0, v4), read_u64_le(arg0, v7), read_u64_le(arg0, v16), read_u64_le(arg0, v17), read_bool(arg0, v23))
    }

    public fun metadata_bcs(arg0: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>) : vector<u8> {
        0x1::bcs::to_bytes<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>>(arg0)
    }

    public fun pool_bcs(arg0: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool) : vector<u8> {
        0x1::bcs::to_bytes<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool>(arg0)
    }

    fun read_at(arg0: &vector<u8>, arg1: u64) : u8 {
        assert!(arg1 < 0x1::vector::length<u8>(arg0), 1);
        *0x1::vector::borrow<u8>(arg0, arg1)
    }

    fun read_bool(arg0: &vector<u8>, arg1: &mut u64) : bool {
        let v0 = read_u8(arg0, arg1);
        assert!(v0 <= 1, 1);
        v0 == 1
    }

    fun read_u64_le(arg0: &vector<u8>, arg1: &mut u64) : u64 {
        skip(arg1, 8, 0x1::vector::length<u8>(arg0));
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            v0 = v0 | (read_at(arg0, *arg1 - 8 + v1) as u64) << ((v1 * 8) as u8);
            v1 = v1 + 1;
        };
        v0
    }

    fun read_u8(arg0: &vector<u8>, arg1: &mut u64) : u8 {
        *arg1 = *arg1 + 1;
        read_at(arg0, *arg1)
    }

    fun read_uleb128(arg0: &vector<u8>, arg1: &mut u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3;
        loop {
            assert!(v2 < 5, 1);
            let v4 = read_u8(arg0, arg1);
            v3 = ((v4 & 127) as u64) << v1;
            v0 = v0 | v3;
            v2 = v2 + 1;
            if (v4 & 128 == 0) {
                break
            };
            v1 = v1 + 7;
        };
        assert!(v2 == 1 || v3 != 0, 1);
        v0
    }

    fun skip(arg0: &mut u64, arg1: u64, arg2: u64) {
        assert!(*arg0 <= arg2 && arg1 <= arg2 - *arg0, 1);
        *arg0 = *arg0 + arg1;
    }

    fun skip_option(arg0: &vector<u8>, arg1: &mut u64, arg2: u64, arg3: u64) {
        let v0 = read_uleb128(arg0, arg1);
        assert!(v0 <= 1, 1);
        if (v0 == 1) {
            skip(arg1, arg2, arg3);
        };
    }

    // decompiled from Move bytecode v7
}

