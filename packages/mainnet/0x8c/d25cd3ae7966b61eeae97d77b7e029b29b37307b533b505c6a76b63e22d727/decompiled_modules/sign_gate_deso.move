module 0x8cd25cd3ae7966b61eeae97d77b7e029b29b37307b533b505c6a76b63e22d727::sign_gate_deso {
    struct DeSoDecoded has copy, drop {
        vault_id: 0x2::object::ID,
        output_sum_nanos: u64,
        largest_output_nanos: u64,
        output_count: u64,
        value_micros: u64,
        price_micros_per_deso: u64,
    }

    fun decode_deso_v0_outputs(arg0: &vector<u8>) : (u64, u64, u64) {
        assert!(0x1::vector::length<u8>(arg0) >= 7, 300);
        let (v0, v1) = read_uvarint(arg0, 0);
        let v2 = v1;
        let v3 = 0;
        while (v3 < v0) {
            v2 = skip_tx_input(arg0, v2);
            v3 = v3 + 1;
        };
        let (v4, v5) = read_uvarint(arg0, v2);
        v2 = v2 + v5;
        let v6 = 0;
        let v7 = 0;
        let v8 = v7;
        let v9 = 0;
        while (v9 < v4) {
            let (v10, v11) = read_tx_output(arg0, v2);
            v2 = v2 + v11;
            v6 = v6 + (v10 as u256);
            if (v10 > v7) {
                v8 = v10;
            };
            v9 = v9 + 1;
        };
        let v12 = if (v6 > 18446744073709551615) {
            (18446744073709551615 as u64)
        } else {
            (v6 as u64)
        };
        (v12, v8, v4)
    }

    public fun decode_deso_v0_outputs_for_testing(arg0: vector<u8>) : (u64, u64, u64) {
        decode_deso_v0_outputs(&arg0)
    }

    fun nanos_to_micros_usd(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        if (arg1 == 0) {
            return 0
        };
        let v0 = (arg0 as u256) * (arg1 as u256) / 1000000000;
        if (v0 > 18446744073709551615) {
            return (18446744073709551615 as u64)
        };
        (v0 as u64)
    }

    public fun nanos_to_micros_usd_for_testing(arg0: u64, arg1: u64) : u64 {
        nanos_to_micros_usd(arg0, arg1)
    }

    fun read_tx_output(arg0: &vector<u8>, arg1: u64) : (u64, u64) {
        assert!(arg1 + 33 <= 0x1::vector::length<u8>(arg0), 301);
        let (v0, v1) = read_uvarint(arg0, arg1 + 33);
        (v0, 33 + v1)
    }

    fun read_uvarint(arg0: &vector<u8>, arg1: u64) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        loop {
            assert!(arg1 + v2 < 0x1::vector::length<u8>(arg0), 301);
            assert!(v2 < 10, 302);
            let v3 = *0x1::vector::borrow<u8>(arg0, arg1 + v2);
            v0 = v0 | ((v3 & 127) as u64) << v1;
            v2 = v2 + 1;
            if (v3 < 128) {
                break
            };
            v1 = v1 + 7;
        };
        (v0, v2)
    }

    public fun reference_price_micros_per_deso_at_30_usd() : u64 {
        30000000
    }

    public fun sign_deso_with_policy(arg0: &mut 0x8cd25cd3ae7966b61eeae97d77b7e029b29b37307b533b505c6a76b63e22d727::sign_gate::PolicyVault, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap, arg3: vector<u8>, arg4: u64, arg5: u32, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1, v2) = decode_deso_v0_outputs(&arg3);
        let v3 = nanos_to_micros_usd(v0, arg4);
        let v4 = DeSoDecoded{
            vault_id              : 0x2::object::id<0x8cd25cd3ae7966b61eeae97d77b7e029b29b37307b533b505c6a76b63e22d727::sign_gate::PolicyVault>(arg0),
            output_sum_nanos      : v0,
            largest_output_nanos  : v1,
            output_count          : v2,
            value_micros          : v3,
            price_micros_per_deso : arg4,
        };
        0x2::event::emit<DeSoDecoded>(v4);
        0x8cd25cd3ae7966b61eeae97d77b7e029b29b37307b533b505c6a76b63e22d727::sign_gate::sign_with_policy(arg0, arg1, arg2, arg3, v3, arg5, arg6, arg7, arg8)
    }

    fun skip_tx_input(arg0: &vector<u8>, arg1: u64) : u64 {
        assert!(arg1 + 32 <= 0x1::vector::length<u8>(arg0), 301);
        let v0 = arg1 + 32;
        let (_, v2) = read_uvarint(arg0, v0);
        v0 + v2
    }

    // decompiled from Move bytecode v7
}

