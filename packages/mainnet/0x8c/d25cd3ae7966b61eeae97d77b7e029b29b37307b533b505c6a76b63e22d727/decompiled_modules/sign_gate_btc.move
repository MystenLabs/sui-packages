module 0x8cd25cd3ae7966b61eeae97d77b7e029b29b37307b533b505c6a76b63e22d727::sign_gate_btc {
    struct BtcDecoded has copy, drop {
        vault_id: 0x2::object::ID,
        value_sats: u64,
        value_micros: u64,
        price_micros_per_satoshi: u64,
    }

    fun decode_btc_witness_v0_value(arg0: &vector<u8>) : u64 {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 >= 68 + 36 + 1 + 52, 200);
        let v1 = 68 + 36;
        let (v2, v3) = read_compact_size(arg0, v1);
        let v4 = v1 + v3 + v2;
        assert!(v4 + 52 <= v0, 200);
        read_u64_le(arg0, v4)
    }

    public fun decode_btc_witness_v0_value_for_testing(arg0: vector<u8>) : u64 {
        decode_btc_witness_v0_value(&arg0)
    }

    fun read_compact_size(arg0: &vector<u8>, arg1: u64) : (u64, u64) {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(arg1 < v0, 201);
        let v1 = *0x1::vector::borrow<u8>(arg0, arg1);
        if (v1 < 253) {
            ((v1 as u64), 1)
        } else if (v1 == 253) {
            assert!(arg1 + 3 <= v0, 201);
            ((*0x1::vector::borrow<u8>(arg0, arg1 + 1) as u64) | (*0x1::vector::borrow<u8>(arg0, arg1 + 2) as u64) << 8, 3)
        } else {
            assert!(v1 == 254, 202);
            assert!(arg1 + 5 <= v0, 201);
            ((*0x1::vector::borrow<u8>(arg0, arg1 + 1) as u64) | (*0x1::vector::borrow<u8>(arg0, arg1 + 2) as u64) << 8 | (*0x1::vector::borrow<u8>(arg0, arg1 + 3) as u64) << 16 | (*0x1::vector::borrow<u8>(arg0, arg1 + 4) as u64) << 24, 5)
        }
    }

    fun read_u64_le(arg0: &vector<u8>, arg1: u64) : u64 {
        assert!(arg1 + 8 <= 0x1::vector::length<u8>(arg0), 201);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            v0 = v0 | (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u64) << (v1 as u8) * 8;
            v1 = v1 + 1;
        };
        v0
    }

    public fun reference_price_micros_per_satoshi_at_50k_usd_per_btc() : u64 {
        500
    }

    fun sats_to_micros_usd(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        if (arg1 == 0) {
            return 0
        };
        let v0 = (arg0 as u256) * (arg1 as u256);
        if (v0 > 18446744073709551615) {
            return (18446744073709551615 as u64)
        };
        (v0 as u64)
    }

    public fun sats_to_micros_usd_for_testing(arg0: u64, arg1: u64) : u64 {
        sats_to_micros_usd(arg0, arg1)
    }

    public fun sign_btc_with_policy(arg0: &mut 0x8cd25cd3ae7966b61eeae97d77b7e029b29b37307b533b505c6a76b63e22d727::sign_gate::PolicyVault, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap, arg3: vector<u8>, arg4: u64, arg5: u32, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = decode_btc_witness_v0_value(&arg3);
        let v1 = sats_to_micros_usd(v0, arg4);
        let v2 = BtcDecoded{
            vault_id                 : 0x2::object::id<0x8cd25cd3ae7966b61eeae97d77b7e029b29b37307b533b505c6a76b63e22d727::sign_gate::PolicyVault>(arg0),
            value_sats               : v0,
            value_micros             : v1,
            price_micros_per_satoshi : arg4,
        };
        0x2::event::emit<BtcDecoded>(v2);
        0x8cd25cd3ae7966b61eeae97d77b7e029b29b37307b533b505c6a76b63e22d727::sign_gate::sign_with_policy(arg0, arg1, arg2, arg3, v1, arg5, arg6, arg7, arg8)
    }

    // decompiled from Move bytecode v7
}

