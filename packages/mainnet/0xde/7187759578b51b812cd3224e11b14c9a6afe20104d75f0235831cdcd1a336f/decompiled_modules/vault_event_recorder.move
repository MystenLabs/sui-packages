module 0x905d2e52c061e4657cf416b231160a9c43e03cf22bec369a9ebfb317dd9c8e7c::vault_event_recorder {
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

    public fun record_vault_status<T0>(arg0: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg1: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock) {
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::validate_total_usd_value_updated<T0>(arg0, arg2);
        let v0 = VaultStatusRecorded{
            vault_id        : 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg0),
            total_usd_value : 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::get_total_usd_value_without_update<T0>(arg0),
            principal_price : 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_oracle::get_asset_price(arg1, arg2, 0x1::type_name::into_string(0x1::type_name::get<T0>())),
            total_shares    : 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::total_shares<T0>(arg0),
            share_ratio     : 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::get_share_ratio_without_update<T0>(arg0),
        };
        0x2::event::emit<VaultStatusRecorded>(v0);
    }

    // decompiled from Move bytecode v6
}

