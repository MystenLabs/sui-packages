module 0x3f7f2613a3e2375366431ba76f85eab35c1c5752036ee6abcbb09000b1158537::composition_routed_stake {
    struct CompositionRoutedStakeCreatedEvent<phantom T0, phantom T1> has copy, drop {
        composition_id: address,
        admin_cap_id: address,
        recording_id: address,
        routed_stake_id: address,
        stake_id: address,
        sender: address,
        principal_value: u64,
        registration_count: u64,
    }

    struct CompositionRoutedStakeRegisteredEvent<phantom T0, phantom T1, phantom T2> has copy, drop {
        composition_id: address,
        admin_cap_id: address,
        recording_id: address,
        routed_stake_id: address,
        stake_id: address,
        pool_id: address,
        principal_value: u64,
        registration_count_before: u64,
        registration_count_after: u64,
        pool_staked_shares_before: u64,
        pool_staked_shares_after: u64,
        pool_balance: u64,
        pool_cumulative_reward_per_share: u256,
        registration_debt: u256,
        pool_carry: u128,
        pool_cumulative_deposits: u128,
    }

    struct CompositionRoutedStakeUnregisteredEvent<phantom T0, phantom T1, phantom T2> has copy, drop {
        composition_id: address,
        admin_cap_id: address,
        recording_id: address,
        routed_stake_id: address,
        stake_id: address,
        pool_id: address,
        principal_value: u64,
        registration_count_before: u64,
        registration_count_after: u64,
        pool_staked_shares_before: u64,
        pool_staked_shares_after: u64,
        pool_balance: u64,
        pool_cumulative_reward_per_share: u256,
        registration_debt: u256,
        pool_carry: u128,
        pool_cumulative_deposits: u128,
        forfeited_scaled_reward: u256,
    }

    struct CompositionRoutedStakeUnstakedEvent<phantom T0, phantom T1> has copy, drop {
        composition_id: address,
        admin_cap_id: address,
        routed_stake_id: address,
        stake_id: address,
        principal_value: u64,
    }

    struct CompositionRoutedStakeRestakedEvent<phantom T0, phantom T1> has copy, drop {
        composition_id: address,
        admin_cap_id: address,
        routed_stake_id: address,
        stake_id: address,
        sender: address,
        principal_value: u64,
        registration_count: u64,
    }

    fun assert_pool_for_recording<T0, T1>(arg0: &0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T1>, arg1: 0x2::object::ID) {
        let v0 = 0x2::object::id<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T1>>(arg0);
        assert!(0x2::object::id_to_address(&v0) == 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::derived_address<T0, T1>(arg1), 0);
    }

    fun assert_recording_for_composition<T0, T1>(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>, arg1: 0x2::object::ID) {
        assert!(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::composition_id<T0, T1>(arg0) == arg1, 2);
    }

    fun assert_stake_for_composition<T0, T1>(arg0: &0xfe37af88c89e117d7e2e76ed84b78d71ab95d30db994110f20167cb8bf8632e2::routed_stake::RoutedStake<T0, T1>, arg1: 0x2::object::ID) {
        let v0 = 0x2::object::id<0xfe37af88c89e117d7e2e76ed84b78d71ab95d30db994110f20167cb8bf8632e2::routed_stake::RoutedStake<T0, T1>>(arg0);
        assert!(0x2::object::id_to_address(&v0) == 0xfe37af88c89e117d7e2e76ed84b78d71ab95d30db994110f20167cb8bf8632e2::routed_stake::derived_address<T0>(arg1), 1);
    }

    public fun create_stake<T0, T1>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T1>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T1>, arg2: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0xfe37af88c89e117d7e2e76ed84b78d71ab95d30db994110f20167cb8bf8632e2::routed_stake::RoutedStake<T0, T1> {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T1>>(arg0);
        assert_recording_for_composition<T0, T1>(arg2, v0);
        let v1 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T1>>(arg1);
        let v2 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>>(arg2);
        let v3 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::uid_mut<T1>(arg0, arg1);
        assert!(arg3 > 0, 3);
        let v4 = 0xfe37af88c89e117d7e2e76ed84b78d71ab95d30db994110f20167cb8bf8632e2::routed_stake::new<T0, T1>(v3, 0x2ccb0ff53146ac5830f92c0c9f8e5260160705e1f15c7f6606340a1c94c2ab98::hikida::redeem_balance<T0>(v3, arg3), arg4);
        let v5 = 0x2::object::id<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(0xfe37af88c89e117d7e2e76ed84b78d71ab95d30db994110f20167cb8bf8632e2::routed_stake::stake<T0, T1>(&v4));
        let v6 = 0x2::object::id<0xfe37af88c89e117d7e2e76ed84b78d71ab95d30db994110f20167cb8bf8632e2::routed_stake::RoutedStake<T0, T1>>(&v4);
        let v7 = CompositionRoutedStakeCreatedEvent<T0, T1>{
            composition_id     : 0x2::object::id_to_address(&v0),
            admin_cap_id       : 0x2::object::id_to_address(&v1),
            recording_id       : 0x2::object::id_to_address(&v2),
            routed_stake_id    : 0x2::object::id_to_address(&v6),
            stake_id           : 0x2::object::id_to_address(&v5),
            sender             : 0x2::tx_context::sender(arg4),
            principal_value    : 0xfe37af88c89e117d7e2e76ed84b78d71ab95d30db994110f20167cb8bf8632e2::routed_stake::value<T0, T1>(&v4),
            registration_count : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::registration_count<T0>(0xfe37af88c89e117d7e2e76ed84b78d71ab95d30db994110f20167cb8bf8632e2::routed_stake::stake<T0, T1>(&v4)),
        };
        0x2::event::emit<CompositionRoutedStakeCreatedEvent<T0, T1>>(v7);
        v4
    }

    public fun register<T0, T1, T2>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T1>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T1>, arg2: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>, arg3: &mut 0xfe37af88c89e117d7e2e76ed84b78d71ab95d30db994110f20167cb8bf8632e2::routed_stake::RoutedStake<T0, T1>, arg4: &mut 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T2>) {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T1>>(arg0);
        assert_recording_for_composition<T0, T1>(arg2, v0);
        assert_stake_for_composition<T0, T1>(arg3, v0);
        assert_pool_for_recording<T0, T2>(arg4, 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>>(arg2));
        let v1 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T1>>(arg1);
        let v2 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>>(arg2);
        let v3 = 0x2::object::id<0xfe37af88c89e117d7e2e76ed84b78d71ab95d30db994110f20167cb8bf8632e2::routed_stake::RoutedStake<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T2>>(arg4);
        let v5 = @0x0;
        let v6 = 0;
        let v7 = 0;
        if (0xfe37af88c89e117d7e2e76ed84b78d71ab95d30db994110f20167cb8bf8632e2::routed_stake::has_stake<T0, T1>(arg3)) {
            let v8 = 0xfe37af88c89e117d7e2e76ed84b78d71ab95d30db994110f20167cb8bf8632e2::routed_stake::stake<T0, T1>(arg3);
            let v9 = 0x2::object::id<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(v8);
            v5 = 0x2::object::id_to_address(&v9);
            v6 = 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::value<T0>(v8);
            v7 = 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::registration_count<T0>(v8);
        };
        0xfe37af88c89e117d7e2e76ed84b78d71ab95d30db994110f20167cb8bf8632e2::routed_stake::register<T0, T1, T2>(arg3, 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::uid_mut<T1>(arg0, arg1), arg4);
        let v10 = 0xfe37af88c89e117d7e2e76ed84b78d71ab95d30db994110f20167cb8bf8632e2::routed_stake::stake<T0, T1>(arg3);
        let v11 = 0x1::type_name::with_defining_ids<T2>();
        let v12 = CompositionRoutedStakeRegisteredEvent<T0, T1, T2>{
            composition_id                   : 0x2::object::id_to_address(&v0),
            admin_cap_id                     : 0x2::object::id_to_address(&v1),
            recording_id                     : 0x2::object::id_to_address(&v2),
            routed_stake_id                  : 0x2::object::id_to_address(&v3),
            stake_id                         : v5,
            pool_id                          : 0x2::object::id_to_address(&v4),
            principal_value                  : v6,
            registration_count_before        : v7,
            registration_count_after         : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::registration_count<T0>(v10),
            pool_staked_shares_before        : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::staked_shares<T0, T2>(arg4),
            pool_staked_shares_after         : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::staked_shares<T0, T2>(arg4),
            pool_balance                     : 0x2::balance::value<T2>(0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::balance<T0, T2>(arg4)),
            pool_cumulative_reward_per_share : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_reward_per_share<T0, T2>(arg4),
            registration_debt                : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::registration_debt(0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::get_registration<T0>(v10, &v11)),
            pool_carry                       : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::carry<T0, T2>(arg4),
            pool_cumulative_deposits         : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_deposits<T0, T2>(arg4),
        };
        0x2::event::emit<CompositionRoutedStakeRegisteredEvent<T0, T1, T2>>(v12);
    }

    public fun restake<T0, T1>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T1>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T1>, arg2: &mut 0xfe37af88c89e117d7e2e76ed84b78d71ab95d30db994110f20167cb8bf8632e2::routed_stake::RoutedStake<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T1>>(arg0);
        assert_stake_for_composition<T0, T1>(arg2, v0);
        let v1 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T1>>(arg1);
        let v2 = 0x2::object::id<0xfe37af88c89e117d7e2e76ed84b78d71ab95d30db994110f20167cb8bf8632e2::routed_stake::RoutedStake<T0, T1>>(arg2);
        0xfe37af88c89e117d7e2e76ed84b78d71ab95d30db994110f20167cb8bf8632e2::routed_stake::restake<T0, T1>(arg2, 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::uid_mut<T1>(arg0, arg1), arg3, arg4);
        let v3 = 0xfe37af88c89e117d7e2e76ed84b78d71ab95d30db994110f20167cb8bf8632e2::routed_stake::stake<T0, T1>(arg2);
        let v4 = 0x2::object::id<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(v3);
        let v5 = CompositionRoutedStakeRestakedEvent<T0, T1>{
            composition_id     : 0x2::object::id_to_address(&v0),
            admin_cap_id       : 0x2::object::id_to_address(&v1),
            routed_stake_id    : 0x2::object::id_to_address(&v2),
            stake_id           : 0x2::object::id_to_address(&v4),
            sender             : 0x2::tx_context::sender(arg4),
            principal_value    : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::value<T0>(v3),
            registration_count : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::registration_count<T0>(v3),
        };
        0x2::event::emit<CompositionRoutedStakeRestakedEvent<T0, T1>>(v5);
    }

    public fun stake_address<T0, T1>(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T1>) : address {
        0xfe37af88c89e117d7e2e76ed84b78d71ab95d30db994110f20167cb8bf8632e2::routed_stake::derived_address<T0>(0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T1>>(arg0))
    }

    public fun unregister<T0, T1, T2>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T1>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T1>, arg2: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>, arg3: &mut 0xfe37af88c89e117d7e2e76ed84b78d71ab95d30db994110f20167cb8bf8632e2::routed_stake::RoutedStake<T0, T1>, arg4: &mut 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T2>) {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T1>>(arg0);
        assert_recording_for_composition<T0, T1>(arg2, v0);
        assert_stake_for_composition<T0, T1>(arg3, v0);
        assert_pool_for_recording<T0, T2>(arg4, 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>>(arg2));
        let v1 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T1>>(arg1);
        let v2 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>>(arg2);
        let v3 = 0x2::object::id<0xfe37af88c89e117d7e2e76ed84b78d71ab95d30db994110f20167cb8bf8632e2::routed_stake::RoutedStake<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T2>>(arg4);
        let v5 = 0x1::type_name::with_defining_ids<T2>();
        let v6 = @0x0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        if (0xfe37af88c89e117d7e2e76ed84b78d71ab95d30db994110f20167cb8bf8632e2::routed_stake::has_stake<T0, T1>(arg3)) {
            let v10 = 0xfe37af88c89e117d7e2e76ed84b78d71ab95d30db994110f20167cb8bf8632e2::routed_stake::stake<T0, T1>(arg3);
            let v11 = 0x2::object::id<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(v10);
            v6 = 0x2::object::id_to_address(&v11);
            v7 = 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::value<T0>(v10);
            v8 = 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::registration_count<T0>(v10);
            if (0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::has_registration<T0>(v10, &v5)) {
                v9 = 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::registration_debt(0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::get_registration<T0>(v10, &v5));
            };
        };
        0xfe37af88c89e117d7e2e76ed84b78d71ab95d30db994110f20167cb8bf8632e2::routed_stake::unregister<T0, T1, T2>(arg3, 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::uid_mut<T1>(arg0, arg1), arg4);
        let v12 = CompositionRoutedStakeUnregisteredEvent<T0, T1, T2>{
            composition_id                   : 0x2::object::id_to_address(&v0),
            admin_cap_id                     : 0x2::object::id_to_address(&v1),
            recording_id                     : 0x2::object::id_to_address(&v2),
            routed_stake_id                  : 0x2::object::id_to_address(&v3),
            stake_id                         : v6,
            pool_id                          : 0x2::object::id_to_address(&v4),
            principal_value                  : v7,
            registration_count_before        : v8,
            registration_count_after         : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::registration_count<T0>(0xfe37af88c89e117d7e2e76ed84b78d71ab95d30db994110f20167cb8bf8632e2::routed_stake::stake<T0, T1>(arg3)),
            pool_staked_shares_before        : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::staked_shares<T0, T2>(arg4),
            pool_staked_shares_after         : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::staked_shares<T0, T2>(arg4),
            pool_balance                     : 0x2::balance::value<T2>(0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::balance<T0, T2>(arg4)),
            pool_cumulative_reward_per_share : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_reward_per_share<T0, T2>(arg4),
            registration_debt                : v9,
            pool_carry                       : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::carry<T0, T2>(arg4),
            pool_cumulative_deposits         : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_deposits<T0, T2>(arg4),
            forfeited_scaled_reward          : (v7 as u256) * 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_reward_per_share<T0, T2>(arg4) - v9,
        };
        0x2::event::emit<CompositionRoutedStakeUnregisteredEvent<T0, T1, T2>>(v12);
    }

    public fun unstake<T0, T1>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T1>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T1>, arg2: &mut 0xfe37af88c89e117d7e2e76ed84b78d71ab95d30db994110f20167cb8bf8632e2::routed_stake::RoutedStake<T0, T1>) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T1>>(arg0);
        assert_stake_for_composition<T0, T1>(arg2, v0);
        let v1 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T1>>(arg1);
        let v2 = 0x2::object::id<0xfe37af88c89e117d7e2e76ed84b78d71ab95d30db994110f20167cb8bf8632e2::routed_stake::RoutedStake<T0, T1>>(arg2);
        let v3 = @0x0;
        if (0xfe37af88c89e117d7e2e76ed84b78d71ab95d30db994110f20167cb8bf8632e2::routed_stake::has_stake<T0, T1>(arg2)) {
            let v4 = 0x2::object::id<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(0xfe37af88c89e117d7e2e76ed84b78d71ab95d30db994110f20167cb8bf8632e2::routed_stake::stake<T0, T1>(arg2));
            v3 = 0x2::object::id_to_address(&v4);
        };
        let v5 = 0xfe37af88c89e117d7e2e76ed84b78d71ab95d30db994110f20167cb8bf8632e2::routed_stake::unstake<T0, T1>(arg2, 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::uid_mut<T1>(arg0, arg1));
        let v6 = CompositionRoutedStakeUnstakedEvent<T0, T1>{
            composition_id  : 0x2::object::id_to_address(&v0),
            admin_cap_id    : 0x2::object::id_to_address(&v1),
            routed_stake_id : 0x2::object::id_to_address(&v2),
            stake_id        : v3,
            principal_value : 0x2::balance::value<T0>(&v5),
        };
        0x2::event::emit<CompositionRoutedStakeUnstakedEvent<T0, T1>>(v6);
        v5
    }

    // decompiled from Move bytecode v7
}

