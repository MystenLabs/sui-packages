module 0xdaeecd2df440aea862e502734be69e9fd9a75aa18b4982a5110792882ad88319::navi_adaptor {
    struct TestNum3 has copy, drop {
        test: 0x1::ascii::String,
    }

    public fun calculate_navi_position_value(arg0: address, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xdaeecd2df440aea862e502734be69e9fd9a75aa18b4982a5110792882ad88319::vault_oracle::OracleConfig, arg3: &0x2::clock::Clock) : u256 {
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_reserves_count(arg1);
        let v1 = 0;
        let v2 = 0;
        while (v0 > 0) {
            let (v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg1, v0 - 1, arg0);
            if (v3 == 0 && v4 == 0) {
                v0 = v0 - 1;
                continue
            };
            let (v5, v6) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg1, v0 - 1);
            let v7 = 0xdaeecd2df440aea862e502734be69e9fd9a75aa18b4982a5110792882ad88319::vault_oracle::get_normalized_asset_price(arg2, arg3, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg1, v0 - 1));
            v1 = v1 + 0xdaeecd2df440aea862e502734be69e9fd9a75aa18b4982a5110792882ad88319::vault_utils::mul_with_oracle_price((0xdaeecd2df440aea862e502734be69e9fd9a75aa18b4982a5110792882ad88319::ray_math::ray_mul(v3, v5) as u256), v7);
            v2 = v2 + 0xdaeecd2df440aea862e502734be69e9fd9a75aa18b4982a5110792882ad88319::vault_utils::mul_with_oracle_price((0xdaeecd2df440aea862e502734be69e9fd9a75aa18b4982a5110792882ad88319::ray_math::ray_mul(v4, v6) as u256), v7);
            v0 = v0 - 1;
        };
        v1 - v2
    }

    public fun update_navi_position_value<T0>(arg0: &mut 0xdaeecd2df440aea862e502734be69e9fd9a75aa18b4982a5110792882ad88319::vault::Vault<T0>, arg1: &0xdaeecd2df440aea862e502734be69e9fd9a75aa18b4982a5110792882ad88319::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock, arg3: 0x1::ascii::String, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) {
        0xdaeecd2df440aea862e502734be69e9fd9a75aa18b4982a5110792882ad88319::vault::finish_update_asset_value<T0>(arg0, arg3, calculate_navi_position_value(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(0xdaeecd2df440aea862e502734be69e9fd9a75aa18b4982a5110792882ad88319::vault::get_defi_asset<T0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg0, arg3)), arg4, arg1, arg2), 0x2::clock::timestamp_ms(arg2));
    }

    // decompiled from Move bytecode v6
}

