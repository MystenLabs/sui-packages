module 0x24a1d8393df285a283c75394b46d168c33fa06e4d12b6e859cecae7caa2f500c::rewarder_script {
    public entry fun deposit_reward<T0>(arg0: &0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::config::GlobalConfig, arg1: &mut 0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::rewarder::RewarderGlobalVault, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x24a1d8393df285a283c75394b46d168c33fa06e4d12b6e859cecae7caa2f500c::utils::merge_coins<T0>(arg2, arg4);
        assert!(0x2::coin::value<T0>(&v0) >= arg3, 0);
        0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::rewarder::deposit_reward<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, arg3, arg4)));
        0x24a1d8393df285a283c75394b46d168c33fa06e4d12b6e859cecae7caa2f500c::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun emergent_withdraw<T0>(arg0: &0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::config::AdminCap, arg1: &0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::config::GlobalConfig, arg2: &mut 0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::rewarder::RewarderGlobalVault, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::rewarder::balance_of<T0>(arg2) >= arg3, 0);
        0x24a1d8393df285a283c75394b46d168c33fa06e4d12b6e859cecae7caa2f500c::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, arg3), arg5), arg4);
    }

    public entry fun emergent_withdraw_all<T0>(arg0: &0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::config::AdminCap, arg1: &0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::config::GlobalConfig, arg2: &mut 0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::rewarder::RewarderGlobalVault, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x24a1d8393df285a283c75394b46d168c33fa06e4d12b6e859cecae7caa2f500c::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, 0xad456c8224c3c529fe341dcc14426532f57537e59b8f0672f1f5506d0eeeae67::rewarder::balance_of<T0>(arg2)), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

