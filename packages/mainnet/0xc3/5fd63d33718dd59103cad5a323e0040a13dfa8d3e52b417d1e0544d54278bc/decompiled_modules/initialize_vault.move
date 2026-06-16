module 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::initialize_vault {
    public fun run<T0>(arg0: &mut 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::state::Config, arg1: &0x2::coin::CoinMetadata<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: u64, arg5: u64, arg6: vector<u64>, arg7: vector<u64>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::state::assert_admin(arg0, 0x2::tx_context::sender(arg9));
        let v0 = 0x1::vector::length<u64>(&arg6);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::validate_tier_count(v0);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::validate_tier_count(0x1::vector::length<u64>(&arg7));
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::validate_fee(arg5);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::validate_asset_coin<T0>(arg2, arg3);
        let v1 = 0x1::vector::empty<0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::DistributionTier>();
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = *0x1::vector::borrow<u64>(&arg6, v3);
            v2 = v2 + v4;
            0x1::vector::push_back<0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::DistributionTier>(&mut v1, 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::new_tier(0x2::clock::timestamp_ms(arg8), *0x1::vector::borrow<u64>(&arg7, v3), v4));
            v3 = v3 + 1;
        };
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::validate_shares_sum(v2);
        let v5 = 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::state::bump_last_vault(arg0);
        let (v6, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg2, arg3);
        let v8 = 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::new<T0>(v5, arg3, 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg2), 0x2::coin::get_decimals<T0>(arg1), arg4, arg5, v1, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg9), 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::scale_index(v6), arg9);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::events::emit_vault_initialized(0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::id<T0>(&v8), v5, arg4, arg5);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::share<T0>(v8);
    }

    // decompiled from Move bytecode v7
}

