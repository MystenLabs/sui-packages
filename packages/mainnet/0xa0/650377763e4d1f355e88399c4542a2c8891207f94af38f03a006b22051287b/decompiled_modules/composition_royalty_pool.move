module 0xa0650377763e4d1f355e88399c4542a2c8891207f94af38f03a006b22051287b::composition_royalty_pool {
    struct CompositionRoyaltyPoolCreatedEvent<phantom T0, phantom T1> has copy, drop {
        composition_id: address,
        admin_cap_id: address,
        pool_id: address,
        pool_balance: u64,
        staked_shares: u64,
        cumulative_reward_per_share: u256,
        carry: u128,
        cumulative_deposits: u128,
    }

    struct CompositionCoinsDepositedEvent<phantom T0, phantom T1> has copy, drop {
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

    struct CompositionFundsDepositedEvent<phantom T0, phantom T1> has copy, drop {
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

    public fun new_pool<T0, T1>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T0>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T0>, arg2: &0x2::coin_registry::Currency<T0>) : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T1> {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T0>>(arg0);
        let v1 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T0>>(arg1);
        let v2 = 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::new<T0, T1>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::uid_mut<T0>(arg0, arg1), arg2);
        let v3 = 0x2::object::id<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T1>>(&v2);
        let v4 = CompositionRoyaltyPoolCreatedEvent<T0, T1>{
            composition_id              : 0x2::object::id_to_address(&v0),
            admin_cap_id                : 0x2::object::id_to_address(&v1),
            pool_id                     : 0x2::object::id_to_address(&v3),
            pool_balance                : 0x2::balance::value<T1>(0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::balance<T0, T1>(&v2)),
            staked_shares               : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::staked_shares<T0, T1>(&v2),
            cumulative_reward_per_share : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_reward_per_share<T0, T1>(&v2),
            carry                       : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::carry<T0, T1>(&v2),
            cumulative_deposits         : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_deposits<T0, T1>(&v2),
        };
        0x2::event::emit<CompositionRoyaltyPoolCreatedEvent<T0, T1>>(v4);
        v2
    }

    public fun pool_address<T0, T1>(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T0>) : address {
        0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::derived_address<T0, T1>(0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T0>>(arg0))
    }

    public fun receive_and_deposit<T0, T1>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T0>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T0>, arg2: &mut 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T1>, arg3: vector<0x2::transfer::Receiving<0x2::coin::Coin<T1>>>) {
        0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::assert_derived_from<T0, T1>(arg2, 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T0>>(arg0));
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T0>>(arg0);
        let v1 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T0>>(arg1);
        let v2 = 0x2::object::id<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T1>>(arg2);
        let v3 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::uid_mut<T0>(arg0, arg1);
        assert!(!0x1::vector::is_empty<0x2::transfer::Receiving<0x2::coin::Coin<T1>>>(&arg3), 0);
        let v4 = 0x2ccb0ff53146ac5830f92c0c9f8e5260160705e1f15c7f6606340a1c94c2ab98::hikida::receive_coins_as_balance<T1>(v3, arg3);
        0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::deposit<T0, T1>(arg2, v4);
        let v5 = CompositionCoinsDepositedEvent<T0, T1>{
            composition_id             : 0x2::object::id_to_address(&v0),
            admin_cap_id               : 0x2::object::id_to_address(&v1),
            pool_id                    : 0x2::object::id_to_address(&v2),
            amount                     : 0x2::balance::value<T1>(&v4),
            pool_balance_before        : 0x2::balance::value<T1>(0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::balance<T0, T1>(arg2)),
            pool_balance_after         : 0x2::balance::value<T1>(0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::balance<T0, T1>(arg2)),
            staked_shares              : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::staked_shares<T0, T1>(arg2),
            reward_per_share_before    : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_reward_per_share<T0, T1>(arg2),
            reward_per_share_after     : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_reward_per_share<T0, T1>(arg2),
            carry_before               : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::carry<T0, T1>(arg2),
            carry_after                : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::carry<T0, T1>(arg2),
            cumulative_deposits_before : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_deposits<T0, T1>(arg2),
            cumulative_deposits_after  : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_deposits<T0, T1>(arg2),
            coin_count                 : 0x1::vector::length<0x2::transfer::Receiving<0x2::coin::Coin<T1>>>(&arg3),
        };
        0x2::event::emit<CompositionCoinsDepositedEvent<T0, T1>>(v5);
    }

    public fun redeem_all_and_deposit<T0, T1>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T0>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T0>, arg2: &mut 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T1>, arg3: &0x2::accumulator::AccumulatorRoot) {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T0>>(arg0);
        redeem_settled_value_and_deposit<T0, T1>(arg0, arg1, arg2, 0x2::balance::settled_funds_value<T1>(arg3, 0x2::object::id_to_address(&v0)));
    }

    fun redeem_settled_value_and_deposit<T0, T1>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T0>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T0>, arg2: &mut 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T1>, arg3: u64) {
        0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::assert_derived_from<T0, T1>(arg2, 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T0>>(arg0));
        if (arg3 == 0 || 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::staked_shares<T0, T1>(arg2) == 0) {
            return
        };
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T0>>(arg0);
        let v1 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T0>>(arg1);
        let v2 = 0x2::object::id<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T1>>(arg2);
        let v3 = 0x2ccb0ff53146ac5830f92c0c9f8e5260160705e1f15c7f6606340a1c94c2ab98::hikida::redeem_balance<T1>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::uid_mut<T0>(arg0, arg1), arg3);
        0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::deposit<T0, T1>(arg2, v3);
        let v4 = CompositionFundsDepositedEvent<T0, T1>{
            composition_id             : 0x2::object::id_to_address(&v0),
            admin_cap_id               : 0x2::object::id_to_address(&v1),
            pool_id                    : 0x2::object::id_to_address(&v2),
            amount                     : 0x2::balance::value<T1>(&v3),
            pool_balance_before        : 0x2::balance::value<T1>(0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::balance<T0, T1>(arg2)),
            pool_balance_after         : 0x2::balance::value<T1>(0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::balance<T0, T1>(arg2)),
            staked_shares              : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::staked_shares<T0, T1>(arg2),
            reward_per_share_before    : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_reward_per_share<T0, T1>(arg2),
            reward_per_share_after     : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_reward_per_share<T0, T1>(arg2),
            carry_before               : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::carry<T0, T1>(arg2),
            carry_after                : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::carry<T0, T1>(arg2),
            cumulative_deposits_before : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_deposits<T0, T1>(arg2),
            cumulative_deposits_after  : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_deposits<T0, T1>(arg2),
        };
        0x2::event::emit<CompositionFundsDepositedEvent<T0, T1>>(v4);
    }

    // decompiled from Move bytecode v7
}

