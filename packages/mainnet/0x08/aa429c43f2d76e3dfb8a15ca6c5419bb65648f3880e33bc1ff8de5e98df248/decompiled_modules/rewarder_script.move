module 0x8aa429c43f2d76e3dfb8a15ca6c5419bb65648f3880e33bc1ff8de5e98df248::rewarder_script {
    public entry fun deposit_reward<T0>(arg0: &0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::config::GlobalConfig, arg1: &mut 0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::rewarder::RewarderGlobalVault, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8aa429c43f2d76e3dfb8a15ca6c5419bb65648f3880e33bc1ff8de5e98df248::utils::merge_coins<T0>(arg2, arg4);
        assert!(0x2::coin::value<T0>(&v0) >= arg3, 0);
        0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::rewarder::deposit_reward<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, arg3, arg4)));
        0x8aa429c43f2d76e3dfb8a15ca6c5419bb65648f3880e33bc1ff8de5e98df248::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun emergent_withdraw<T0>(arg0: &0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::config::AdminCap, arg1: &0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::config::GlobalConfig, arg2: &mut 0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::rewarder::RewarderGlobalVault, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::rewarder::balance_of<T0>(arg2) >= arg3, 0);
        0x8aa429c43f2d76e3dfb8a15ca6c5419bb65648f3880e33bc1ff8de5e98df248::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, arg3), arg5), arg4);
    }

    public entry fun emergent_withdraw_all<T0>(arg0: &0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::config::AdminCap, arg1: &0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::config::GlobalConfig, arg2: &mut 0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::rewarder::RewarderGlobalVault, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x8aa429c43f2d76e3dfb8a15ca6c5419bb65648f3880e33bc1ff8de5e98df248::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, 0xd38b948241d565f80d838e2d68491d8bcd1461e16bd6d8cc4b503d23737c3ffe::rewarder::balance_of<T0>(arg2)), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

