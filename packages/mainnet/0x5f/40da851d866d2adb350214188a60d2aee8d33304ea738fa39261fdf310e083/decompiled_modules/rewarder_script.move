module 0x5f40da851d866d2adb350214188a60d2aee8d33304ea738fa39261fdf310e083::rewarder_script {
    public entry fun deposit_reward<T0>(arg0: &0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::GlobalConfig, arg1: &mut 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::rewarder::RewarderGlobalVault, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5f40da851d866d2adb350214188a60d2aee8d33304ea738fa39261fdf310e083::utils::merge_coins<T0>(arg2, arg4);
        assert!(0x2::coin::value<T0>(&v0) >= arg3, 1);
        0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::rewarder::deposit_reward<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, arg3, arg4)));
        0x5f40da851d866d2adb350214188a60d2aee8d33304ea738fa39261fdf310e083::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun emergent_withdraw<T0>(arg0: &0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::AdminCap, arg1: &0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::GlobalConfig, arg2: &mut 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::rewarder::RewarderGlobalVault, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::rewarder::balance_of<T0>(arg2) >= arg3, 2);
        0x5f40da851d866d2adb350214188a60d2aee8d33304ea738fa39261fdf310e083::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, arg3), arg5), arg4);
    }

    public entry fun emergent_withdraw_all<T0>(arg0: &0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::AdminCap, arg1: &0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::GlobalConfig, arg2: &mut 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::rewarder::RewarderGlobalVault, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x5f40da851d866d2adb350214188a60d2aee8d33304ea738fa39261fdf310e083::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::rewarder::balance_of<T0>(arg2)), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

