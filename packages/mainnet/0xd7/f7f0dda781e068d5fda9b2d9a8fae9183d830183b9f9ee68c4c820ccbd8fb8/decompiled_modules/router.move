module 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::router {
    public fun add_hive_to_locked_dragon_bee<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::DragonFood, arg2: &mut 0x26d99bb986dbcb78436ee2577636477a0068bfa9e48034253d08cb889f0358a4::dragon_trainer::YieldFarm, arg3: &mut 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::PoolHive<T0>, arg4: &mut 0x26d99bb986dbcb78436ee2577636477a0068bfa9e48034253d08cb889f0358a4::dragon_trainer::DragonTrainer, arg5: 0x2::coin::Coin<0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::hive::HIVE>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::hive::HIVE>(0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::add_hive_to_locked_dragon_bee<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7), 0x2::tx_context::sender(arg7), arg7);
    }

    public fun add_honey_to_locked_dragon_bee<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::DragonFood, arg2: &mut 0x26d99bb986dbcb78436ee2577636477a0068bfa9e48034253d08cb889f0358a4::dragon_trainer::YieldFarm, arg3: &mut 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::PoolHive<T0>, arg4: &mut 0x26d99bb986dbcb78436ee2577636477a0068bfa9e48034253d08cb889f0358a4::dragon_trainer::DragonTrainer, arg5: &mut 0x62e9bfeefe2da17b3c30f44828027c04b376c20076e80c54afc855e4069d09dc::honey_trade::HoneyManager<0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::honey::HONEY>, arg6: &mut 0x2::token::TokenPolicy<0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::honey::HONEY>, arg7: &mut 0x2::token::Token<0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::honey::HONEY>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::hive::HIVE>(0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::add_honey_to_locked_dragon_bee<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9), 0x2::tx_context::sender(arg9), arg9);
    }

    public fun claim_voting_rewards_three_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::DragonFood, arg2: &mut 0x26d99bb986dbcb78436ee2577636477a0068bfa9e48034253d08cb889f0358a4::dragon_trainer::YieldFarm, arg3: &mut 0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::yield_flow::YieldFlow, arg4: &mut 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::PoolHive<T0>, arg5: &mut 0x26d99bb986dbcb78436ee2577636477a0068bfa9e48034253d08cb889f0358a4::dragon_trainer::DragonTrainer, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::claim_voting_rewards_three_pool<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<T1>(v1, 0x2::tx_context::sender(arg6), arg6);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<T2>(v2, 0x2::tx_context::sender(arg6), arg6);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<T3>(v3, 0x2::tx_context::sender(arg6), arg6);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::hive::HIVE>(v0, 0x2::tx_context::sender(arg6), arg6);
    }

    public fun claim_voting_rewards_two_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::DragonFood, arg2: &mut 0x26d99bb986dbcb78436ee2577636477a0068bfa9e48034253d08cb889f0358a4::dragon_trainer::YieldFarm, arg3: &mut 0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::yield_flow::YieldFlow, arg4: &mut 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::PoolHive<T0>, arg5: &mut 0x26d99bb986dbcb78436ee2577636477a0068bfa9e48034253d08cb889f0358a4::dragon_trainer::DragonTrainer, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::claim_voting_rewards_two_pool<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<T1>(v1, 0x2::tx_context::sender(arg6), arg6);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<T2>(v2, 0x2::tx_context::sender(arg6), arg6);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::hive::HIVE>(v0, 0x2::tx_context::sender(arg6), arg6);
    }

    public fun feed_bee_in_den<T0>(arg0: &mut 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::DragonFood, arg1: &0x26d99bb986dbcb78436ee2577636477a0068bfa9e48034253d08cb889f0358a4::dragon_trainer::YieldFarm, arg2: &mut 0x26d99bb986dbcb78436ee2577636477a0068bfa9e48034253d08cb889f0358a4::dragon_trainer::BeesManager, arg3: &mut 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::PoolHive<T0>, arg4: &mut 0x26d99bb986dbcb78436ee2577636477a0068bfa9e48034253d08cb889f0358a4::dragon_trainer::DragonTrainer, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::hive::HIVE>(0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::feed_bee_in_den<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6), 0x2::tx_context::sender(arg6), arg6);
    }

    public entry fun stake_lp_0_fruits<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::DragonFood, arg2: &mut 0x26d99bb986dbcb78436ee2577636477a0068bfa9e48034253d08cb889f0358a4::dragon_trainer::YieldFarm, arg3: &mut 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::PoolHive<T0>, arg4: &mut 0x26d99bb986dbcb78436ee2577636477a0068bfa9e48034253d08cb889f0358a4::dragon_trainer::DragonTrainer, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg5);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<T0>(v0, 0x2::tx_context::sender(arg7), arg7);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::hive::HIVE>(0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::stake_lp_0_fruits<T0>(arg0, arg1, arg2, arg3, arg4, 0x2::balance::split<T0>(&mut v0, arg6), arg7), 0x2::tx_context::sender(arg7), arg7);
    }

    public entry fun stake_lp_1_fruits<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::DragonFood, arg2: &mut 0x26d99bb986dbcb78436ee2577636477a0068bfa9e48034253d08cb889f0358a4::dragon_trainer::YieldFarm, arg3: &mut 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::PoolHive<T0>, arg4: &mut 0x26d99bb986dbcb78436ee2577636477a0068bfa9e48034253d08cb889f0358a4::dragon_trainer::DragonTrainer, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg5);
        let (v1, v2) = 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::stake_lp_1_fruits<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x2::balance::split<T0>(&mut v0, arg6), arg7);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<T0>(v0, 0x2::tx_context::sender(arg7), arg7);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<T1>(v2, 0x2::tx_context::sender(arg7), arg7);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::hive::HIVE>(v1, 0x2::tx_context::sender(arg7), arg7);
    }

    public entry fun stake_lp_2_fruits<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::DragonFood, arg2: &mut 0x26d99bb986dbcb78436ee2577636477a0068bfa9e48034253d08cb889f0358a4::dragon_trainer::YieldFarm, arg3: &mut 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::PoolHive<T0>, arg4: &mut 0x26d99bb986dbcb78436ee2577636477a0068bfa9e48034253d08cb889f0358a4::dragon_trainer::DragonTrainer, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg5);
        let (v1, v2, v3) = 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::stake_lp_2_fruits<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, 0x2::balance::split<T0>(&mut v0, arg6), arg7);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<T0>(v0, 0x2::tx_context::sender(arg7), arg7);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<T1>(v2, 0x2::tx_context::sender(arg7), arg7);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<T2>(v3, 0x2::tx_context::sender(arg7), arg7);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::hive::HIVE>(v1, 0x2::tx_context::sender(arg7), arg7);
    }

    public entry fun stake_lp_3_fruits<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::DragonFood, arg2: &mut 0x26d99bb986dbcb78436ee2577636477a0068bfa9e48034253d08cb889f0358a4::dragon_trainer::YieldFarm, arg3: &mut 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::PoolHive<T0>, arg4: &mut 0x26d99bb986dbcb78436ee2577636477a0068bfa9e48034253d08cb889f0358a4::dragon_trainer::DragonTrainer, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg5);
        let (v1, v2, v3, v4) = 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::stake_lp_3_fruits<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, 0x2::balance::split<T0>(&mut v0, arg6), arg7);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<T0>(v0, 0x2::tx_context::sender(arg7), arg7);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<T1>(v2, 0x2::tx_context::sender(arg7), arg7);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<T2>(v3, 0x2::tx_context::sender(arg7), arg7);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<T3>(v4, 0x2::tx_context::sender(arg7), arg7);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::hive::HIVE>(v1, 0x2::tx_context::sender(arg7), arg7);
    }

    public entry fun unbond_from_dragon_den_0_fruits<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::DragonFood, arg2: &mut 0x26d99bb986dbcb78436ee2577636477a0068bfa9e48034253d08cb889f0358a4::dragon_trainer::YieldFarm, arg3: &mut 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::PoolHive<T0>, arg4: &mut 0x26d99bb986dbcb78436ee2577636477a0068bfa9e48034253d08cb889f0358a4::dragon_trainer::DragonTrainer, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::unbond_from_dragon_den_0_fruits<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::hive::HIVE>(v0, 0x2::tx_context::sender(arg6), arg6);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<T0>(v1, 0x2::tx_context::sender(arg6), arg6);
    }

    public entry fun unbond_from_dragon_den_1_fruits<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::DragonFood, arg2: &mut 0x26d99bb986dbcb78436ee2577636477a0068bfa9e48034253d08cb889f0358a4::dragon_trainer::YieldFarm, arg3: &mut 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::PoolHive<T0>, arg4: &mut 0x26d99bb986dbcb78436ee2577636477a0068bfa9e48034253d08cb889f0358a4::dragon_trainer::DragonTrainer, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::unbond_from_dragon_den_1_fruits<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<T1>(v1, 0x2::tx_context::sender(arg6), arg6);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::hive::HIVE>(v0, 0x2::tx_context::sender(arg6), arg6);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<T0>(v2, 0x2::tx_context::sender(arg6), arg6);
    }

    public entry fun unbond_from_dragon_den_2_fruits<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::DragonFood, arg2: &mut 0x26d99bb986dbcb78436ee2577636477a0068bfa9e48034253d08cb889f0358a4::dragon_trainer::YieldFarm, arg3: &mut 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::PoolHive<T0>, arg4: &mut 0x26d99bb986dbcb78436ee2577636477a0068bfa9e48034253d08cb889f0358a4::dragon_trainer::DragonTrainer, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::unbond_from_dragon_den_2_fruits<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<T1>(v1, 0x2::tx_context::sender(arg6), arg6);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<T2>(v2, 0x2::tx_context::sender(arg6), arg6);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::hive::HIVE>(v0, 0x2::tx_context::sender(arg6), arg6);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<T0>(v3, 0x2::tx_context::sender(arg6), arg6);
    }

    public entry fun unbond_from_dragon_den_3_fruits<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::DragonFood, arg2: &mut 0x26d99bb986dbcb78436ee2577636477a0068bfa9e48034253d08cb889f0358a4::dragon_trainer::YieldFarm, arg3: &mut 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::PoolHive<T0>, arg4: &mut 0x26d99bb986dbcb78436ee2577636477a0068bfa9e48034253d08cb889f0358a4::dragon_trainer::DragonTrainer, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4) = 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::unbond_from_dragon_den_3_fruits<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<T1>(v1, 0x2::tx_context::sender(arg6), arg6);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<T2>(v2, 0x2::tx_context::sender(arg6), arg6);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<T3>(v3, 0x2::tx_context::sender(arg6), arg6);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::hive::HIVE>(v0, 0x2::tx_context::sender(arg6), arg6);
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<T0>(v4, 0x2::tx_context::sender(arg6), arg6);
    }

    public fun withdraw_dragon_bee<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::DragonFood, arg2: &mut 0x26d99bb986dbcb78436ee2577636477a0068bfa9e48034253d08cb889f0358a4::dragon_trainer::BeesManager, arg3: &mut 0x26d99bb986dbcb78436ee2577636477a0068bfa9e48034253d08cb889f0358a4::dragon_trainer::YieldFarm, arg4: &mut 0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::PoolHive<T0>, arg5: &mut 0x26d99bb986dbcb78436ee2577636477a0068bfa9e48034253d08cb889f0358a4::dragon_trainer::DragonTrainer, arg6: &mut 0x2::tx_context::TxContext) {
        0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::coin_helper::destroy_or_transfer_balance<0xaac0b9fd410a5c3035452af62cdf3440de0e214f0829c4a8624ecb0a3657d786::hive::HIVE>(0xd7f7f0dda781e068d5fda9b2d9a8fae9183d830183b9f9ee68c4c820ccbd8fb8::dragon_food::withdraw_dragon_bee<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6), 0x2::tx_context::sender(arg6), arg6);
    }

    // decompiled from Move bytecode v6
}

