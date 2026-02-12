module 0x7f03332ce10d85053a14cc198ec4437312b2b880abd6550cae1757f192100f91::vault_event_recorder {
    struct VaultStatusRecord has copy, drop {
        total_usd_value: u256,
        principal_price: u256,
        total_shares: u256,
        share_ratio: u256,
    }

    struct VaultStatusRecorded has copy, drop {
        vault_id: address,
        total_usd_value: u256,
        principal_price: u256,
        total_shares: u256,
        share_ratio: u256,
    }

    public fun get_vault_status<T0>(arg0: &0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::Vault<T0>, arg1: &0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock) : (u256, u256, u256, u256) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::validate_total_usd_value_updated<T0>(arg0, arg2);
        let v1 = 0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::get_total_usd_value_without_update<T0>(arg0);
        (v1 * 1000000000 * (10 ^ (0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault_oracle::coin_decimals(arg1, v0) as u256)) / 0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault_oracle::get_asset_price(arg1, arg2, v0), v1, 0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::total_shares<T0>(arg0), 0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::get_share_ratio_without_update<T0>(arg0))
    }

    public fun record_vault_status<T0>(arg0: &0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::Vault<T0>, arg1: &0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock) {
        0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::validate_total_usd_value_updated<T0>(arg0, arg2);
        let v0 = VaultStatusRecorded{
            vault_id        : 0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::vault_id<T0>(arg0),
            total_usd_value : 0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::get_total_usd_value_without_update<T0>(arg0),
            principal_price : 0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault_oracle::get_asset_price(arg1, arg2, 0x1::type_name::into_string(0x1::type_name::get<T0>())),
            total_shares    : 0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::total_shares<T0>(arg0),
            share_ratio     : 0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::get_share_ratio_without_update<T0>(arg0),
        };
        0x2::event::emit<VaultStatusRecorded>(v0);
    }

    // decompiled from Move bytecode v6
}

