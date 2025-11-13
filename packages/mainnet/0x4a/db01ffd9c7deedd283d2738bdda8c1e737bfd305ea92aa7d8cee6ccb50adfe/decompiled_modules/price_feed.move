module 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::price_feed {
    public fun get_price_config_details(arg0: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::OracleConfig) : address {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::oracle_config_address(arg0)
    }

    public fun get_price_decimals() : u8 {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::price_decimals()
    }

    public fun get_price_details(arg0: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::OracleConfig, arg1: &0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::Oracle, arg2: &mut 0x2::tx_context::TxContext) : (u64, u128, u64, u8) {
        let v0 = 0x2::object::id<0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::Oracle>(arg1);
        assert!(0x2::object::id_to_address(&v0) == 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::oracle_config_address(arg0), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::invalid_oracle());
        let v1 = 0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::oracle::get_price_unsafe(arg1);
        (v1, (v1 as u128), 0, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::price_decimals())
    }

    public fun get_sui_usd_price(arg0: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::OracleConfig, arg1: &0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::Oracle, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::object::id<0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::Oracle>(arg1);
        assert!(0x2::object::id_to_address(&v0) == 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::oracle_config_address(arg0), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::invalid_oracle());
        let v1 = 0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::oracle::get_price(arg1, arg2);
        assert!(v1 >= 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::min_reasonable_price() && v1 <= 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::max_reasonable_price(), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::price_out_of_bounds());
        let v2 = 0x2::clock::timestamp_ms(arg2);
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_events::emit_price_fetched(0x1::vector::empty<u8>(), v1, v2 * 1000000, (v1 as u128), v2 * 1000000);
        v1
    }

    public fun get_sui_usd_price_unchecked(arg0: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::OracleConfig, arg1: &0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::Oracle, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::object::id<0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::Oracle>(arg1);
        assert!(0x2::object::id_to_address(&v0) == 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::oracle_config_address(arg0), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::invalid_oracle());
        let v1 = 0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::oracle::get_price_unsafe(arg1);
        assert!(v1 >= 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::min_reasonable_price() && v1 <= 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::max_reasonable_price(), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::price_out_of_bounds());
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_events::emit_price_fetched(0x1::vector::empty<u8>(), v1, 0, (v1 as u128), 0);
        v1
    }

    public fun price_to_usd_cents(arg0: u64) : u64 {
        arg0 / 10000
    }

    public fun price_to_usd_dollars(arg0: u64) : u64 {
        arg0 / 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::our_scale_u64()
    }

    // decompiled from Move bytecode v6
}

