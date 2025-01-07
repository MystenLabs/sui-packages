module 0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::router {
    public entry fun deposit_into_stake_box_0_fruits<T0>(arg0: &mut 0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::dex_dao::PoolsGovernor, arg1: &mut 0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::dex_dao::PoolHive<T0>, arg2: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveProfile, arg3: &mut 0x2::token::TokenPolicy<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::bee::BEE>, arg4: &0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::bee_trade::BeesManager<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::bee::BEE>, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg5);
        let v1 = 0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::dex_dao::deposit_into_stake_box_0_fruits<T0>(arg0, arg1, arg2, 0x2::balance::split<T0>(&mut v0, arg6), arg7);
        let v2 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T0>(v0, v2, arg7);
        0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::bee_trade::transfer_bees_balance(arg3, arg4, v1, 0x2::tx_context::sender(arg7), arg7);
    }

    public entry fun deposit_into_stake_box_1_fruits<T0, T1>(arg0: &mut 0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::dex_dao::PoolsGovernor, arg1: &mut 0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::dex_dao::PoolHive<T0>, arg2: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveProfile, arg3: &mut 0x2::token::TokenPolicy<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::bee::BEE>, arg4: &0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::bee_trade::BeesManager<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::bee::BEE>, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg5);
        let (v1, v2) = 0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::dex_dao::deposit_into_stake_box_1_fruits<T0, T1>(arg0, arg1, arg2, 0x2::balance::split<T0>(&mut v0, arg6), arg7);
        let v3 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T0>(v0, v3, arg7);
        let v4 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T1>(v2, v4, arg7);
        0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::bee_trade::transfer_bees_balance(arg3, arg4, v1, 0x2::tx_context::sender(arg7), arg7);
    }

    public entry fun deposit_into_stake_box_2_fruits<T0, T1, T2>(arg0: &mut 0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::dex_dao::PoolsGovernor, arg1: &mut 0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::dex_dao::PoolHive<T0>, arg2: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveProfile, arg3: &mut 0x2::token::TokenPolicy<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::bee::BEE>, arg4: &0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::bee_trade::BeesManager<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::bee::BEE>, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg5);
        let (v1, v2, v3) = 0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::dex_dao::deposit_into_stake_box_2_fruits<T0, T1, T2>(arg0, arg1, arg2, 0x2::balance::split<T0>(&mut v0, arg6), arg7);
        let v4 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T0>(v0, v4, arg7);
        let v5 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T1>(v2, v5, arg7);
        let v6 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T2>(v3, v6, arg7);
        0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::bee_trade::transfer_bees_balance(arg3, arg4, v1, 0x2::tx_context::sender(arg7), arg7);
    }

    public entry fun deposit_into_stake_box_3_fruits<T0, T1, T2, T3>(arg0: &mut 0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::dex_dao::PoolsGovernor, arg1: &mut 0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::dex_dao::PoolHive<T0>, arg2: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveProfile, arg3: &mut 0x2::token::TokenPolicy<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::bee::BEE>, arg4: &0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::bee_trade::BeesManager<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::bee::BEE>, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg5);
        let (v1, v2, v3, v4) = 0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::dex_dao::deposit_into_stake_box_3_fruits<T0, T1, T2, T3>(arg0, arg1, arg2, 0x2::balance::split<T0>(&mut v0, arg6), arg7);
        let v5 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T0>(v0, v5, arg7);
        let v6 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T1>(v2, v6, arg7);
        let v7 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T2>(v3, v7, arg7);
        let v8 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T3>(v4, v8, arg7);
        0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::bee_trade::transfer_bees_balance(arg3, arg4, v1, 0x2::tx_context::sender(arg7), arg7);
    }

    public entry fun unbond_from_stake_box_0_fruits<T0>(arg0: &mut 0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::dex_dao::PoolsGovernor, arg1: &mut 0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::dex_dao::PoolHive<T0>, arg2: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveProfile, arg3: &mut 0x2::token::TokenPolicy<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::bee::BEE>, arg4: &0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::bee_trade::BeesManager<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::bee::BEE>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::bee_trade::transfer_bees_balance(arg3, arg4, 0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::dex_dao::unbond_from_stake_box_0_fruits<T0>(arg0, arg1, arg2, arg5, arg6), 0x2::tx_context::sender(arg6), arg6);
    }

    public entry fun unbond_from_stake_box_1_fruits<T0, T1>(arg0: &mut 0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::dex_dao::PoolsGovernor, arg1: &mut 0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::dex_dao::PoolHive<T0>, arg2: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveProfile, arg3: &mut 0x2::token::TokenPolicy<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::bee::BEE>, arg4: &0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::bee_trade::BeesManager<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::bee::BEE>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::dex_dao::unbond_from_stake_box_1_fruits<T0, T1>(arg0, arg1, arg2, arg5, arg6);
        let v2 = 0x2::tx_context::sender(arg6);
        destroy_or_transfer_balance<T1>(v1, v2, arg6);
        0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::bee_trade::transfer_bees_balance(arg3, arg4, v0, 0x2::tx_context::sender(arg6), arg6);
    }

    public entry fun unbond_from_stake_box_2_fruits<T0, T1, T2>(arg0: &mut 0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::dex_dao::PoolsGovernor, arg1: &mut 0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::dex_dao::PoolHive<T0>, arg2: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveProfile, arg3: &mut 0x2::token::TokenPolicy<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::bee::BEE>, arg4: &0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::bee_trade::BeesManager<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::bee::BEE>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::dex_dao::unbond_from_stake_box_2_fruits<T0, T1, T2>(arg0, arg1, arg2, arg5, arg6);
        let v3 = 0x2::tx_context::sender(arg6);
        destroy_or_transfer_balance<T1>(v1, v3, arg6);
        let v4 = 0x2::tx_context::sender(arg6);
        destroy_or_transfer_balance<T2>(v2, v4, arg6);
        0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::bee_trade::transfer_bees_balance(arg3, arg4, v0, 0x2::tx_context::sender(arg6), arg6);
    }

    public entry fun unbond_from_stake_box_3_fruits<T0, T1, T2, T3>(arg0: &mut 0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::dex_dao::PoolsGovernor, arg1: &mut 0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::dex_dao::PoolHive<T0>, arg2: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveProfile, arg3: &mut 0x2::token::TokenPolicy<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::bee::BEE>, arg4: &0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::bee_trade::BeesManager<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::bee::BEE>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::dex_dao::unbond_from_stake_box_3_fruits<T0, T1, T2, T3>(arg0, arg1, arg2, arg5, arg6);
        let v4 = 0x2::tx_context::sender(arg6);
        destroy_or_transfer_balance<T1>(v1, v4, arg6);
        let v5 = 0x2::tx_context::sender(arg6);
        destroy_or_transfer_balance<T2>(v2, v5, arg6);
        let v6 = 0x2::tx_context::sender(arg6);
        destroy_or_transfer_balance<T3>(v3, v6, arg6);
        0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::bee_trade::transfer_bees_balance(arg3, arg4, v0, 0x2::tx_context::sender(arg6), arg6);
    }

    public entry fun unlock_from_stake_box<T0>(arg0: &mut 0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::dex_dao::PoolHive<T0>, arg1: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveProfile, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::dex_dao::unlock_from_stake_box<T0>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::tx_context::sender(arg3);
        destroy_or_transfer_balance<T0>(v0, v1, arg3);
    }

    fun destroy_or_transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    // decompiled from Move bytecode v6
}

