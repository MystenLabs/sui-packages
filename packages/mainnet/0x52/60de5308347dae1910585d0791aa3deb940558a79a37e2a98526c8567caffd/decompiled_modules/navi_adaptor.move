module 0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::navi_adaptor {
    public fun calculate_navi_position_value(arg0: address, arg1: &mut 0xeac43fe10f04537eac5e9ee734166641af69176d3b520256124f8721d442c8a5::storage::Storage, arg2: &0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault_oracle::OracleConfig, arg3: &0x2::clock::Clock) : u256 {
        let v0 = 0xeac43fe10f04537eac5e9ee734166641af69176d3b520256124f8721d442c8a5::storage::get_reserves_count(arg1);
        let v1 = 0;
        let v2 = 0;
        while (v0 > 0) {
            let (v3, v4) = 0xeac43fe10f04537eac5e9ee734166641af69176d3b520256124f8721d442c8a5::storage::get_user_balance(arg1, v0 - 1, arg0);
            let (v5, v6) = 0xeac43fe10f04537eac5e9ee734166641af69176d3b520256124f8721d442c8a5::dynamic_calculator::calculate_current_index(arg3, arg1, v0 - 1);
            let v7 = 0xeac43fe10f04537eac5e9ee734166641af69176d3b520256124f8721d442c8a5::storage::get_coin_type(arg1, v0 - 1);
            if (v3 == 0 && v4 == 0) {
                v0 = v0 - 1;
                continue
            };
            let v8 = 0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault_oracle::get_asset_price(arg2, arg3, v7);
            v1 = v1 + 0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault_utils::mul_with_oracle_price((0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::ray_math::ray_mul(v3, v5) as u256), v8);
            v2 = v2 + 0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault_utils::mul_with_oracle_price((0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::ray_math::ray_mul(v4, v6) as u256), v8);
            v0 = v0 - 1;
        };
        if (v1 < v2) {
            return 0
        };
        v1 - v2
    }

    public fun update_navi_position_value<T0>(arg0: &mut 0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::Vault<T0>, arg1: &0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock, arg3: 0x1::ascii::String, arg4: &mut 0xeac43fe10f04537eac5e9ee734166641af69176d3b520256124f8721d442c8a5::storage::Storage) {
        0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::finish_update_asset_value<T0>(arg0, arg3, calculate_navi_position_value(0xeac43fe10f04537eac5e9ee734166641af69176d3b520256124f8721d442c8a5::account::account_owner(0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::vault::get_defi_asset<T0, 0xeac43fe10f04537eac5e9ee734166641af69176d3b520256124f8721d442c8a5::account::AccountCap>(arg0, arg3)), arg4, arg1, arg2), 0x2::clock::timestamp_ms(arg2));
    }

    // decompiled from Move bytecode v6
}

