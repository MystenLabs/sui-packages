module 0x86171a64a40410157588776303de9557ee8618f595782b87af5c62cf25d5d359::stake_entries {
    public entry fun stake<T0, T1>(arg0: &mut 0x86171a64a40410157588776303de9557ee8618f595782b87af5c62cf25d5d359::stake::StakePool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x86171a64a40410157588776303de9557ee8618f595782b87af5c62cf25d5d359::stake_config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x86171a64a40410157588776303de9557ee8618f595782b87af5c62cf25d5d359::stake::stake<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun deposit_reward_coins<T0, T1>(arg0: &mut 0x86171a64a40410157588776303de9557ee8618f595782b87af5c62cf25d5d359::stake::StakePool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x86171a64a40410157588776303de9557ee8618f595782b87af5c62cf25d5d359::stake_config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x86171a64a40410157588776303de9557ee8618f595782b87af5c62cf25d5d359::stake::deposit_reward_coins<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun emergency_unstake<T0, T1>(arg0: &mut 0x86171a64a40410157588776303de9557ee8618f595782b87af5c62cf25d5d359::stake::StakePool<T0, T1>, arg1: &0x86171a64a40410157588776303de9557ee8618f595782b87af5c62cf25d5d359::stake_config::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x86171a64a40410157588776303de9557ee8618f595782b87af5c62cf25d5d359::stake::emergency_unstake<T0, T1>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun enable_emergency<T0, T1>(arg0: &mut 0x86171a64a40410157588776303de9557ee8618f595782b87af5c62cf25d5d359::stake::StakePool<T0, T1>, arg1: &0x86171a64a40410157588776303de9557ee8618f595782b87af5c62cf25d5d359::stake_config::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0x86171a64a40410157588776303de9557ee8618f595782b87af5c62cf25d5d359::stake::enable_emergency<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun harvest<T0, T1>(arg0: &mut 0x86171a64a40410157588776303de9557ee8618f595782b87af5c62cf25d5d359::stake::StakePool<T0, T1>, arg1: &0x86171a64a40410157588776303de9557ee8618f595782b87af5c62cf25d5d359::stake_config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x86171a64a40410157588776303de9557ee8618f595782b87af5c62cf25d5d359::stake::harvest<T0, T1>(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun register_pool<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: u64, arg2: &0x86171a64a40410157588776303de9557ee8618f595782b87af5c62cf25d5d359::stake_config::GlobalConfig, arg3: u8, arg4: u8, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0x86171a64a40410157588776303de9557ee8618f595782b87af5c62cf25d5d359::stake::register_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun unstake<T0, T1>(arg0: &mut 0x86171a64a40410157588776303de9557ee8618f595782b87af5c62cf25d5d359::stake::StakePool<T0, T1>, arg1: u64, arg2: &0x86171a64a40410157588776303de9557ee8618f595782b87af5c62cf25d5d359::stake_config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x86171a64a40410157588776303de9557ee8618f595782b87af5c62cf25d5d359::stake::unstake<T0, T1>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun enable_global_emergency(arg0: &mut 0x86171a64a40410157588776303de9557ee8618f595782b87af5c62cf25d5d359::stake_config::GlobalConfig, arg1: &mut 0x2::tx_context::TxContext) {
        0x86171a64a40410157588776303de9557ee8618f595782b87af5c62cf25d5d359::stake_config::enable_global_emergency(arg0, arg1);
    }

    public entry fun set_emergency_admin_address(arg0: &mut 0x86171a64a40410157588776303de9557ee8618f595782b87af5c62cf25d5d359::stake_config::GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x86171a64a40410157588776303de9557ee8618f595782b87af5c62cf25d5d359::stake_config::set_emergency_admin_address(arg0, arg1, arg2);
    }

    public entry fun set_treasury_admin_address(arg0: &mut 0x86171a64a40410157588776303de9557ee8618f595782b87af5c62cf25d5d359::stake_config::GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x86171a64a40410157588776303de9557ee8618f595782b87af5c62cf25d5d359::stake_config::set_treasury_admin_address(arg0, arg1, arg2);
    }

    public entry fun withdraw_reward_to_treasury<T0, T1>(arg0: &mut 0x86171a64a40410157588776303de9557ee8618f595782b87af5c62cf25d5d359::stake::StakePool<T0, T1>, arg1: u64, arg2: &0x86171a64a40410157588776303de9557ee8618f595782b87af5c62cf25d5d359::stake_config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x86171a64a40410157588776303de9557ee8618f595782b87af5c62cf25d5d359::stake::withdraw_to_treasury<T0, T1>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

