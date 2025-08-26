module 0x62c8241c8d2a19846d743dda94cb671bc98e798e546d7c98212bca3fc0a7b5a5::rewarder_script {
    public fun deposit_reward<T0>(arg0: &0x7b28fde8817a8abcc3a6958c5605900a4133eb67a46e65dc83ad5351da78cfa3::config::GlobalConfig, arg1: &mut 0x7b28fde8817a8abcc3a6958c5605900a4133eb67a46e65dc83ad5351da78cfa3::rewarder::RewarderGlobalVault, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x62c8241c8d2a19846d743dda94cb671bc98e798e546d7c98212bca3fc0a7b5a5::utils::merge_coins<T0>(arg2, arg4);
        assert!(0x2::coin::value<T0>(&v0) >= arg3, 0);
        0x7b28fde8817a8abcc3a6958c5605900a4133eb67a46e65dc83ad5351da78cfa3::rewarder::deposit_reward<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, arg3, arg4)));
        0x62c8241c8d2a19846d743dda94cb671bc98e798e546d7c98212bca3fc0a7b5a5::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun emergent_withdraw<T0>(arg0: &0x7b28fde8817a8abcc3a6958c5605900a4133eb67a46e65dc83ad5351da78cfa3::config::GlobalConfig, arg1: &mut 0x7b28fde8817a8abcc3a6958c5605900a4133eb67a46e65dc83ad5351da78cfa3::rewarder::RewarderGlobalVault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x7b28fde8817a8abcc3a6958c5605900a4133eb67a46e65dc83ad5351da78cfa3::rewarder::balance_of<T0>(arg1) >= arg2, 0);
        0x7b28fde8817a8abcc3a6958c5605900a4133eb67a46e65dc83ad5351da78cfa3::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

