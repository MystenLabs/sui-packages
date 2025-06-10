module 0x908e69af981662cbccda92fe033ac1ae372598bed0d1929d2d3afe153ba99194::rewarder_script {
    public entry fun deposit_reward<T0>(arg0: &0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::config::GlobalConfig, arg1: &mut 0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::rewarder::RewarderGlobalVault, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x908e69af981662cbccda92fe033ac1ae372598bed0d1929d2d3afe153ba99194::utils::merge_coins<T0>(arg2, arg4);
        assert!(0x2::coin::value<T0>(&v0) >= arg3, 0);
        0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::rewarder::deposit_reward<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, arg3, arg4)));
        0x908e69af981662cbccda92fe033ac1ae372598bed0d1929d2d3afe153ba99194::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun emergent_withdraw<T0>(arg0: &0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::config::AdminCap, arg1: &0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::config::GlobalConfig, arg2: &mut 0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::rewarder::RewarderGlobalVault, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::rewarder::balance_of<T0>(arg2) >= arg3, 0);
        0x908e69af981662cbccda92fe033ac1ae372598bed0d1929d2d3afe153ba99194::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, arg3), arg5), arg4);
    }

    public entry fun emergent_withdraw_all<T0>(arg0: &0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::config::AdminCap, arg1: &0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::config::GlobalConfig, arg2: &mut 0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::rewarder::RewarderGlobalVault, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x908e69af981662cbccda92fe033ac1ae372598bed0d1929d2d3afe153ba99194::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, 0x6571924145092da6384e39a0a3bb85b54238fe850a444bca96a77941671e0d7f::rewarder::balance_of<T0>(arg2)), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

