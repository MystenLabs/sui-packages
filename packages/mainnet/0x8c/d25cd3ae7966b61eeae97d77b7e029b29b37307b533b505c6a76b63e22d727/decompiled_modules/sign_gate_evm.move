module 0x8cd25cd3ae7966b61eeae97d77b7e029b29b37307b533b505c6a76b63e22d727::sign_gate_evm {
    struct EvmDecoded has copy, drop {
        vault_id: 0x2::object::ID,
        tx_type: u8,
        to: vector<u8>,
        value_wei: u128,
        value_micros: u64,
        price_micros_per_eth: u64,
    }

    fun decode_eth_tx(arg0: &vector<u8>) : (u8, vector<u8>, u128) {
        assert!(0x1::vector::length<u8>(arg0) >= 1, 102);
        let v0 = *0x1::vector::borrow<u8>(arg0, 0);
        let (v1, v2, v3, v4) = if (v0 == 2) {
            (2, 1, 5, 6)
        } else if (v0 == 1) {
            (1, 1, 4, 5)
        } else if (v0 >= 192) {
            (255, 0, 3, 4)
        } else {
            assert!(v0 >= 1 && v0 < 128, 100);
            abort 101
        };
        let (v5, _, v7) = read_rlp_header(arg0, v2);
        assert!(v5, 100);
        let v8 = v7;
        let v9 = 0;
        while (v9 < v3) {
            v8 = skip_rlp_item(arg0, v8);
            v9 = v9 + 1;
        };
        let v10 = read_rlp_string(arg0, v8);
        v8 = skip_rlp_item(arg0, v8);
        v9 = v3 + 1;
        while (v9 < v4) {
            v8 = skip_rlp_item(arg0, v8);
            v9 = v9 + 1;
        };
        (v1, v10, read_rlp_uint128(arg0, v8))
    }

    public fun decode_eth_tx_for_testing(arg0: vector<u8>) : (u8, vector<u8>, u128) {
        decode_eth_tx(&arg0)
    }

    fun read_rlp_header(arg0: &vector<u8>, arg1: u64) : (bool, u64, u64) {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(arg1 < v0, 102);
        let v1 = *0x1::vector::borrow<u8>(arg0, arg1);
        if (v1 < 128) {
            (false, 1, arg1)
        } else if (v1 < 184) {
            (false, (v1 as u64) - 128, arg1 + 1)
        } else if (v1 < 192) {
            let v5 = (v1 as u64) - 183;
            assert!(arg1 + 1 + v5 <= v0, 102);
            let v6 = 0;
            let v7 = 0;
            while (v7 < v5) {
                let v8 = v6 << 8;
                v6 = v8 | (*0x1::vector::borrow<u8>(arg0, arg1 + 1 + v7) as u64);
                v7 = v7 + 1;
            };
            (false, v6, arg1 + 1 + v5)
        } else if (v1 < 248) {
            (true, (v1 as u64) - 192, arg1 + 1)
        } else {
            let v9 = (v1 as u64) - 247;
            assert!(arg1 + 1 + v9 <= v0, 102);
            let v10 = 0;
            let v11 = 0;
            while (v11 < v9) {
                let v12 = v10 << 8;
                v10 = v12 | (*0x1::vector::borrow<u8>(arg0, arg1 + 1 + v11) as u64);
                v11 = v11 + 1;
            };
            (true, v10, arg1 + 1 + v9)
        }
    }

    fun read_rlp_string(arg0: &vector<u8>, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(arg1 < v0, 102);
        let v1 = *0x1::vector::borrow<u8>(arg0, arg1);
        if (v1 < 128) {
            let v3 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v3, v1);
            v3
        } else {
            let (v4, v5, v6) = read_rlp_header(arg0, arg1);
            assert!(!v4, 104);
            assert!(v6 + v5 <= v0, 102);
            let v7 = 0x1::vector::empty<u8>();
            let v8 = 0;
            while (v8 < v5) {
                0x1::vector::push_back<u8>(&mut v7, *0x1::vector::borrow<u8>(arg0, v6 + v8));
                v8 = v8 + 1;
            };
            v7
        }
    }

    fun read_rlp_uint128(arg0: &vector<u8>, arg1: u64) : u128 {
        let v0 = read_rlp_string(arg0, arg1);
        let v1 = 0x1::vector::length<u8>(&v0);
        assert!(v1 <= 16, 103);
        let v2 = 0;
        let v3 = 0;
        while (v3 < v1) {
            let v4 = v2 << 8;
            v2 = v4 | (*0x1::vector::borrow<u8>(&v0, v3) as u128);
            v3 = v3 + 1;
        };
        v2
    }

    public fun sign_evm_with_policy(arg0: &mut 0x8cd25cd3ae7966b61eeae97d77b7e029b29b37307b533b505c6a76b63e22d727::sign_gate::PolicyVault, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap, arg3: vector<u8>, arg4: u64, arg5: u32, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1, v2) = decode_eth_tx(&arg3);
        let v3 = wei_to_micros_usd(v2, arg4);
        let v4 = EvmDecoded{
            vault_id             : 0x2::object::id<0x8cd25cd3ae7966b61eeae97d77b7e029b29b37307b533b505c6a76b63e22d727::sign_gate::PolicyVault>(arg0),
            tx_type              : v0,
            to                   : v1,
            value_wei            : v2,
            value_micros         : v3,
            price_micros_per_eth : arg4,
        };
        0x2::event::emit<EvmDecoded>(v4);
        0x8cd25cd3ae7966b61eeae97d77b7e029b29b37307b533b505c6a76b63e22d727::sign_gate::sign_with_policy(arg0, arg1, arg2, arg3, v3, arg5, arg6, arg7, arg8)
    }

    fun skip_rlp_item(arg0: &vector<u8>, arg1: u64) : u64 {
        assert!(arg1 < 0x1::vector::length<u8>(arg0), 102);
        if (*0x1::vector::borrow<u8>(arg0, arg1) < 128) {
            arg1 + 1
        } else {
            let (_, v2, v3) = read_rlp_header(arg0, arg1);
            v3 + v2
        }
    }

    fun wei_to_micros_usd(arg0: u128, arg1: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        if (arg1 == 0) {
            return 0
        };
        let v0 = (arg0 as u256) * (arg1 as u256) / 1000000000000000000;
        if (v0 > 18446744073709551615) {
            return (18446744073709551615 as u64)
        };
        (v0 as u64)
    }

    public fun wei_to_micros_usd_for_testing(arg0: u128, arg1: u64) : u64 {
        wei_to_micros_usd(arg0, arg1)
    }

    // decompiled from Move bytecode v7
}

