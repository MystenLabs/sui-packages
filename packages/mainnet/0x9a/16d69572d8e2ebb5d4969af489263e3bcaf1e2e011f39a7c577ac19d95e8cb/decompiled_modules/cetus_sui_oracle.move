module 0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_sui_oracle {
    public(friend) fun hasui_composition_value(arg0: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg1: u64, arg2: u64) : u128 {
        (arg2 as u128) + (0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_vault_adapter::get_hasui_by_sui(arg0, arg1) as u128)
    }

    public(friend) fun hasui_lp_nav<T0>(arg0: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: u64) : u128 {
        0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_vault_adapter::get_underlying_balance_in_hasui<T0>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun sui_composition_value(arg0: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg1: u64, arg2: u64, arg3: u64) : u128 {
        (arg1 as u128) + (0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_vault_adapter::get_net_sui_by_hasui_with_fee(arg0, arg2, arg3) as u128)
    }

    public(friend) fun sui_lp_nav<T0>(arg0: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: u64, arg4: u64) : u128 {
        0x9a16d69572d8e2ebb5d4969af489263e3bcaf1e2e011f39a7c577ac19d95e8cb::cetus_vault_adapter::get_underlying_balance_in_sui<T0>(arg0, arg1, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v7
}

