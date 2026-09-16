module 0x2154a6cc26787e3c044a948000a899c0b06baa9cf20fdd366841078271e036b1::recording_royalty_pool {
    struct RecordingRoyaltyPoolCreatedEvent<phantom T0, phantom T1, phantom T2> has copy, drop {
        recording_id: address,
        composition_id: address,
        admin_cap_id: address,
        pool_id: address,
        pool_balance: u64,
        staked_shares: u64,
        cumulative_reward_per_share: u256,
        carry: u128,
        cumulative_deposits: u128,
    }

    struct RecordingCoinsDepositedEvent<phantom T0, phantom T1, phantom T2> has copy, drop {
        recording_id: address,
        composition_id: address,
        admin_cap_id: address,
        pool_id: address,
        amount: u64,
        pool_balance_before: u64,
        pool_balance_after: u64,
        staked_shares: u64,
        reward_per_share_before: u256,
        reward_per_share_after: u256,
        carry_before: u128,
        carry_after: u128,
        cumulative_deposits_before: u128,
        cumulative_deposits_after: u128,
        coin_count: u64,
    }

    struct RecordingFundsDepositedEvent<phantom T0, phantom T1, phantom T2> has copy, drop {
        recording_id: address,
        composition_id: address,
        admin_cap_id: address,
        pool_id: address,
        amount: u64,
        pool_balance_before: u64,
        pool_balance_after: u64,
        staked_shares: u64,
        reward_per_share_before: u256,
        reward_per_share_after: u256,
        carry_before: u128,
        carry_after: u128,
        cumulative_deposits_before: u128,
        cumulative_deposits_after: u128,
    }

    public fun new_pool<T0, T1, T2>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>, arg2: &0x2::coin_registry::Currency<T0>) : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T2> {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>>(arg0);
        let v1 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::composition_id<T0, T1>(arg0);
        let v2 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>>(arg1);
        let v3 = 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::new<T0, T2>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid_mut<T0, T1>(arg0, arg1), arg2);
        let v4 = 0x2::object::id<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T2>>(&v3);
        let v5 = RecordingRoyaltyPoolCreatedEvent<T0, T1, T2>{
            recording_id                : 0x2::object::id_to_address(&v0),
            composition_id              : 0x2::object::id_to_address(&v1),
            admin_cap_id                : 0x2::object::id_to_address(&v2),
            pool_id                     : 0x2::object::id_to_address(&v4),
            pool_balance                : 0x2::balance::value<T2>(0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::balance<T0, T2>(&v3)),
            staked_shares               : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::staked_shares<T0, T2>(&v3),
            cumulative_reward_per_share : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_reward_per_share<T0, T2>(&v3),
            carry                       : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::carry<T0, T2>(&v3),
            cumulative_deposits         : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_deposits<T0, T2>(&v3),
        };
        0x2::event::emit<RecordingRoyaltyPoolCreatedEvent<T0, T1, T2>>(v5);
        v3
    }

    public fun pool_address<T0, T1, T2>(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>) : address {
        0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::derived_address<T0, T2>(0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>>(arg0))
    }

    public fun receive_and_deposit<T0, T1, T2>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>, arg2: &mut 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T2>, arg3: vector<0x2::transfer::Receiving<0x2::coin::Coin<T2>>>) {
        0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::assert_derived_from<T0, T2>(arg2, 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>>(arg0));
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>>(arg0);
        let v1 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::composition_id<T0, T1>(arg0);
        let v2 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>>(arg1);
        let v3 = 0x2::object::id<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T2>>(arg2);
        let v4 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid_mut<T0, T1>(arg0, arg1);
        assert!(!0x1::vector::is_empty<0x2::transfer::Receiving<0x2::coin::Coin<T2>>>(&arg3), 0);
        let v5 = 0x2ccb0ff53146ac5830f92c0c9f8e5260160705e1f15c7f6606340a1c94c2ab98::hikida::receive_coins_as_balance<T2>(v4, arg3);
        0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::deposit<T0, T2>(arg2, v5);
        let v6 = RecordingCoinsDepositedEvent<T0, T1, T2>{
            recording_id               : 0x2::object::id_to_address(&v0),
            composition_id             : 0x2::object::id_to_address(&v1),
            admin_cap_id               : 0x2::object::id_to_address(&v2),
            pool_id                    : 0x2::object::id_to_address(&v3),
            amount                     : 0x2::balance::value<T2>(&v5),
            pool_balance_before        : 0x2::balance::value<T2>(0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::balance<T0, T2>(arg2)),
            pool_balance_after         : 0x2::balance::value<T2>(0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::balance<T0, T2>(arg2)),
            staked_shares              : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::staked_shares<T0, T2>(arg2),
            reward_per_share_before    : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_reward_per_share<T0, T2>(arg2),
            reward_per_share_after     : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_reward_per_share<T0, T2>(arg2),
            carry_before               : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::carry<T0, T2>(arg2),
            carry_after                : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::carry<T0, T2>(arg2),
            cumulative_deposits_before : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_deposits<T0, T2>(arg2),
            cumulative_deposits_after  : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_deposits<T0, T2>(arg2),
            coin_count                 : 0x1::vector::length<0x2::transfer::Receiving<0x2::coin::Coin<T2>>>(&arg3),
        };
        0x2::event::emit<RecordingCoinsDepositedEvent<T0, T1, T2>>(v6);
    }

    public fun redeem_all_and_deposit<T0, T1, T2>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>, arg2: &mut 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T2>, arg3: &0x2::accumulator::AccumulatorRoot) {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>>(arg0);
        redeem_settled_value_and_deposit<T0, T1, T2>(arg0, arg1, arg2, 0x2::balance::settled_funds_value<T2>(arg3, 0x2::object::id_to_address(&v0)));
    }

    fun redeem_settled_value_and_deposit<T0, T1, T2>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>, arg2: &mut 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T2>, arg3: u64) {
        0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::assert_derived_from<T0, T2>(arg2, 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>>(arg0));
        if (arg3 == 0 || 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::staked_shares<T0, T2>(arg2) == 0) {
            return
        };
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>>(arg0);
        let v1 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::composition_id<T0, T1>(arg0);
        let v2 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>>(arg1);
        let v3 = 0x2::object::id<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T2>>(arg2);
        let v4 = 0x2ccb0ff53146ac5830f92c0c9f8e5260160705e1f15c7f6606340a1c94c2ab98::hikida::redeem_balance<T2>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid_mut<T0, T1>(arg0, arg1), arg3);
        0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::deposit<T0, T2>(arg2, v4);
        let v5 = RecordingFundsDepositedEvent<T0, T1, T2>{
            recording_id               : 0x2::object::id_to_address(&v0),
            composition_id             : 0x2::object::id_to_address(&v1),
            admin_cap_id               : 0x2::object::id_to_address(&v2),
            pool_id                    : 0x2::object::id_to_address(&v3),
            amount                     : 0x2::balance::value<T2>(&v4),
            pool_balance_before        : 0x2::balance::value<T2>(0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::balance<T0, T2>(arg2)),
            pool_balance_after         : 0x2::balance::value<T2>(0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::balance<T0, T2>(arg2)),
            staked_shares              : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::staked_shares<T0, T2>(arg2),
            reward_per_share_before    : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_reward_per_share<T0, T2>(arg2),
            reward_per_share_after     : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_reward_per_share<T0, T2>(arg2),
            carry_before               : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::carry<T0, T2>(arg2),
            carry_after                : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::carry<T0, T2>(arg2),
            cumulative_deposits_before : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_deposits<T0, T2>(arg2),
            cumulative_deposits_after  : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_deposits<T0, T2>(arg2),
        };
        0x2::event::emit<RecordingFundsDepositedEvent<T0, T1, T2>>(v5);
    }

    // decompiled from Move bytecode v7
}

