module 0xcfd55d438c9d1210a846c72cacfdef1a245bda2e8c8e31b3395434b0b3e08efb::stake_entries {
    public entry fun stake<T0, T1>(arg0: &mut 0xcfd55d438c9d1210a846c72cacfdef1a245bda2e8c8e31b3395434b0b3e08efb::stake::StakePool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0xcfd55d438c9d1210a846c72cacfdef1a245bda2e8c8e31b3395434b0b3e08efb::stake_config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xcfd55d438c9d1210a846c72cacfdef1a245bda2e8c8e31b3395434b0b3e08efb::stake::stake<T0, T1>(arg0, arg1, arg2, 0x2::clock::timestamp_ms(arg3), arg4);
    }

    public entry fun deposit_reward_coins<T0, T1>(arg0: &mut 0xcfd55d438c9d1210a846c72cacfdef1a245bda2e8c8e31b3395434b0b3e08efb::stake::StakePool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0xcfd55d438c9d1210a846c72cacfdef1a245bda2e8c8e31b3395434b0b3e08efb::stake_config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xcfd55d438c9d1210a846c72cacfdef1a245bda2e8c8e31b3395434b0b3e08efb::stake::deposit_reward_coins<T0, T1>(arg0, arg1, arg2, 0x2::clock::timestamp_ms(arg3), arg4);
    }

    public entry fun emergency_unstake<T0, T1>(arg0: &mut 0xcfd55d438c9d1210a846c72cacfdef1a245bda2e8c8e31b3395434b0b3e08efb::stake::StakePool<T0, T1>, arg1: &0xcfd55d438c9d1210a846c72cacfdef1a245bda2e8c8e31b3395434b0b3e08efb::stake_config::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xcfd55d438c9d1210a846c72cacfdef1a245bda2e8c8e31b3395434b0b3e08efb::stake::emergency_unstake<T0, T1>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun enable_emergency<T0, T1>(arg0: &mut 0xcfd55d438c9d1210a846c72cacfdef1a245bda2e8c8e31b3395434b0b3e08efb::stake::StakePool<T0, T1>, arg1: &0xcfd55d438c9d1210a846c72cacfdef1a245bda2e8c8e31b3395434b0b3e08efb::stake_config::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0xcfd55d438c9d1210a846c72cacfdef1a245bda2e8c8e31b3395434b0b3e08efb::stake::enable_emergency<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun harvest<T0, T1>(arg0: &mut 0xcfd55d438c9d1210a846c72cacfdef1a245bda2e8c8e31b3395434b0b3e08efb::stake::StakePool<T0, T1>, arg1: &0xcfd55d438c9d1210a846c72cacfdef1a245bda2e8c8e31b3395434b0b3e08efb::stake_config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xcfd55d438c9d1210a846c72cacfdef1a245bda2e8c8e31b3395434b0b3e08efb::stake::harvest<T0, T1>(arg0, arg1, 0x2::clock::timestamp_ms(arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun register_pool<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: u64, arg2: &0xcfd55d438c9d1210a846c72cacfdef1a245bda2e8c8e31b3395434b0b3e08efb::stake_config::GlobalConfig, arg3: u8, arg4: u8, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0xcfd55d438c9d1210a846c72cacfdef1a245bda2e8c8e31b3395434b0b3e08efb::stake::register_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x2::clock::timestamp_ms(arg5), arg6, arg7, arg8);
    }

    public entry fun unstake<T0, T1>(arg0: &mut 0xcfd55d438c9d1210a846c72cacfdef1a245bda2e8c8e31b3395434b0b3e08efb::stake::StakePool<T0, T1>, arg1: u64, arg2: &0xcfd55d438c9d1210a846c72cacfdef1a245bda2e8c8e31b3395434b0b3e08efb::stake_config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xcfd55d438c9d1210a846c72cacfdef1a245bda2e8c8e31b3395434b0b3e08efb::stake::unstake<T0, T1>(arg0, arg1, arg2, 0x2::clock::timestamp_ms(arg3), arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun enable_global_emergency(arg0: &mut 0xcfd55d438c9d1210a846c72cacfdef1a245bda2e8c8e31b3395434b0b3e08efb::stake_config::GlobalConfig, arg1: &mut 0x2::tx_context::TxContext) {
        0xcfd55d438c9d1210a846c72cacfdef1a245bda2e8c8e31b3395434b0b3e08efb::stake_config::enable_global_emergency(arg0, arg1);
    }

    public entry fun set_emergency_admin_address(arg0: &mut 0xcfd55d438c9d1210a846c72cacfdef1a245bda2e8c8e31b3395434b0b3e08efb::stake_config::GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xcfd55d438c9d1210a846c72cacfdef1a245bda2e8c8e31b3395434b0b3e08efb::stake_config::set_emergency_admin_address(arg0, arg1, arg2);
    }

    public entry fun set_treasury_admin_address(arg0: &mut 0xcfd55d438c9d1210a846c72cacfdef1a245bda2e8c8e31b3395434b0b3e08efb::stake_config::GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xcfd55d438c9d1210a846c72cacfdef1a245bda2e8c8e31b3395434b0b3e08efb::stake_config::set_treasury_admin_address(arg0, arg1, arg2);
    }

    public entry fun withdraw_reward_to_treasury<T0, T1>(arg0: &mut 0xcfd55d438c9d1210a846c72cacfdef1a245bda2e8c8e31b3395434b0b3e08efb::stake::StakePool<T0, T1>, arg1: u64, arg2: &0xcfd55d438c9d1210a846c72cacfdef1a245bda2e8c8e31b3395434b0b3e08efb::stake_config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xcfd55d438c9d1210a846c72cacfdef1a245bda2e8c8e31b3395434b0b3e08efb::stake::withdraw_to_treasury<T0, T1>(arg0, arg1, arg2, 0x2::clock::timestamp_ms(arg3), arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

