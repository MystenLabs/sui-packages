module 0xe33648be0c8b91cacd86fe6d40ab277ba2e1a0d80801b00368da675f0ce9fba7::pool_script_v3 {
    public entry fun collect_fee<T0, T1>(arg0: &0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::config::GlobalConfig, arg1: &mut 0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::pool::Pool<T0, T1>, arg2: &mut 0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::position::Position, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::pool::collect_fee<T0, T1>(arg0, arg1, arg2, true);
        0x2::coin::join<T0>(arg3, 0x2::coin::from_balance<T0>(v0, arg5));
        0x2::coin::join<T1>(arg4, 0x2::coin::from_balance<T1>(v1, arg5));
    }

    public entry fun collect_reward<T0, T1, T2>(arg0: &0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::config::GlobalConfig, arg1: &mut 0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::pool::Pool<T0, T1>, arg2: &mut 0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::position::Position, arg3: &mut 0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::rewarder::RewarderGlobalVault, arg4: &mut 0x2::coin::Coin<T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<T2>(arg4, 0x2::coin::from_balance<T2>(0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, true, arg5), arg6));
    }

    public entry fun update_rewarder_emission<T0, T1, T2>(arg0: &0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::config::GlobalConfig, arg1: &mut 0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::pool::Pool<T0, T1>, arg2: &0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::rewarder::RewarderGlobalVault, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::pool::update_emission<T0, T1, T2>(arg0, arg1, arg2, 0x810344e626dbc98b93565b08cc435ead55513182604bae4f34b4228dfb2a680d::full_math_u128::mul_div_floor((arg3 as u128), 18446744073709551616, (arg4 as u128)), arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

