module 0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::fungible_token_distributor {
    struct ClaimData has drop {
        claimable_timestamp: u64,
        claimable_amount: u64,
    }

    public entry fun claim<T0, T1>(arg0: &mut 0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::base_distributor::Distributor<T0>, arg1: &mut 0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::fee_collector::FeeCollectorConfig, arg2: vector<address>, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _, _, _, v5, _, _, _) = 0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::base_distributor::get_distributor_info<T0>(arg0);
        assert!(!v5, 8);
        let v9 = 0x1::vector::length<address>(&arg2);
        assert!(v9 > 0, 0);
        assert!(0x1::vector::length<vector<u8>>(&arg3) == v9, 0);
        assert!(0x1::vector::length<vector<u8>>(&arg4) == v9, 0);
        assert!(0x1::vector::length<vector<u8>>(&arg5) == v9, 0);
        let v10 = false;
        let v11 = 0;
        while (v11 < v9) {
            let v12 = *0x1::vector::borrow<address>(&arg2, v11);
            let v13 = *0x1::vector::borrow<vector<u8>>(&arg3, v11);
            let v14 = *0x1::vector::borrow<vector<u8>>(&arg4, v11);
            if (v12 != 0x2::tx_context::sender(arg8)) {
                v10 = true;
            };
            let v15 = decode_claim_data(v14);
            0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::base_distributor::verify_time_constraints<T0>(arg0, v15.claimable_timestamp, arg7);
            0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::base_distributor::verify(v1, 0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::base_distributor::encode_hash_to_be_signed<T0>(arg0, v12, v13, v14), *0x1::vector::borrow<vector<u8>>(&arg5, v11));
            0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::base_distributor::mark_claimed<T0>(arg0, v13);
            0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::base_distributor::send_tokens<T0>(arg0, v12, v15.claimable_amount, arg8);
            v11 = v11 + 1;
        };
        let v16 = if (v10) {
            v9
        } else {
            1
        };
        assert!(0x1::type_name::get<T1>() == 0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::fee_collector::get_fee_token(arg1, v0), 14);
        assert!(0x2::coin::value<T1>(&arg6) == 0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::fee_collector::get_fee(arg1, v0) * v16, 4);
        0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::fee_collector::collect_fee<T1>(arg1, arg6, arg8);
    }

    public fun decode_claim_data(arg0: vector<u8>) : ClaimData {
        assert!(0x1::vector::length<u8>(&arg0) == 16, 0);
        ClaimData{
            claimable_timestamp : read_u64_le(&arg0, 0),
            claimable_amount    : read_u64_le(&arg0, 8),
        }
    }

    fun read_u64_le(arg0: &vector<u8>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 8) {
            v0 = v0 + ((*0x1::vector::borrow<u8>(arg0, arg1 + v2) as u64) << v1);
            v1 = v1 + 8;
            v2 = v2 + 1;
        };
        v0
    }

    public fun version() : 0x1::string::String {
        0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::version::with_module(b"Fungible Token Distributor")
    }

    // decompiled from Move bytecode v6
}

