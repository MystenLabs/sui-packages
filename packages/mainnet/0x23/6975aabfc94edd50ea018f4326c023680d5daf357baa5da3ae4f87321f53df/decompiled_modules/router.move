module 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::router {
    public fun add_hive_to_locked_dragon_bee<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::DragonFood, arg2: &mut 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::YieldFarm, arg3: &mut 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::PoolHive<T0>, arg4: &mut 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::DragonTrainer, arg5: 0x2::coin::Coin<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>(0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::add_hive_to_locked_dragon_bee<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7), 0x2::tx_context::sender(arg7), arg7);
    }

    public fun add_honey_to_locked_dragon_bee<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::DragonFood, arg2: &mut 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::YieldFarm, arg3: &mut 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::PoolHive<T0>, arg4: &mut 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::DragonTrainer, arg5: &mut 0x6f6c10f87906cd84d39f1e52abb6eae13a4ed1f07ee3981511892b17af506f87::honey_trade::HoneyManager<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::honey::HONEY>, arg6: &mut 0x2::token::TokenPolicy<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::honey::HONEY>, arg7: &mut 0x2::token::Token<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::honey::HONEY>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>(0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::add_honey_to_locked_dragon_bee<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9), 0x2::tx_context::sender(arg9), arg9);
    }

    public fun claim_voting_rewards_three_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::DragonFood, arg2: &mut 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::YieldFarm, arg3: &mut 0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::yield_flow::YieldFlow, arg4: &mut 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::PoolHive<T0>, arg5: &mut 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::DragonTrainer, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::claim_voting_rewards_three_pool<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<T1>(v1, 0x2::tx_context::sender(arg6), arg6);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<T2>(v2, 0x2::tx_context::sender(arg6), arg6);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<T3>(v3, 0x2::tx_context::sender(arg6), arg6);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>(v0, 0x2::tx_context::sender(arg6), arg6);
    }

    public fun claim_voting_rewards_two_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::DragonFood, arg2: &mut 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::YieldFarm, arg3: &mut 0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::yield_flow::YieldFlow, arg4: &mut 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::PoolHive<T0>, arg5: &mut 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::DragonTrainer, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::claim_voting_rewards_two_pool<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<T1>(v1, 0x2::tx_context::sender(arg6), arg6);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<T2>(v2, 0x2::tx_context::sender(arg6), arg6);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>(v0, 0x2::tx_context::sender(arg6), arg6);
    }

    public fun feed_bee_in_den<T0>(arg0: &mut 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::DragonFood, arg1: &0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::YieldFarm, arg2: &mut 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::BeesManager, arg3: &mut 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::PoolHive<T0>, arg4: &mut 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::DragonTrainer, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>(0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::feed_bee_in_den<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6), 0x2::tx_context::sender(arg6), arg6);
    }

    public entry fun stake_lp_0_fruits<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::DragonFood, arg2: &mut 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::YieldFarm, arg3: &mut 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::PoolHive<T0>, arg4: &mut 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::DragonTrainer, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg5);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<T0>(v0, 0x2::tx_context::sender(arg7), arg7);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>(0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::stake_lp_0_fruits<T0>(arg0, arg1, arg2, arg3, arg4, 0x2::balance::split<T0>(&mut v0, arg6), arg7), 0x2::tx_context::sender(arg7), arg7);
    }

    public entry fun stake_lp_1_fruits<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::DragonFood, arg2: &mut 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::YieldFarm, arg3: &mut 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::PoolHive<T0>, arg4: &mut 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::DragonTrainer, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg5);
        let (v1, v2) = 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::stake_lp_1_fruits<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x2::balance::split<T0>(&mut v0, arg6), arg7);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<T0>(v0, 0x2::tx_context::sender(arg7), arg7);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<T1>(v2, 0x2::tx_context::sender(arg7), arg7);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>(v1, 0x2::tx_context::sender(arg7), arg7);
    }

    public entry fun stake_lp_2_fruits<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::DragonFood, arg2: &mut 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::YieldFarm, arg3: &mut 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::PoolHive<T0>, arg4: &mut 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::DragonTrainer, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg5);
        let (v1, v2, v3) = 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::stake_lp_2_fruits<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, 0x2::balance::split<T0>(&mut v0, arg6), arg7);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<T0>(v0, 0x2::tx_context::sender(arg7), arg7);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<T1>(v2, 0x2::tx_context::sender(arg7), arg7);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<T2>(v3, 0x2::tx_context::sender(arg7), arg7);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>(v1, 0x2::tx_context::sender(arg7), arg7);
    }

    public entry fun stake_lp_3_fruits<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::DragonFood, arg2: &mut 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::YieldFarm, arg3: &mut 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::PoolHive<T0>, arg4: &mut 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::DragonTrainer, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg5);
        let (v1, v2, v3, v4) = 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::stake_lp_3_fruits<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, 0x2::balance::split<T0>(&mut v0, arg6), arg7);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<T0>(v0, 0x2::tx_context::sender(arg7), arg7);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<T1>(v2, 0x2::tx_context::sender(arg7), arg7);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<T2>(v3, 0x2::tx_context::sender(arg7), arg7);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<T3>(v4, 0x2::tx_context::sender(arg7), arg7);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>(v1, 0x2::tx_context::sender(arg7), arg7);
    }

    public entry fun unbond_from_dragon_den_0_fruits<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::DragonFood, arg2: &mut 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::YieldFarm, arg3: &mut 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::PoolHive<T0>, arg4: &mut 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::DragonTrainer, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::unbond_from_dragon_den_0_fruits<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>(v0, 0x2::tx_context::sender(arg6), arg6);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<T0>(v1, 0x2::tx_context::sender(arg6), arg6);
    }

    public entry fun unbond_from_dragon_den_1_fruits<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::DragonFood, arg2: &mut 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::YieldFarm, arg3: &mut 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::PoolHive<T0>, arg4: &mut 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::DragonTrainer, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::unbond_from_dragon_den_1_fruits<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<T1>(v1, 0x2::tx_context::sender(arg6), arg6);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>(v0, 0x2::tx_context::sender(arg6), arg6);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<T0>(v2, 0x2::tx_context::sender(arg6), arg6);
    }

    public entry fun unbond_from_dragon_den_2_fruits<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::DragonFood, arg2: &mut 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::YieldFarm, arg3: &mut 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::PoolHive<T0>, arg4: &mut 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::DragonTrainer, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::unbond_from_dragon_den_2_fruits<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<T1>(v1, 0x2::tx_context::sender(arg6), arg6);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<T2>(v2, 0x2::tx_context::sender(arg6), arg6);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>(v0, 0x2::tx_context::sender(arg6), arg6);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<T0>(v3, 0x2::tx_context::sender(arg6), arg6);
    }

    public entry fun unbond_from_dragon_den_3_fruits<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::DragonFood, arg2: &mut 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::YieldFarm, arg3: &mut 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::PoolHive<T0>, arg4: &mut 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::DragonTrainer, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4) = 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::unbond_from_dragon_den_3_fruits<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<T1>(v1, 0x2::tx_context::sender(arg6), arg6);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<T2>(v2, 0x2::tx_context::sender(arg6), arg6);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<T3>(v3, 0x2::tx_context::sender(arg6), arg6);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>(v0, 0x2::tx_context::sender(arg6), arg6);
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<T0>(v4, 0x2::tx_context::sender(arg6), arg6);
    }

    public fun withdraw_dragon_bee<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::DragonFood, arg2: &mut 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::BeesManager, arg3: &mut 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::YieldFarm, arg4: &mut 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::PoolHive<T0>, arg5: &mut 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::DragonTrainer, arg6: &mut 0x2::tx_context::TxContext) {
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>(0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::withdraw_dragon_bee<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6), 0x2::tx_context::sender(arg6), arg6);
    }

    // decompiled from Move bytecode v6
}

