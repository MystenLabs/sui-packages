module 0xa60afe016bbab0d11b415111060643edc594654e8251e43c2f12fc96751279c4::rewarder_script {
    public entry fun deposit_reward<T0>(arg0: &0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::config::GlobalConfig, arg1: &mut 0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::rewarder::RewarderGlobalVault, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa60afe016bbab0d11b415111060643edc594654e8251e43c2f12fc96751279c4::utils::merge_coins<T0>(arg2, arg4);
        assert!(0x2::coin::value<T0>(&v0) >= arg3, 1);
        0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::rewarder::deposit_reward<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, arg3, arg4)));
        0xa60afe016bbab0d11b415111060643edc594654e8251e43c2f12fc96751279c4::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun emergent_withdraw<T0>(arg0: &0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::config::AdminCap, arg1: &0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::config::GlobalConfig, arg2: &mut 0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::rewarder::RewarderGlobalVault, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::rewarder::balance_of<T0>(arg2) >= arg3, 2);
        0xa60afe016bbab0d11b415111060643edc594654e8251e43c2f12fc96751279c4::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, arg3), arg5), arg4);
    }

    public entry fun emergent_withdraw_all<T0>(arg0: &0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::config::AdminCap, arg1: &0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::config::GlobalConfig, arg2: &mut 0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::rewarder::RewarderGlobalVault, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xa60afe016bbab0d11b415111060643edc594654e8251e43c2f12fc96751279c4::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, 0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::rewarder::balance_of<T0>(arg2)), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

