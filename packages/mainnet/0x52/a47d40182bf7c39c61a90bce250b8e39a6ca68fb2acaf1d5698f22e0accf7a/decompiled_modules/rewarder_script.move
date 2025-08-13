module 0x52a47d40182bf7c39c61a90bce250b8e39a6ca68fb2acaf1d5698f22e0accf7a::rewarder_script {
    public fun deposit_reward<T0>(arg0: &0x88833f79df96d4465298650785e121766727ee926a3916b4fd6c7a2b12e5b4ff::config::GlobalConfig, arg1: &mut 0x88833f79df96d4465298650785e121766727ee926a3916b4fd6c7a2b12e5b4ff::rewarder::RewarderGlobalVault, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x52a47d40182bf7c39c61a90bce250b8e39a6ca68fb2acaf1d5698f22e0accf7a::utils::merge_coins<T0>(arg2, arg4);
        assert!(0x2::coin::value<T0>(&v0) >= arg3, 0);
        0x88833f79df96d4465298650785e121766727ee926a3916b4fd6c7a2b12e5b4ff::rewarder::deposit_reward<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, arg3, arg4)));
        0x52a47d40182bf7c39c61a90bce250b8e39a6ca68fb2acaf1d5698f22e0accf7a::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun emergent_withdraw<T0>(arg0: &0x88833f79df96d4465298650785e121766727ee926a3916b4fd6c7a2b12e5b4ff::config::AdminCap, arg1: &0x88833f79df96d4465298650785e121766727ee926a3916b4fd6c7a2b12e5b4ff::config::GlobalConfig, arg2: &mut 0x88833f79df96d4465298650785e121766727ee926a3916b4fd6c7a2b12e5b4ff::rewarder::RewarderGlobalVault, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x88833f79df96d4465298650785e121766727ee926a3916b4fd6c7a2b12e5b4ff::rewarder::balance_of<T0>(arg2) >= arg3, 0);
        0x52a47d40182bf7c39c61a90bce250b8e39a6ca68fb2acaf1d5698f22e0accf7a::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x88833f79df96d4465298650785e121766727ee926a3916b4fd6c7a2b12e5b4ff::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, arg3), arg5), arg4);
    }

    public fun emergent_withdraw_all<T0>(arg0: &0x88833f79df96d4465298650785e121766727ee926a3916b4fd6c7a2b12e5b4ff::config::AdminCap, arg1: &0x88833f79df96d4465298650785e121766727ee926a3916b4fd6c7a2b12e5b4ff::config::GlobalConfig, arg2: &mut 0x88833f79df96d4465298650785e121766727ee926a3916b4fd6c7a2b12e5b4ff::rewarder::RewarderGlobalVault, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x52a47d40182bf7c39c61a90bce250b8e39a6ca68fb2acaf1d5698f22e0accf7a::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x88833f79df96d4465298650785e121766727ee926a3916b4fd6c7a2b12e5b4ff::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, 0x88833f79df96d4465298650785e121766727ee926a3916b4fd6c7a2b12e5b4ff::rewarder::balance_of<T0>(arg2)), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

