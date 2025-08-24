module 0x80c32cc47ba314ceddc8b5ea899a29c88cc088189734be1d02be9f7484d8caf7::vault_event_recorder {
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

    public fun record_vault_status<T0>(arg0: &0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::Vault<T0>, arg1: &0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock) {
        0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::validate_total_usd_value_updated<T0>(arg0, arg2);
        let v0 = VaultStatusRecorded{
            vault_id        : 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::vault_id<T0>(arg0),
            total_usd_value : 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::get_total_usd_value_without_update<T0>(arg0),
            principal_price : 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_oracle::get_asset_price(arg1, arg2, 0x1::type_name::into_string(0x1::type_name::get<T0>())),
            total_shares    : 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::total_shares<T0>(arg0),
            share_ratio     : 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::get_share_ratio_without_update<T0>(arg0),
        };
        0x2::event::emit<VaultStatusRecorded>(v0);
    }

    // decompiled from Move bytecode v6
}

