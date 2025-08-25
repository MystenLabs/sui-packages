module 0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_operate {
    public fun collect_rewards(arg0: &0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_manage::OperatorCap, arg1: &0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_core::Strategy, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_core::collect_rewards(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9), 0x2::tx_context::sender(arg9));
    }

    public fun set_cetus_slippage(arg0: &0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_manage::OperatorCap, arg1: &mut 0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_core::Strategy, arg2: u64) {
        0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_core::assert_version(arg1);
        0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_core::set_cetus_slippage(arg1, arg2);
    }

    public fun toggle_deposit(arg0: &0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_manage::OperatorCap, arg1: &mut 0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_core::Strategy, arg2: bool) {
        0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_core::assert_version(arg1);
        0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_core::toggle_deposit(arg1, arg2);
    }

    public fun toggle_withdraw(arg0: &0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_manage::OperatorCap, arg1: &mut 0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_core::Strategy, arg2: bool) {
        0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_core::assert_version(arg1);
        0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_core::toggle_withdraw(arg1, arg2);
    }

    public fun update_limit(arg0: &0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_manage::OperatorCap, arg1: &mut 0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_core::Strategy, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::navi_section::update_risk_parameters(0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_core::get_config_mut(arg1), arg2, arg3, arg4, arg5);
    }

    public fun update_max_loops(arg0: &0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_manage::OperatorCap, arg1: &mut 0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_core::Strategy, arg2: u64) {
        0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::navi_section::update_navi_max_loop(0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_core::get_config_mut(arg1), arg2);
    }

    public fun update_navi_asset(arg0: &0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_manage::OperatorCap, arg1: &mut 0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_core::Strategy, arg2: u8, arg3: u8) {
        0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::navi_section::update_navi_asset_num(0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::loop_strategy_core::get_config_mut(arg1), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

