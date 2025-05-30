module 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::router {
    public entry fun deposit_into_bee_box_1_fruits<T0, T1>(arg0: &mut 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::DexDaoConfig, arg1: &mut 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::PoolHive<T0>, arg2: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::HiveProfile, arg3: &mut 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::BeeFruit<T1>, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg4);
        let v1 = 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::deposit_into_bee_box_1_fruits<T0, T1>(arg0, arg1, arg2, arg3, 0x2::balance::split<T0>(&mut v0, arg5), arg6);
        let v2 = 0x2::tx_context::sender(arg6);
        destroy_or_transfer_balance<T0>(v0, v2, arg6);
        let v3 = 0x2::tx_context::sender(arg6);
        destroy_or_transfer_balance<T1>(v1, v3, arg6);
    }

    public entry fun deposit_into_bee_box_2_fruits<T0, T1, T2>(arg0: &mut 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::DexDaoConfig, arg1: &mut 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::PoolHive<T0>, arg2: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::HiveProfile, arg3: &mut 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::BeeFruit<T1>, arg4: &mut 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::BeeFruit<T2>, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg5);
        let (v1, v2) = 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::deposit_into_bee_box_2_fruits<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, 0x2::balance::split<T0>(&mut v0, arg6), arg7);
        let v3 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T0>(v0, v3, arg7);
        let v4 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T1>(v1, v4, arg7);
        let v5 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T2>(v2, v5, arg7);
    }

    public entry fun deposit_into_bee_box_3_fruits<T0, T1, T2, T3>(arg0: &mut 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::DexDaoConfig, arg1: &mut 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::PoolHive<T0>, arg2: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::HiveProfile, arg3: &mut 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::BeeFruit<T1>, arg4: &mut 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::BeeFruit<T2>, arg5: &mut 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::BeeFruit<T3>, arg6: 0x2::coin::Coin<T0>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg6);
        let (v1, v2, v3) = 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::deposit_into_bee_box_3_fruits<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::balance::split<T0>(&mut v0, arg7), arg8);
        let v4 = 0x2::tx_context::sender(arg8);
        destroy_or_transfer_balance<T0>(v0, v4, arg8);
        let v5 = 0x2::tx_context::sender(arg8);
        destroy_or_transfer_balance<T1>(v1, v5, arg8);
        let v6 = 0x2::tx_context::sender(arg8);
        destroy_or_transfer_balance<T2>(v2, v6, arg8);
        let v7 = 0x2::tx_context::sender(arg8);
        destroy_or_transfer_balance<T3>(v3, v7, arg8);
    }

    public entry fun deposit_into_bee_box_no_fruits<T0>(arg0: &mut 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::DexDaoConfig, arg1: &mut 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::PoolHive<T0>, arg2: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::HiveProfile, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::deposit_into_bee_box_no_fruits<T0>(arg0, arg1, arg2, 0x2::balance::split<T0>(&mut v0, arg4), arg5);
        let v1 = 0x2::tx_context::sender(arg5);
        destroy_or_transfer_balance<T0>(v0, v1, arg5);
    }

    public entry fun unbond_from_bee_box_2_fruits<T0, T1, T2>(arg0: &mut 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::DexDaoConfig, arg1: &mut 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::PoolHive<T0>, arg2: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::HiveProfile, arg3: &mut 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::BeeFruit<T1>, arg4: &mut 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::BeeFruit<T2>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::unbond_from_bee_box_2_fruits<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v3 = 0x2::tx_context::sender(arg6);
        destroy_or_transfer_balance<T0>(v0, v3, arg6);
        let v4 = 0x2::tx_context::sender(arg6);
        destroy_or_transfer_balance<T1>(v1, v4, arg6);
        let v5 = 0x2::tx_context::sender(arg6);
        destroy_or_transfer_balance<T2>(v2, v5, arg6);
    }

    public entry fun unbond_from_bee_box_3_fruits<T0, T1, T2, T3>(arg0: &mut 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::DexDaoConfig, arg1: &mut 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::PoolHive<T0>, arg2: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::HiveProfile, arg3: &mut 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::BeeFruit<T1>, arg4: &mut 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::BeeFruit<T2>, arg5: &mut 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::BeeFruit<T3>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::unbond_from_bee_box_3_fruits<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v4 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T0>(v0, v4, arg7);
        let v5 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T1>(v1, v5, arg7);
        let v6 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T2>(v2, v6, arg7);
        let v7 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T3>(v3, v7, arg7);
    }

    public entry fun unlock_from_bee_box<T0>(arg0: &mut 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::PoolHive<T0>, arg1: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::HiveProfile, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::unlock_from_bee_box<T0>(arg0, arg1, arg2);
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

    public entry fun unbond_from_bee_box_1_fruits<T0, T1>(arg0: &mut 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::DexDaoConfig, arg1: &mut 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::PoolHive<T0>, arg2: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::HiveProfile, arg3: &mut 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::BeeFruit<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::unbond_from_bee_box_1_fruit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v2 = 0x2::tx_context::sender(arg5);
        destroy_or_transfer_balance<T0>(v0, v2, arg5);
        let v3 = 0x2::tx_context::sender(arg5);
        destroy_or_transfer_balance<T1>(v1, v3, arg5);
    }

    public entry fun unbond_from_bee_box_no_fruits<T0>(arg0: &mut 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::DexDaoConfig, arg1: &mut 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::PoolHive<T0>, arg2: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::HiveProfile, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao::unbond_from_bee_box_no_fruit<T0>(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0x2::tx_context::sender(arg4);
        destroy_or_transfer_balance<T0>(v0, v1, arg4);
    }

    // decompiled from Move bytecode v6
}

