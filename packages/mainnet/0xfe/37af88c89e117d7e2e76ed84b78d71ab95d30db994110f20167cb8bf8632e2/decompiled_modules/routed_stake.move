module 0xfe37af88c89e117d7e2e76ed84b78d71ab95d30db994110f20167cb8bf8632e2::routed_stake {
    struct RoutedStake<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        stake: 0x1::option::Option<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>,
    }

    struct RoutedStakeKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct RoutedStakeCreatedEvent<phantom T0, phantom T1> has copy, drop {
        routed_stake_id: address,
        parent_id: address,
        stake_id: address,
        staked_value: u64,
    }

    struct RoutedStakeRegisteredEvent<phantom T0, phantom T1, phantom T2> has copy, drop {
        routed_stake_id: address,
        parent_id: address,
        stake_id: address,
        stake_pool_id: address,
        staked_value: u64,
        registration_count_before: u64,
        registration_count_after: u64,
        pool_staked_shares_before: u64,
        pool_staked_shares_after: u64,
        pool_cumulative_reward_per_share: u256,
        registration_debt_after: u256,
    }

    struct RoutedStakeUnregisteredEvent<phantom T0, phantom T1, phantom T2> has copy, drop {
        routed_stake_id: address,
        parent_id: address,
        stake_id: address,
        stake_pool_id: address,
        staked_value: u64,
        registration_count_before: u64,
        registration_count_after: u64,
        pool_staked_shares_before: u64,
        pool_staked_shares_after: u64,
        pool_cumulative_reward_per_share: u256,
        registration_debt_before: u256,
    }

    struct RoutedStakeSweptEvent<phantom T0, phantom T1, phantom T2> has copy, drop {
        routed_stake_id: address,
        parent_id: address,
        stake_id: address,
        stake_pool_id: address,
        routed_pool_id: address,
        value: u64,
        parked: bool,
        staked_value: u64,
        source_balance_before: u64,
        source_balance_after: u64,
        source_staked_shares: u64,
        source_index: u256,
        source_carry: u128,
        source_cumulative_deposits: u128,
        registration_debt_before: u256,
        registration_debt_after: u256,
        destination_balance_before: u64,
        destination_balance_after: u64,
        destination_staked_shares: u64,
        destination_index_before: u256,
        destination_index_after: u256,
        destination_carry_before: u128,
        destination_carry_after: u128,
        destination_cumulative_deposits_before: u128,
        destination_cumulative_deposits_after: u128,
    }

    struct RoutedStakeUnstakedEvent<phantom T0, phantom T1> has copy, drop {
        routed_stake_id: address,
        parent_id: address,
        stake_id: address,
        unstaked_value: u64,
    }

    struct RoutedStakeRestakedEvent<phantom T0, phantom T1> has copy, drop {
        routed_stake_id: address,
        parent_id: address,
        stake_id: address,
        staked_value: u64,
    }

    public fun value<T0, T1>(arg0: &RoutedStake<T0, T1>) : u64 {
        if (0x1::option::is_some<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(&arg0.stake)) {
            0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::value<T0>(0x1::option::borrow<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(&arg0.stake))
        } else {
            0
        }
    }

    public fun assert_derived_from<T0, T1>(arg0: &RoutedStake<T0, T1>, arg1: 0x2::object::ID) {
        let v0 = RoutedStakeKey<T0>{dummy_field: false};
        assert!(0x2::object::uid_to_address(&arg0.id) == 0x2::derived_object::derive_address<RoutedStakeKey<T0>>(arg1, v0), 0);
    }

    public fun derived_address<T0>(arg0: 0x2::object::ID) : address {
        let v0 = RoutedStakeKey<T0>{dummy_field: false};
        0x2::derived_object::derive_address<RoutedStakeKey<T0>>(arg0, v0)
    }

    public fun stake<T0, T1>(arg0: &RoutedStake<T0, T1>) : &0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0> {
        assert!(0x1::option::is_some<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(&arg0.stake), 1);
        0x1::option::borrow<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(&arg0.stake)
    }

    public fun new<T0, T1>(arg0: &mut 0x2::object::UID, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : RoutedStake<T0, T1> {
        let v0 = 0x2::object::uid_to_inner(arg0);
        let v1 = RoutedStakeKey<T0>{dummy_field: false};
        let v2 = RoutedStake<T0, T1>{
            id    : 0x2::derived_object::claim<RoutedStakeKey<T0>>(arg0, v1),
            stake : 0x1::option::some<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::new<T0>(arg1, arg2)),
        };
        let v3 = 0x2::object::id<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(0x1::option::borrow<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(&v2.stake));
        let v4 = 0x2::object::id<RoutedStake<T0, T1>>(&v2);
        let v5 = RoutedStakeCreatedEvent<T0, T1>{
            routed_stake_id : 0x2::object::id_to_address(&v4),
            parent_id       : 0x2::object::id_to_address(&v0),
            stake_id        : 0x2::object::id_to_address(&v3),
            staked_value    : value<T0, T1>(&v2),
        };
        0x2::event::emit<RoutedStakeCreatedEvent<T0, T1>>(v5);
        v2
    }

    public fun has_stake<T0, T1>(arg0: &RoutedStake<T0, T1>) : bool {
        0x1::option::is_some<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(&arg0.stake)
    }

    public fun register<T0, T1, T2>(arg0: &mut RoutedStake<T0, T1>, arg1: &mut 0x2::object::UID, arg2: &mut 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T2>) {
        assert_derived_from<T0, T1>(arg0, 0x2::object::uid_to_inner(arg1));
        assert!(0x1::option::is_some<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(&arg0.stake), 1);
        let v0 = 0x2::object::id<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T2>>(arg2);
        assert!(0x2::object::id_to_address(&v0) != 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::derived_address<T1, T2>(0x2::object::uid_to_inner(arg1)), 3);
        let v1 = 0x1::type_name::with_defining_ids<T2>();
        let v2 = 0x2::object::id<RoutedStake<T0, T1>>(arg0);
        let v3 = 0x2::object::uid_to_inner(arg1);
        let v4 = 0x2::object::id<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(0x1::option::borrow<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(&arg0.stake));
        0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::register_stake<T0, T2>(arg2, 0x1::option::borrow_mut<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(&mut arg0.stake));
        let v5 = 0x2::object::id<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T2>>(arg2);
        let v6 = RoutedStakeRegisteredEvent<T0, T1, T2>{
            routed_stake_id                  : 0x2::object::id_to_address(&v2),
            parent_id                        : 0x2::object::id_to_address(&v3),
            stake_id                         : 0x2::object::id_to_address(&v4),
            stake_pool_id                    : 0x2::object::id_to_address(&v5),
            staked_value                     : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::value<T0>(0x1::option::borrow<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(&arg0.stake)),
            registration_count_before        : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::registration_count<T0>(0x1::option::borrow<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(&arg0.stake)),
            registration_count_after         : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::registration_count<T0>(0x1::option::borrow<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(&arg0.stake)),
            pool_staked_shares_before        : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::staked_shares<T0, T2>(arg2),
            pool_staked_shares_after         : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::staked_shares<T0, T2>(arg2),
            pool_cumulative_reward_per_share : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_reward_per_share<T0, T2>(arg2),
            registration_debt_after          : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::registration_debt(0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::get_registration<T0>(0x1::option::borrow<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(&arg0.stake), &v1)),
        };
        0x2::event::emit<RoutedStakeRegisteredEvent<T0, T1, T2>>(v6);
    }

    public fun restake<T0, T1>(arg0: &mut RoutedStake<T0, T1>, arg1: &mut 0x2::object::UID, arg2: 0x2::balance::Balance<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_derived_from<T0, T1>(arg0, 0x2::object::uid_to_inner(arg1));
        assert!(0x1::option::is_none<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(&arg0.stake), 2);
        0x1::option::fill<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(&mut arg0.stake, 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::new<T0>(arg2, arg3));
        let v0 = 0x2::object::id<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(0x1::option::borrow<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(&arg0.stake));
        let v1 = 0x2::object::id<RoutedStake<T0, T1>>(arg0);
        let v2 = 0x2::object::uid_to_inner(arg1);
        let v3 = RoutedStakeRestakedEvent<T0, T1>{
            routed_stake_id : 0x2::object::id_to_address(&v1),
            parent_id       : 0x2::object::id_to_address(&v2),
            stake_id        : 0x2::object::id_to_address(&v0),
            staked_value    : value<T0, T1>(arg0),
        };
        0x2::event::emit<RoutedStakeRestakedEvent<T0, T1>>(v3);
    }

    public fun share<T0, T1>(arg0: RoutedStake<T0, T1>) {
        0x2::transfer::share_object<RoutedStake<T0, T1>>(arg0);
    }

    public fun sweep<T0, T1, T2>(arg0: &mut RoutedStake<T0, T1>, arg1: &mut 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T2>, arg2: &mut 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T1, T2>, arg3: 0x2::object::ID) : u64 {
        assert_derived_from<T0, T1>(arg0, arg3);
        0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::assert_derived_from<T1, T2>(arg2, arg3);
        if (0x1::option::is_none<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(&arg0.stake)) {
            return 0
        };
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        let v1 = 0x1::option::borrow<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(&arg0.stake);
        if (!0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::has_registration<T0>(v1, &v0)) {
            return 0
        };
        let v2 = 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::get_registration<T0>(v1, &v0);
        if (0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::registration_pool_id(v2) != 0x2::object::id<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T2>>(arg1)) {
            return 0
        };
        let v3 = 0x2::object::id<RoutedStake<T0, T1>>(arg0);
        let v4 = 0x2::object::id<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(v1);
        let v5 = 0x2::object::id<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T2>>(arg1);
        let v6 = 0x2::object::id<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T1, T2>>(arg2);
        let v7 = 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::claim_rewards<T0, T2>(arg1, 0x1::option::borrow_mut<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(&mut arg0.stake));
        let v8 = 0x2::balance::value<T2>(&v7);
        if (v8 == 0) {
            0x2::balance::destroy_zero<T2>(v7);
            return 0
        };
        let v9 = 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::staked_shares<T1, T2>(arg2) == 0;
        if (v9) {
            let v10 = 0x2::object::id<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T1, T2>>(arg2);
            0x2::balance::send_funds<T2>(v7, 0x2::object::id_to_address(&v10));
        } else {
            0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::deposit<T1, T2>(arg2, v7);
        };
        let v11 = RoutedStakeSweptEvent<T0, T1, T2>{
            routed_stake_id                        : 0x2::object::id_to_address(&v3),
            parent_id                              : 0x2::object::id_to_address(&arg3),
            stake_id                               : 0x2::object::id_to_address(&v4),
            stake_pool_id                          : 0x2::object::id_to_address(&v5),
            routed_pool_id                         : 0x2::object::id_to_address(&v6),
            value                                  : v8,
            parked                                 : v9,
            staked_value                           : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::value<T0>(v1),
            source_balance_before                  : 0x2::balance::value<T2>(0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::balance<T0, T2>(arg1)),
            source_balance_after                   : 0x2::balance::value<T2>(0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::balance<T0, T2>(arg1)),
            source_staked_shares                   : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::staked_shares<T0, T2>(arg1),
            source_index                           : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_reward_per_share<T0, T2>(arg1),
            source_carry                           : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::carry<T0, T2>(arg1),
            source_cumulative_deposits             : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_deposits<T0, T2>(arg1),
            registration_debt_before               : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::registration_debt(v2),
            registration_debt_after                : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::registration_debt(0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::get_registration<T0>(0x1::option::borrow<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(&arg0.stake), &v0)),
            destination_balance_before             : 0x2::balance::value<T2>(0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::balance<T1, T2>(arg2)),
            destination_balance_after              : 0x2::balance::value<T2>(0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::balance<T1, T2>(arg2)),
            destination_staked_shares              : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::staked_shares<T1, T2>(arg2),
            destination_index_before               : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_reward_per_share<T1, T2>(arg2),
            destination_index_after                : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_reward_per_share<T1, T2>(arg2),
            destination_carry_before               : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::carry<T1, T2>(arg2),
            destination_carry_after                : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::carry<T1, T2>(arg2),
            destination_cumulative_deposits_before : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_deposits<T1, T2>(arg2),
            destination_cumulative_deposits_after  : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_deposits<T1, T2>(arg2),
        };
        0x2::event::emit<RoutedStakeSweptEvent<T0, T1, T2>>(v11);
        v8
    }

    public fun unregister<T0, T1, T2>(arg0: &mut RoutedStake<T0, T1>, arg1: &mut 0x2::object::UID, arg2: &mut 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T2>) {
        assert_derived_from<T0, T1>(arg0, 0x2::object::uid_to_inner(arg1));
        assert!(0x1::option::is_some<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(&arg0.stake), 1);
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        let v1 = 0x2::object::id<RoutedStake<T0, T1>>(arg0);
        let v2 = 0x2::object::uid_to_inner(arg1);
        let v3 = 0x2::object::id<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(0x1::option::borrow<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(&arg0.stake));
        let v4 = 0;
        if (0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::has_registration<T0>(0x1::option::borrow<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(&arg0.stake), &v0)) {
            v4 = 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::registration_debt(0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::get_registration<T0>(0x1::option::borrow<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(&arg0.stake), &v0));
        };
        0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::unregister_stake<T0, T2>(arg2, 0x1::option::borrow_mut<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(&mut arg0.stake));
        let v5 = 0x2::object::id<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::RoyaltyPool<T0, T2>>(arg2);
        let v6 = RoutedStakeUnregisteredEvent<T0, T1, T2>{
            routed_stake_id                  : 0x2::object::id_to_address(&v1),
            parent_id                        : 0x2::object::id_to_address(&v2),
            stake_id                         : 0x2::object::id_to_address(&v3),
            stake_pool_id                    : 0x2::object::id_to_address(&v5),
            staked_value                     : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::value<T0>(0x1::option::borrow<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(&arg0.stake)),
            registration_count_before        : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::registration_count<T0>(0x1::option::borrow<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(&arg0.stake)),
            registration_count_after         : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::registration_count<T0>(0x1::option::borrow<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(&arg0.stake)),
            pool_staked_shares_before        : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::staked_shares<T0, T2>(arg2),
            pool_staked_shares_after         : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::staked_shares<T0, T2>(arg2),
            pool_cumulative_reward_per_share : 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::pool::cumulative_reward_per_share<T0, T2>(arg2),
            registration_debt_before         : v4,
        };
        0x2::event::emit<RoutedStakeUnregisteredEvent<T0, T1, T2>>(v6);
    }

    public fun unstake<T0, T1>(arg0: &mut RoutedStake<T0, T1>, arg1: &mut 0x2::object::UID) : 0x2::balance::Balance<T0> {
        assert_derived_from<T0, T1>(arg0, 0x2::object::uid_to_inner(arg1));
        assert!(0x1::option::is_some<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(&arg0.stake), 1);
        let v0 = 0x2::object::id<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(0x1::option::borrow<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(&arg0.stake));
        let v1 = 0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::destroy<T0>(0x1::option::extract<0x17fa0d812bb8fe5251c736ebcf2be403f8537d66013bfef28b8a945a89d3f711::stake::Stake<T0>>(&mut arg0.stake));
        let v2 = 0x2::object::id<RoutedStake<T0, T1>>(arg0);
        let v3 = 0x2::object::uid_to_inner(arg1);
        let v4 = RoutedStakeUnstakedEvent<T0, T1>{
            routed_stake_id : 0x2::object::id_to_address(&v2),
            parent_id       : 0x2::object::id_to_address(&v3),
            stake_id        : 0x2::object::id_to_address(&v0),
            unstaked_value  : 0x2::balance::value<T0>(&v1),
        };
        0x2::event::emit<RoutedStakeUnstakedEvent<T0, T1>>(v4);
        v1
    }

    // decompiled from Move bytecode v7
}

