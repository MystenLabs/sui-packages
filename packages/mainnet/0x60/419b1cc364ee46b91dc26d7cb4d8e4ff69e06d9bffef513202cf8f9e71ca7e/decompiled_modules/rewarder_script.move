module 0x60419b1cc364ee46b91dc26d7cb4d8e4ff69e06d9bffef513202cf8f9e71ca7e::rewarder_script {
    public entry fun deposit_reward<T0>(arg0: &0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::config::GlobalConfig, arg1: &mut 0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::rewarder::RewarderGlobalVault, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x60419b1cc364ee46b91dc26d7cb4d8e4ff69e06d9bffef513202cf8f9e71ca7e::utils::merge_coins<T0>(arg2, arg4);
        assert!(0x2::coin::value<T0>(&v0) >= arg3, 1);
        0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::rewarder::deposit_reward<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, arg3, arg4)));
        0x60419b1cc364ee46b91dc26d7cb4d8e4ff69e06d9bffef513202cf8f9e71ca7e::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun emergent_withdraw<T0>(arg0: &0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::config::AdminCap, arg1: &0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::config::GlobalConfig, arg2: &mut 0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::rewarder::RewarderGlobalVault, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::rewarder::balance_of<T0>(arg2) >= arg3, 2);
        0x60419b1cc364ee46b91dc26d7cb4d8e4ff69e06d9bffef513202cf8f9e71ca7e::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, arg3), arg5), arg4);
    }

    public entry fun emergent_withdraw_all<T0>(arg0: &0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::config::AdminCap, arg1: &0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::config::GlobalConfig, arg2: &mut 0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::rewarder::RewarderGlobalVault, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x60419b1cc364ee46b91dc26d7cb4d8e4ff69e06d9bffef513202cf8f9e71ca7e::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, 0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::rewarder::balance_of<T0>(arg2)), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

