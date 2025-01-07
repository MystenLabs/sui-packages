module 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::router {
    public entry fun add_operator(arg0: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::AdminCap, arg1: &mut 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::GlobalConfig, arg2: u128, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::add_operator(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun add_role(arg0: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::AdminCap, arg1: &mut 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::GlobalConfig, arg2: address, arg3: u8) {
        0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::add_role(arg0, arg1, arg2, arg3);
    }

    public entry fun remove_role(arg0: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::AdminCap, arg1: &mut 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::GlobalConfig, arg2: address, arg3: u8) {
        0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::remove_role(arg0, arg1, arg2, arg3);
    }

    public entry fun set_package_version(arg0: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::AdminCap, arg1: &mut 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::GlobalConfig, arg2: u64) {
        0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::set_package_version(arg0, arg1, arg2);
    }

    public entry fun set_roles(arg0: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::AdminCap, arg1: &mut 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::GlobalConfig, arg2: address, arg3: u128) {
        0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::set_roles(arg0, arg1, arg2, arg3);
    }

    public entry fun close_vault<T0, T1>(arg0: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::GlobalConfig, arg1: &mut 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::Strategy, arg2: 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::Vault, arg3: &mut 0x2::tx_context::TxContext) {
        0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::close_vault<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun collect_clmm_reward_direct_return<T0, T1, T2, T3>(arg0: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::GlobalConfig, arg1: &mut 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::Strategy, arg2: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::Vault, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::PoolRewardVault<T3>, arg6: u64, arg7: address, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::collect_clmm_reward_direct_return<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10), arg7);
    }

    public entry fun collect_protocol_fee<T0>(arg0: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::OperatorCap, arg1: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::GlobalConfig, arg2: &mut 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::Strategy, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::collect_protocol_fee<T0>(arg0, arg1, arg2, arg3, arg5), arg4);
    }

    public entry fun collect_reward<T0>(arg0: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::GlobalConfig, arg1: &mut 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::rewarder::RewarderManager, arg2: &mut 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::Strategy, arg3: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::Vault, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::collect_reward<T0>(arg0, arg1, arg2, arg3, arg5, arg6), arg4);
    }

    entry fun create_strategy<T0, T1, T2>(arg0: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::OperatorCap, arg1: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::GlobalConfig, arg2: &mut 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::rewarder::RewarderManager, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: u32, arg5: bool, arg6: u32, arg7: bool, arg8: 0x1::string::String, arg9: u32, arg10: u32, arg11: u32, arg12: u32, arg13: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::Strategy>(0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::create_strategy<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13));
    }

    public entry fun deposit<T0, T1, T2>(arg0: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::GlobalConfig, arg1: &mut 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::rewarder::RewarderManager, arg2: &mut 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::Strategy, arg3: &mut 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::Vault, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2::tx_context::TxContext) {
        0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::deposit<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public entry fun open_vault<T0, T1, T2>(arg0: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::GlobalConfig, arg1: &mut 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::Strategy, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: u32, arg4: bool, arg5: u32, arg6: bool, arg7: u32, arg8: bool, arg9: u32, arg10: bool, arg11: u32, arg12: u32, arg13: address, arg14: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::Vault>(0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::open_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg14), arg13);
    }

    public entry fun open_vault_and_deposit<T0, T1, T2>(arg0: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::GlobalConfig, arg1: &mut 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::rewarder::RewarderManager, arg2: &mut 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::Strategy, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u32, arg8: bool, arg9: u32, arg10: bool, arg11: u32, arg12: bool, arg13: u32, arg14: bool, arg15: u32, arg16: u32, arg17: address, arg18: &0x2::clock::Clock, arg19: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg20: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::open_vault<T0, T1, T2>(arg0, arg2, arg3, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg20);
        0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::deposit<T0, T1, T2>(arg0, arg1, arg2, &mut v0, arg3, arg4, arg5, arg6, arg18, arg19, arg20);
        0x2::transfer::public_transfer<0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::Vault>(v0, arg17);
    }

    public entry fun rebalance<T0, T1, T2>(arg0: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::OperatorCap, arg1: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::GlobalConfig, arg2: &mut 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::rewarder::RewarderManager, arg3: &mut 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::Strategy, arg4: 0x2::object::ID, arg5: bool, arg6: bool, arg7: u32, arg8: bool, arg9: u32, arg10: bool, arg11: u32, arg12: bool, arg13: u32, arg14: bool, arg15: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg16: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg17: &0x2::clock::Clock, arg18: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg19: &mut 0x2::tx_context::TxContext) {
        0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::rebalance<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19);
    }

    public entry fun update_strategy_base_minimum_threshold(arg0: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::OperatorCap, arg1: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::GlobalConfig, arg2: &mut 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::Strategy, arg3: u32) {
        0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::update_strategy_base_minimum_threshold(arg0, arg1, arg2, arg3);
    }

    public entry fun update_strategy_default_base_rebalance_threshold(arg0: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::OperatorCap, arg1: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::GlobalConfig, arg2: &mut 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::Strategy, arg3: u32) {
        0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::update_strategy_default_base_rebalance_threshold(arg0, arg1, arg2, arg3);
    }

    public entry fun update_strategy_default_limit_rebalance_threshold(arg0: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::OperatorCap, arg1: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::GlobalConfig, arg2: &mut 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::Strategy, arg3: u32) {
        0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::update_strategy_default_limit_rebalance_threshold(arg0, arg1, arg2, arg3);
    }

    public entry fun update_strategy_limit_minimum_threshold(arg0: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::OperatorCap, arg1: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::GlobalConfig, arg2: &mut 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::Strategy, arg3: u32) {
        0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::update_strategy_limit_minimum_threshold(arg0, arg1, arg2, arg3);
    }

    public entry fun update_strategy_protocol_fee_rate(arg0: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::OperatorCap, arg1: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::GlobalConfig, arg2: &mut 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::Strategy, arg3: u64) {
        0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::update_strategy_protocol_fee_rate(arg0, arg1, arg2, arg3);
    }

    public entry fun update_strategy_status(arg0: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::OperatorCap, arg1: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::GlobalConfig, arg2: &mut 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::Strategy, arg3: u8) {
        0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::update_strategy_status(arg0, arg1, arg2, arg3);
    }

    public entry fun update_vault_base_rebalance_threshold(arg0: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::OperatorCap, arg1: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::GlobalConfig, arg2: &mut 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::Strategy, arg3: 0x2::object::ID, arg4: u32) {
        0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::update_vault_base_rebalance_threshold(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun update_vault_limit_rebalance_threshold(arg0: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::OperatorCap, arg1: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::GlobalConfig, arg2: &mut 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::Strategy, arg3: 0x2::object::ID, arg4: u32) {
        0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::update_vault_limit_rebalance_threshold(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun withdraw<T0, T1, T2>(arg0: &0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::config::GlobalConfig, arg1: &mut 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::rewarder::RewarderManager, arg2: &mut 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::Strategy, arg3: &mut 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::Vault, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg6: u64, arg7: bool, arg8: address, arg9: &0x2::clock::Clock, arg10: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd7599867e87c3e2d4eacfab112397144b8e3f5918fdfad6e29a893c34a9313af::vault::withdraw<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg10, arg11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, arg8);
    }

    // decompiled from Move bytecode v6
}

