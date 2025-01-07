module 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::price_data_pull {
    struct PriceData has copy, drop {
        pair_index: u32,
        value: u128,
        decimal: u16,
        timestamp: u128,
        round: u64,
    }

    public fun price_data_split(arg0: &PriceData) : (u32, u128, u16, u64) {
        (arg0.pair_index, arg0.value, arg0.decimal, arg0.round)
    }

    public fun verify_oracle_proof(arg0: &0x3a75968d0951fc99e7b336b26088d0f6888efd691b9cf2ac61c3958cfaa6d41b::validator::DkgState, arg1: &mut 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>, arg6: vector<vector<vector<u8>>>, arg7: vector<u64>, arg8: vector<vector<u8>>, arg9: vector<vector<vector<u8>>>, arg10: vector<vector<vector<u8>>>, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: vector<u8>, arg14: vector<vector<u8>>, arg15: vector<vector<u32>>, arg16: vector<vector<u128>>, arg17: vector<vector<u128>>, arg18: vector<vector<u16>>, arg19: vector<vector<u8>>, arg20: vector<u64>, arg21: vector<vector<u8>>, arg22: vector<u64>, arg23: vector<u64>, arg24: vector<u64>, arg25: vector<u64>, arg26: vector<u64>, arg27: vector<vector<u8>>, arg28: vector<vector<bool>>, arg29: &mut 0x2::tx_context::TxContext) : vector<PriceData> {
        0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::oracle_holder_version_check(arg1);
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 0x1::vector::length<vector<bool>>(&arg28), 11);
        0x3a75968d0951fc99e7b336b26088d0f6888efd691b9cf2ac61c3958cfaa6d41b::validator::validate_then_get_cluster_info_list(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27);
        let v0 = 0x1::vector::empty<PriceData>();
        while (!0x1::vector::is_empty<vector<bool>>(&arg28)) {
            let v1 = 0x1::vector::pop_back<vector<bool>>(&mut arg28);
            let v2 = 0x1::vector::pop_back<vector<u32>>(&mut arg15);
            let v3 = 0x1::vector::pop_back<vector<u128>>(&mut arg16);
            let v4 = 0x1::vector::pop_back<vector<u16>>(&mut arg18);
            let v5 = 0x1::vector::pop_back<vector<u128>>(&mut arg17);
            while (!0x1::vector::is_empty<bool>(&v1)) {
                let v6 = 0x1::vector::pop_back<u32>(&mut v2);
                if (0x1::vector::pop_back<bool>(&mut v1)) {
                    0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_oracle_holder_and_upsert_pair_data(arg1, v6, 0x1::vector::pop_back<u128>(&mut v3), 0x1::vector::pop_back<u16>(&mut v4), 0x1::vector::pop_back<u128>(&mut v5), 0x1::vector::pop_back<u64>(&mut arg20));
                    let (v7, v8, v9, v10) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg1, v6);
                    let v11 = PriceData{
                        pair_index : v6,
                        value      : v7,
                        decimal    : v8,
                        timestamp  : v9,
                        round      : v10,
                    };
                    0x1::vector::push_back<PriceData>(&mut v0, v11);
                };
            };
        };
        v0
    }

    // decompiled from Move bytecode v6
}

