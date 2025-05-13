module 0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::navi_adaptor {
    public fun calculate_navi_position_value(arg0: address, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault_oracle::OracleConfig, arg3: &0x2::clock::Clock) : u256 {
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_reserves_count(arg1);
        let v1 = 0;
        let v2 = 0;
        while (v0 > 0) {
            let (v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg1, v0 - 1, arg0);
            let v5 = 0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault_oracle::get_asset_price(arg2, arg3, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg1, v0 - 1));
            v1 = v1 + 0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault_utils::mul_with_oracle_price((v3 as u256), v5);
            v2 = v2 + 0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::vault_utils::mul_with_oracle_price((v4 as u256), v5);
            v0 = v0 - 1;
        };
        v1 - v2
    }

    // decompiled from Move bytecode v6
}

