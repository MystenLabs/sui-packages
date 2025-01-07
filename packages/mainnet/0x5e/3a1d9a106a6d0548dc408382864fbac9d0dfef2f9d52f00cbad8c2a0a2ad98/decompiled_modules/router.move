module 0x5e3a1d9a106a6d0548dc408382864fbac9d0dfef2f9d52f00cbad8c2a0a2ad98::router {
    public entry fun deposit_into_bee_box_1_fruits<T0, T1>(arg0: &mut 0x5e3a1d9a106a6d0548dc408382864fbac9d0dfef2f9d52f00cbad8c2a0a2ad98::dex_dao::PoolsGovernor, arg1: &mut 0x5e3a1d9a106a6d0548dc408382864fbac9d0dfef2f9d52f00cbad8c2a0a2ad98::dex_dao::PoolHive<T0>, arg2: &mut 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::HiveProfile, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        let v1 = 0x5e3a1d9a106a6d0548dc408382864fbac9d0dfef2f9d52f00cbad8c2a0a2ad98::dex_dao::deposit_into_bee_box_1_fruits<T0, T1>(arg0, arg1, arg2, 0x2::balance::split<T0>(&mut v0, arg4), arg5);
        let v2 = 0x2::tx_context::sender(arg5);
        destroy_or_transfer_balance<T0>(v0, v2, arg5);
        let v3 = 0x2::tx_context::sender(arg5);
        destroy_or_transfer_balance<T1>(v1, v3, arg5);
    }

    public entry fun deposit_into_bee_box_2_fruits<T0, T1, T2>(arg0: &mut 0x5e3a1d9a106a6d0548dc408382864fbac9d0dfef2f9d52f00cbad8c2a0a2ad98::dex_dao::PoolsGovernor, arg1: &mut 0x5e3a1d9a106a6d0548dc408382864fbac9d0dfef2f9d52f00cbad8c2a0a2ad98::dex_dao::PoolHive<T0>, arg2: &mut 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::HiveProfile, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        let (v1, v2) = 0x5e3a1d9a106a6d0548dc408382864fbac9d0dfef2f9d52f00cbad8c2a0a2ad98::dex_dao::deposit_into_bee_box_2_fruits<T0, T1, T2>(arg0, arg1, arg2, 0x2::balance::split<T0>(&mut v0, arg4), arg5);
        let v3 = 0x2::tx_context::sender(arg5);
        destroy_or_transfer_balance<T0>(v0, v3, arg5);
        let v4 = 0x2::tx_context::sender(arg5);
        destroy_or_transfer_balance<T1>(v1, v4, arg5);
        let v5 = 0x2::tx_context::sender(arg5);
        destroy_or_transfer_balance<T2>(v2, v5, arg5);
    }

    public entry fun deposit_into_bee_box_3_fruits<T0, T1, T2, T3>(arg0: &mut 0x5e3a1d9a106a6d0548dc408382864fbac9d0dfef2f9d52f00cbad8c2a0a2ad98::dex_dao::PoolsGovernor, arg1: &mut 0x5e3a1d9a106a6d0548dc408382864fbac9d0dfef2f9d52f00cbad8c2a0a2ad98::dex_dao::PoolHive<T0>, arg2: &mut 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::HiveProfile, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        let (v1, v2, v3) = 0x5e3a1d9a106a6d0548dc408382864fbac9d0dfef2f9d52f00cbad8c2a0a2ad98::dex_dao::deposit_into_bee_box_3_fruits<T0, T1, T2, T3>(arg0, arg1, arg2, 0x2::balance::split<T0>(&mut v0, arg4), arg5);
        let v4 = 0x2::tx_context::sender(arg5);
        destroy_or_transfer_balance<T0>(v0, v4, arg5);
        let v5 = 0x2::tx_context::sender(arg5);
        destroy_or_transfer_balance<T1>(v1, v5, arg5);
        let v6 = 0x2::tx_context::sender(arg5);
        destroy_or_transfer_balance<T2>(v2, v6, arg5);
        let v7 = 0x2::tx_context::sender(arg5);
        destroy_or_transfer_balance<T3>(v3, v7, arg5);
    }

    public entry fun deposit_into_bee_box_no_fruits<T0>(arg0: &mut 0x5e3a1d9a106a6d0548dc408382864fbac9d0dfef2f9d52f00cbad8c2a0a2ad98::dex_dao::PoolsGovernor, arg1: &mut 0x5e3a1d9a106a6d0548dc408382864fbac9d0dfef2f9d52f00cbad8c2a0a2ad98::dex_dao::PoolHive<T0>, arg2: &mut 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::HiveProfile, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        0x5e3a1d9a106a6d0548dc408382864fbac9d0dfef2f9d52f00cbad8c2a0a2ad98::dex_dao::deposit_into_bee_box_no_fruits<T0>(arg0, arg1, arg2, 0x2::balance::split<T0>(&mut v0, arg4), arg5);
        let v1 = 0x2::tx_context::sender(arg5);
        destroy_or_transfer_balance<T0>(v0, v1, arg5);
    }

    public entry fun unbond_from_bee_box_2_fruits<T0, T1, T2>(arg0: &mut 0x5e3a1d9a106a6d0548dc408382864fbac9d0dfef2f9d52f00cbad8c2a0a2ad98::dex_dao::PoolsGovernor, arg1: &mut 0x5e3a1d9a106a6d0548dc408382864fbac9d0dfef2f9d52f00cbad8c2a0a2ad98::dex_dao::PoolHive<T0>, arg2: &mut 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::HiveProfile, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x5e3a1d9a106a6d0548dc408382864fbac9d0dfef2f9d52f00cbad8c2a0a2ad98::dex_dao::unbond_from_bee_box_2_fruits<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
        let v3 = 0x2::tx_context::sender(arg4);
        destroy_or_transfer_balance<T0>(v0, v3, arg4);
        let v4 = 0x2::tx_context::sender(arg4);
        destroy_or_transfer_balance<T1>(v1, v4, arg4);
        let v5 = 0x2::tx_context::sender(arg4);
        destroy_or_transfer_balance<T2>(v2, v5, arg4);
    }

    public entry fun unbond_from_bee_box_3_fruits<T0, T1, T2, T3>(arg0: &mut 0x5e3a1d9a106a6d0548dc408382864fbac9d0dfef2f9d52f00cbad8c2a0a2ad98::dex_dao::PoolsGovernor, arg1: &mut 0x5e3a1d9a106a6d0548dc408382864fbac9d0dfef2f9d52f00cbad8c2a0a2ad98::dex_dao::PoolHive<T0>, arg2: &mut 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::HiveProfile, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x5e3a1d9a106a6d0548dc408382864fbac9d0dfef2f9d52f00cbad8c2a0a2ad98::dex_dao::unbond_from_bee_box_3_fruits<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4);
        let v4 = 0x2::tx_context::sender(arg4);
        destroy_or_transfer_balance<T0>(v0, v4, arg4);
        let v5 = 0x2::tx_context::sender(arg4);
        destroy_or_transfer_balance<T1>(v1, v5, arg4);
        let v6 = 0x2::tx_context::sender(arg4);
        destroy_or_transfer_balance<T2>(v2, v6, arg4);
        let v7 = 0x2::tx_context::sender(arg4);
        destroy_or_transfer_balance<T3>(v3, v7, arg4);
    }

    public entry fun unlock_from_bee_box<T0>(arg0: &mut 0x5e3a1d9a106a6d0548dc408382864fbac9d0dfef2f9d52f00cbad8c2a0a2ad98::dex_dao::PoolHive<T0>, arg1: &mut 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::HiveProfile, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5e3a1d9a106a6d0548dc408382864fbac9d0dfef2f9d52f00cbad8c2a0a2ad98::dex_dao::unlock_from_bee_box<T0>(arg0, arg1, arg2);
        let v1 = 0x2::tx_context::sender(arg2);
        destroy_or_transfer_balance<T0>(v0, v1, arg2);
    }

    fun destroy_or_transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    public entry fun unbond_from_bee_box_1_fruits<T0, T1>(arg0: &mut 0x5e3a1d9a106a6d0548dc408382864fbac9d0dfef2f9d52f00cbad8c2a0a2ad98::dex_dao::PoolsGovernor, arg1: &mut 0x5e3a1d9a106a6d0548dc408382864fbac9d0dfef2f9d52f00cbad8c2a0a2ad98::dex_dao::PoolHive<T0>, arg2: &mut 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::HiveProfile, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x5e3a1d9a106a6d0548dc408382864fbac9d0dfef2f9d52f00cbad8c2a0a2ad98::dex_dao::unbond_from_bee_box_1_fruit<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        let v2 = 0x2::tx_context::sender(arg4);
        destroy_or_transfer_balance<T0>(v0, v2, arg4);
        let v3 = 0x2::tx_context::sender(arg4);
        destroy_or_transfer_balance<T1>(v1, v3, arg4);
    }

    public entry fun unbond_from_bee_box_no_fruits<T0>(arg0: &mut 0x5e3a1d9a106a6d0548dc408382864fbac9d0dfef2f9d52f00cbad8c2a0a2ad98::dex_dao::PoolsGovernor, arg1: &mut 0x5e3a1d9a106a6d0548dc408382864fbac9d0dfef2f9d52f00cbad8c2a0a2ad98::dex_dao::PoolHive<T0>, arg2: &mut 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::HiveProfile, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5e3a1d9a106a6d0548dc408382864fbac9d0dfef2f9d52f00cbad8c2a0a2ad98::dex_dao::unbond_from_bee_box_no_fruit<T0>(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0x2::tx_context::sender(arg4);
        destroy_or_transfer_balance<T0>(v0, v1, arg4);
    }

    // decompiled from Move bytecode v6
}

