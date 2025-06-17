module 0xc788661cd63ad1e37d3e7e8a10033cf2798ba8c14f8a1d63ac0d11c97b64c7ce::rewarder_script {
    public fun deposit_reward<T0>(arg0: &0x5f0dcfe9d749b678bf2c2d97be70d25b407310957530eef82816889a4f5eff06::config::GlobalConfig, arg1: &mut 0x5f0dcfe9d749b678bf2c2d97be70d25b407310957530eef82816889a4f5eff06::rewarder::RewarderGlobalVault, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc788661cd63ad1e37d3e7e8a10033cf2798ba8c14f8a1d63ac0d11c97b64c7ce::utils::merge_coins<T0>(arg2, arg4);
        assert!(0x2::coin::value<T0>(&v0) >= arg3, 0);
        0x5f0dcfe9d749b678bf2c2d97be70d25b407310957530eef82816889a4f5eff06::rewarder::deposit_reward<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, arg3, arg4)));
        0xc788661cd63ad1e37d3e7e8a10033cf2798ba8c14f8a1d63ac0d11c97b64c7ce::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun emergent_withdraw<T0>(arg0: &0x5f0dcfe9d749b678bf2c2d97be70d25b407310957530eef82816889a4f5eff06::config::AdminCap, arg1: &0x5f0dcfe9d749b678bf2c2d97be70d25b407310957530eef82816889a4f5eff06::config::GlobalConfig, arg2: &mut 0x5f0dcfe9d749b678bf2c2d97be70d25b407310957530eef82816889a4f5eff06::rewarder::RewarderGlobalVault, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x5f0dcfe9d749b678bf2c2d97be70d25b407310957530eef82816889a4f5eff06::rewarder::balance_of<T0>(arg2) >= arg3, 0);
        0xc788661cd63ad1e37d3e7e8a10033cf2798ba8c14f8a1d63ac0d11c97b64c7ce::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x5f0dcfe9d749b678bf2c2d97be70d25b407310957530eef82816889a4f5eff06::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, arg3), arg5), arg4);
    }

    public fun emergent_withdraw_all<T0>(arg0: &0x5f0dcfe9d749b678bf2c2d97be70d25b407310957530eef82816889a4f5eff06::config::AdminCap, arg1: &0x5f0dcfe9d749b678bf2c2d97be70d25b407310957530eef82816889a4f5eff06::config::GlobalConfig, arg2: &mut 0x5f0dcfe9d749b678bf2c2d97be70d25b407310957530eef82816889a4f5eff06::rewarder::RewarderGlobalVault, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xc788661cd63ad1e37d3e7e8a10033cf2798ba8c14f8a1d63ac0d11c97b64c7ce::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x5f0dcfe9d749b678bf2c2d97be70d25b407310957530eef82816889a4f5eff06::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, 0x5f0dcfe9d749b678bf2c2d97be70d25b407310957530eef82816889a4f5eff06::rewarder::balance_of<T0>(arg2)), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

