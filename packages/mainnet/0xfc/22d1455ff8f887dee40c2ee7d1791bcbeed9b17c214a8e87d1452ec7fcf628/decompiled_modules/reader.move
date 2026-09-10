module 0xfc22d1455ff8f887dee40c2ee7d1791bcbeed9b17c214a8e87d1452ec7fcf628::reader {
    public fun current(arg0: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : (u64, u64, u64, u64, bool, bool) {
        let v0 = 0x1::bcs::to_bytes<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg0);
        let (v1, v2) = decode_pause_flags(&v0);
        (0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_total_sui(arg0), 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_stsui_supply(arg0), 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::config::get_service_fee(0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_config(arg0)), 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_sui_vault_amount(arg0), v1, v2)
    }

    fun decode_pause_flags(arg0: &vector<u8>) : (bool, bool) {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 <= 65536, 1);
        let v1 = 0;
        let v2 = &mut v1;
        skip(v2, 288, v0);
        let v3 = &mut v1;
        let v4 = read_uleb128(arg0, v3);
        assert!(v4 <= 4096, 1);
        let v5 = &mut v1;
        skip(v5, v4 * 17, v0);
        let v6 = &mut v1;
        skip(v6, 56, v0);
        let v7 = &mut v1;
        let v8 = &mut v1;
        (read_bool(arg0, v7), read_bool(arg0, v8))
    }

    public fun pool_bcs(arg0: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : vector<u8> {
        0x1::bcs::to_bytes<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg0)
    }

    fun read_bool(arg0: &vector<u8>, arg1: &mut u64) : bool {
        let v0 = read_u8(arg0, arg1);
        assert!(v0 <= 1, 1);
        v0 == 1
    }

    fun read_u8(arg0: &vector<u8>, arg1: &mut u64) : u8 {
        assert!(*arg1 < 0x1::vector::length<u8>(arg0), 1);
        *arg1 = *arg1 + 1;
        *0x1::vector::borrow<u8>(arg0, *arg1)
    }

    fun read_uleb128(arg0: &vector<u8>, arg1: &mut u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3;
        loop {
            assert!(v2 < 5, 1);
            let v4 = read_u8(arg0, arg1);
            v3 = ((v4 & 127) as u64) << (v1 as u8);
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

    // decompiled from Move bytecode v7
}

