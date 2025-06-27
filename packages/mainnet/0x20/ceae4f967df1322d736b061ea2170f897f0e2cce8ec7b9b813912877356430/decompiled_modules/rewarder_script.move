module 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::rewarder_script {
    public entry fun deposit_reward<T0>(arg0: &0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::GlobalConfig, arg1: &mut 0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::rewarder::RewarderGlobalVault, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::utils::merge_coins<T0>(arg2, arg4);
        assert!(0x2::coin::value<T0>(&v0) >= arg3, 1);
        0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::rewarder::deposit_reward<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, arg3, arg4)));
        0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun emergent_withdraw<T0>(arg0: &0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::AdminCap, arg1: &0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::GlobalConfig, arg2: &mut 0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::rewarder::RewarderGlobalVault, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::rewarder::balance_of<T0>(arg2) >= arg3, 2);
        0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, arg3), arg5), arg4);
    }

    public entry fun emergent_withdraw_all<T0>(arg0: &0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::AdminCap, arg1: &0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::GlobalConfig, arg2: &mut 0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::rewarder::RewarderGlobalVault, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, 0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::rewarder::balance_of<T0>(arg2)), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

