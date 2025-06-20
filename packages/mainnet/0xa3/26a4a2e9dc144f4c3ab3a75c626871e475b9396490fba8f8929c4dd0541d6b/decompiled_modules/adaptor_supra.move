module 0xa326a4a2e9dc144f4c3ab3a75c626871e475b9396490fba8f8929c4dd0541d6b::adaptor_supra {
    public fun get_price_native(arg0: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg1: u32) : (u128, u16, u128) {
        let (v0, v1, v2, _) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg0, arg1);
        (v0, v1, v2)
    }

    public fun get_price_to_target_decimal(arg0: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg1: u32, arg2: u8) : (u256, u64) {
        let (v0, v1, v2) = get_price_native(arg0, arg1);
        (0xa326a4a2e9dc144f4c3ab3a75c626871e475b9396490fba8f8929c4dd0541d6b::oracle_utils::to_target_decimal_value_safe((v0 as u256), (v1 as u64), (arg2 as u64)), (v2 as u64))
    }

    public fun pair_id_to_vector(arg0: u32) : vector<u8> {
        0x2::address::to_bytes(0x2::address::from_u256((arg0 as u256)))
    }

    public fun vector_to_pair_id(arg0: vector<u8>) : u32 {
        (0x2::address::to_u256(0x2::address::from_bytes(arg0)) as u32)
    }

    // decompiled from Move bytecode v6
}

