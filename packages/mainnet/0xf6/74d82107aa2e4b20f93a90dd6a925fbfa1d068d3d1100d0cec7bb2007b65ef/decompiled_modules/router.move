module 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::router {
    public fun add_hive_to_locked_dragon_bee<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::PoolHive<T0>, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg5: u64, arg6: 0x2::coin::Coin<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::add_hive_to_locked_dragon_bee<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8), 0x2::tx_context::sender(arg8), arg8);
    }

    public fun add_honey_to_locked_dragon_bee<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::PoolHive<T0>, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg5: u64, arg6: &mut 0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::honey_trade::HoneyManager<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>, arg7: &mut 0x2::token::TokenPolicy<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>, arg8: &mut 0x2::token::Token<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::add_honey_to_locked_dragon_bee<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10), 0x2::tx_context::sender(arg10), arg10);
    }

    public fun claim_voting_rewards_three_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::YieldFlow, arg4: &mut 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::PoolHive<T0>, arg5: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::claim_voting_rewards_three_pool<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T1>(v1, 0x2::tx_context::sender(arg6), arg6);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T2>(v2, 0x2::tx_context::sender(arg6), arg6);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T3>(v3, 0x2::tx_context::sender(arg6), arg6);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(v0, 0x2::tx_context::sender(arg6), arg6);
    }

    public fun claim_voting_rewards_two_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::YieldFlow, arg4: &mut 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::PoolHive<T0>, arg5: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::claim_voting_rewards_two_pool<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T1>(v1, 0x2::tx_context::sender(arg6), arg6);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T2>(v2, 0x2::tx_context::sender(arg6), arg6);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(v0, 0x2::tx_context::sender(arg6), arg6);
    }

    public fun feed_bee_in_den<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::BeesManager, arg4: &mut 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::PoolHive<T0>, arg5: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::feed_bee_in_den<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7), 0x2::tx_context::sender(arg7), arg7);
    }

    public entry fun stake_lp_0_fruits<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::PoolHive<T0>, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg5);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T0>(v0, 0x2::tx_context::sender(arg7), arg7);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::stake_lp_0_fruits<T0>(arg0, arg1, arg2, arg3, arg4, 0x2::balance::split<T0>(&mut v0, arg6), arg7), 0x2::tx_context::sender(arg7), arg7);
    }

    public entry fun stake_lp_1_fruits<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::PoolHive<T0>, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg5);
        let (v1, v2) = 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::stake_lp_1_fruits<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x2::balance::split<T0>(&mut v0, arg6), arg7);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T0>(v0, 0x2::tx_context::sender(arg7), arg7);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T1>(v2, 0x2::tx_context::sender(arg7), arg7);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(v1, 0x2::tx_context::sender(arg7), arg7);
    }

    public entry fun stake_lp_2_fruits<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::PoolHive<T0>, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg5);
        let (v1, v2, v3) = 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::stake_lp_2_fruits<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, 0x2::balance::split<T0>(&mut v0, arg6), arg7);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T0>(v0, 0x2::tx_context::sender(arg7), arg7);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T1>(v2, 0x2::tx_context::sender(arg7), arg7);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T2>(v3, 0x2::tx_context::sender(arg7), arg7);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(v1, 0x2::tx_context::sender(arg7), arg7);
    }

    public entry fun stake_lp_3_fruits<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::PoolHive<T0>, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg5);
        let (v1, v2, v3, v4) = 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::stake_lp_3_fruits<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, 0x2::balance::split<T0>(&mut v0, arg6), arg7);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T0>(v0, 0x2::tx_context::sender(arg7), arg7);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T1>(v2, 0x2::tx_context::sender(arg7), arg7);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T2>(v3, 0x2::tx_context::sender(arg7), arg7);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T3>(v4, 0x2::tx_context::sender(arg7), arg7);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(v1, 0x2::tx_context::sender(arg7), arg7);
    }

    public entry fun unbond_from_dragon_den_0_fruits<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::PoolHive<T0>, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::unbond_from_dragon_den_0_fruits<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(v0, 0x2::tx_context::sender(arg6), arg6);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T0>(v1, 0x2::tx_context::sender(arg6), arg6);
    }

    public entry fun unbond_from_dragon_den_1_fruits<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::PoolHive<T0>, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::unbond_from_dragon_den_1_fruits<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T1>(v1, 0x2::tx_context::sender(arg6), arg6);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(v0, 0x2::tx_context::sender(arg6), arg6);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T0>(v2, 0x2::tx_context::sender(arg6), arg6);
    }

    public entry fun unbond_from_dragon_den_2_fruits<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::PoolHive<T0>, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::unbond_from_dragon_den_2_fruits<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T1>(v1, 0x2::tx_context::sender(arg6), arg6);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T2>(v2, 0x2::tx_context::sender(arg6), arg6);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(v0, 0x2::tx_context::sender(arg6), arg6);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T0>(v3, 0x2::tx_context::sender(arg6), arg6);
    }

    public entry fun unbond_from_dragon_den_3_fruits<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::PoolHive<T0>, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4) = 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::unbond_from_dragon_den_3_fruits<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T1>(v1, 0x2::tx_context::sender(arg6), arg6);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T2>(v2, 0x2::tx_context::sender(arg6), arg6);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T3>(v3, 0x2::tx_context::sender(arg6), arg6);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(v0, 0x2::tx_context::sender(arg6), arg6);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T0>(v4, 0x2::tx_context::sender(arg6), arg6);
    }

    public fun withdraw_dragon_bee<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::BeesManager, arg3: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg4: &mut 0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::PoolHive<T0>, arg5: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(0xf674d82107aa2e4b20f93a90dd6a925fbfa1d068d3d1100d0cec7bb2007b65ef::dragon_food::withdraw_dragon_bee<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7), 0x2::tx_context::sender(arg7), arg7);
    }

    // decompiled from Move bytecode v6
}

