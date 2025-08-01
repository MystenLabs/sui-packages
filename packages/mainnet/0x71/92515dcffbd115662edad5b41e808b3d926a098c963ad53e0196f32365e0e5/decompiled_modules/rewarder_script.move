module 0x7192515dcffbd115662edad5b41e808b3d926a098c963ad53e0196f32365e0e5::rewarder_script {
    public fun deposit_reward<T0>(arg0: &0xf9bd23323871f0f3f300b8704a107b0475d3a203880d02ec7d22a7c003091919::config::GlobalConfig, arg1: &mut 0xf9bd23323871f0f3f300b8704a107b0475d3a203880d02ec7d22a7c003091919::rewarder::RewarderGlobalVault, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7192515dcffbd115662edad5b41e808b3d926a098c963ad53e0196f32365e0e5::utils::merge_coins<T0>(arg2, arg4);
        assert!(0x2::coin::value<T0>(&v0) >= arg3, 0);
        0xf9bd23323871f0f3f300b8704a107b0475d3a203880d02ec7d22a7c003091919::rewarder::deposit_reward<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, arg3, arg4)));
        0x7192515dcffbd115662edad5b41e808b3d926a098c963ad53e0196f32365e0e5::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun emergent_withdraw<T0>(arg0: &0xf9bd23323871f0f3f300b8704a107b0475d3a203880d02ec7d22a7c003091919::config::AdminCap, arg1: &0xf9bd23323871f0f3f300b8704a107b0475d3a203880d02ec7d22a7c003091919::config::GlobalConfig, arg2: &mut 0xf9bd23323871f0f3f300b8704a107b0475d3a203880d02ec7d22a7c003091919::rewarder::RewarderGlobalVault, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xf9bd23323871f0f3f300b8704a107b0475d3a203880d02ec7d22a7c003091919::rewarder::balance_of<T0>(arg2) >= arg3, 0);
        0x7192515dcffbd115662edad5b41e808b3d926a098c963ad53e0196f32365e0e5::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0xf9bd23323871f0f3f300b8704a107b0475d3a203880d02ec7d22a7c003091919::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, arg3), arg5), arg4);
    }

    public fun emergent_withdraw_all<T0>(arg0: &0xf9bd23323871f0f3f300b8704a107b0475d3a203880d02ec7d22a7c003091919::config::AdminCap, arg1: &0xf9bd23323871f0f3f300b8704a107b0475d3a203880d02ec7d22a7c003091919::config::GlobalConfig, arg2: &mut 0xf9bd23323871f0f3f300b8704a107b0475d3a203880d02ec7d22a7c003091919::rewarder::RewarderGlobalVault, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x7192515dcffbd115662edad5b41e808b3d926a098c963ad53e0196f32365e0e5::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0xf9bd23323871f0f3f300b8704a107b0475d3a203880d02ec7d22a7c003091919::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, 0xf9bd23323871f0f3f300b8704a107b0475d3a203880d02ec7d22a7c003091919::rewarder::balance_of<T0>(arg2)), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

