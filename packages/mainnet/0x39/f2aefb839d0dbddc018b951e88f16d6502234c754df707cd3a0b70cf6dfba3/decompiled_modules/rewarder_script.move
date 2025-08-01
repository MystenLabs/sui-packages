module 0x39f2aefb839d0dbddc018b951e88f16d6502234c754df707cd3a0b70cf6dfba3::rewarder_script {
    public fun deposit_reward<T0>(arg0: &0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::config::GlobalConfig, arg1: &mut 0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::rewarder::RewarderGlobalVault, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x39f2aefb839d0dbddc018b951e88f16d6502234c754df707cd3a0b70cf6dfba3::utils::merge_coins<T0>(arg2, arg4);
        assert!(0x2::coin::value<T0>(&v0) >= arg3, 0);
        0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::rewarder::deposit_reward<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, arg3, arg4)));
        0x39f2aefb839d0dbddc018b951e88f16d6502234c754df707cd3a0b70cf6dfba3::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun emergent_withdraw<T0>(arg0: &0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::config::AdminCap, arg1: &0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::config::GlobalConfig, arg2: &mut 0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::rewarder::RewarderGlobalVault, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::rewarder::balance_of<T0>(arg2) >= arg3, 0);
        0x39f2aefb839d0dbddc018b951e88f16d6502234c754df707cd3a0b70cf6dfba3::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, arg3), arg5), arg4);
    }

    public fun emergent_withdraw_all<T0>(arg0: &0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::config::AdminCap, arg1: &0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::config::GlobalConfig, arg2: &mut 0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::rewarder::RewarderGlobalVault, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x39f2aefb839d0dbddc018b951e88f16d6502234c754df707cd3a0b70cf6dfba3::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, 0xc7d71347aa2bafbdf09b594b3153ff8b5b74078dba8d6d0e2b4bf39ca6f5716c::rewarder::balance_of<T0>(arg2)), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

