module 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::gauge {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct StakedPosition has store, key {
        id: 0x2::object::UID,
        position_id: 0x2::object::ID,
    }

    struct EventNotifyEpochToken has copy, drop, store {
        sender: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
    }

    struct EventNotifyReward has copy, drop, store {
        sender: 0x2::object::ID,
        usd_amount: u64,
    }

    struct EventClaimFees has copy, drop, store {
        amount_a: u64,
        amount_b: u64,
    }

    struct RewardProfile has store {
        growth_inside: u128,
        amount: u64,
        last_update_time: u64,
    }

    struct EventClaimReward has copy, drop, store {
        from: address,
        position_id: 0x2::object::ID,
        amount: u64,
        token: 0x1::type_name::TypeName,
    }

    struct EventWithdrawPosition has copy, drop, store {
        position_id: 0x2::object::ID,
        gauger_id: 0x2::object::ID,
    }

    struct EventDepositGauge has copy, drop, store {
        gauger_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        staked_position_id: 0x2::object::ID,
    }

    struct EventGaugeCreated has copy, drop, store {
        id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
    }

    struct EventGaugeSetVoter has copy, drop, store {
        id: 0x2::object::ID,
        voter_id: 0x2::object::ID,
    }

    struct Locked has copy, drop, store {
        dummy_field: bool,
    }

    struct Gauge<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        gauge_cap: 0x1::option::Option<0x759fdf7bc2175c3dd078e16d4703ea5ef655cd055ff74eca9c516e6173c6b42e::gauge_cap::GaugeCap>,
        distribution_config: 0x2::object::ID,
        staked_positions: 0x2::object_table::ObjectTable<0x2::object::ID, 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::Position>,
        locked_positions: 0x2::table::Table<0x2::object::ID, Locked>,
        current_epoch_token: 0x1::option::Option<0x1::type_name::TypeName>,
        epoch_token_last_notified: u64,
        fee_a: 0x2::balance::Balance<T0>,
        fee_b: 0x2::balance::Balance<T1>,
        voter: 0x1::option::Option<0x2::object::ID>,
        usd_reward_rate: u128,
        o_sail_reward_rate: u128,
        period_finish: u64,
        usd_reward_rate_by_epoch: 0x2::table::Table<u64, u128>,
        o_sail_emission_by_epoch: 0x2::table::Table<u64, u64>,
        last_distribution_reserve: u64,
        growth_global_by_token: 0x2::linked_table::LinkedTable<0x1::type_name::TypeName, u128>,
        rewards: 0x2::table::Table<0x2::object::ID, RewardProfile>,
    }

    public fun all_rewards_claimed<T0, T1>(arg0: &Gauge<T0, T1>, arg1: &mut 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : bool {
        assert!(check_gauger_pool<T0, T1>(arg0, arg1), 577203795438525600);
        let v0 = *0x1::option::borrow<0x1::type_name::TypeName>(&arg0.current_epoch_token);
        let v1 = prev_reward_claimed<T0, T1>(arg0, arg1, v0, arg2);
        if (!v1) {
            return false
        };
        let (v2, _) = earned_internal<T0, T1>(arg0, arg1, arg2, v0, 0x2::clock::timestamp_ms(arg3) / 1000);
        v2 == 0
    }

    public fun borrow_epoch_token<T0, T1>(arg0: &Gauge<T0, T1>) : &0x1::type_name::TypeName {
        0x1::option::borrow<0x1::type_name::TypeName>(&arg0.current_epoch_token)
    }

    public fun check_gauger_pool<T0, T1>(arg0: &Gauge<T0, T1>, arg1: &0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>) : bool {
        arg0.pool_id == 0x2::object::id<0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>>(arg1)
    }

    public fun claim_fees<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribute_cap::DistributeCap, arg2: &mut 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        claim_fees_internal<T0, T1>(arg0, arg2)
    }

    fun claim_fees_internal<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &mut 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::epoch();
        let (v1, v2) = 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::collect_fullsail_distribution_gauger_fees<T0, T1>(arg1, 0x1::option::borrow<0x759fdf7bc2175c3dd078e16d4703ea5ef655cd055ff74eca9c516e6173c6b42e::gauge_cap::GaugeCap>(&arg0.gauge_cap));
        let v3 = v2;
        let v4 = v1;
        if (0x2::balance::value<T0>(&v4) > 0 || 0x2::balance::value<T1>(&v3) > 0) {
            let v5 = 0x2::balance::join<T0>(&mut arg0.fee_a, v4);
            let v6 = 0x2::balance::join<T1>(&mut arg0.fee_b, v3);
            let v7 = if (v5 > v0) {
                0x2::balance::withdraw_all<T0>(&mut arg0.fee_a)
            } else {
                0x2::balance::zero<T0>()
            };
            let v8 = if (v6 > v0) {
                0x2::balance::withdraw_all<T1>(&mut arg0.fee_b)
            } else {
                0x2::balance::zero<T1>()
            };
            let v9 = EventClaimFees{
                amount_a : v5,
                amount_b : v6,
            };
            0x2::event::emit<EventClaimFees>(v9);
            return (v7, v8)
        };
        0x2::balance::destroy_zero<T0>(v4);
        0x2::balance::destroy_zero<T1>(v3);
        (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
    }

    public(friend) fun create<T0, T1>(arg0: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : Gauge<T0, T1> {
        let v0 = 0x2::object::new(arg2);
        let v1 = EventGaugeCreated{
            id      : 0x2::object::uid_to_inner(&v0),
            pool_id : arg1,
        };
        0x2::event::emit<EventGaugeCreated>(v1);
        Gauge<T0, T1>{
            id                        : v0,
            pool_id                   : arg1,
            gauge_cap                 : 0x1::option::none<0x759fdf7bc2175c3dd078e16d4703ea5ef655cd055ff74eca9c516e6173c6b42e::gauge_cap::GaugeCap>(),
            distribution_config       : 0x2::object::id<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig>(arg0),
            staked_positions          : 0x2::object_table::new<0x2::object::ID, 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::Position>(arg2),
            locked_positions          : 0x2::table::new<0x2::object::ID, Locked>(arg2),
            current_epoch_token       : 0x1::option::none<0x1::type_name::TypeName>(),
            epoch_token_last_notified : 0,
            fee_a                     : 0x2::balance::zero<T0>(),
            fee_b                     : 0x2::balance::zero<T1>(),
            voter                     : 0x1::option::none<0x2::object::ID>(),
            usd_reward_rate           : 0,
            o_sail_reward_rate        : 0,
            period_finish             : 0,
            usd_reward_rate_by_epoch  : 0x2::table::new<u64, u128>(arg2),
            o_sail_emission_by_epoch  : 0x2::table::new<u64, u64>(arg2),
            last_distribution_reserve : 0,
            growth_global_by_token    : 0x2::linked_table::new<0x1::type_name::TypeName, u128>(arg2),
            rewards                   : 0x2::table::new<0x2::object::ID, RewardProfile>(arg2),
        }
    }

    public fun deposit_position<T0, T1>(arg0: &0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::config::GlobalConfig, arg1: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig, arg2: &mut Gauge<T0, T1>, arg3: &mut 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>, arg4: 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::Position, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : StakedPosition {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::object::id<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig>(arg1) == arg2.distribution_config, 9223373183611043839);
        assert!(0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::is_gauge_alive(arg1, 0x2::object::id<Gauge<T0, T1>>(arg2)), 9223373157842747416);
        assert!(check_gauger_pool<T0, T1>(arg2, arg3), 9223373162136666120);
        assert!(0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::pool_id(&arg4) == 0x2::object::id<0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>>(arg3), 9223373166431764490);
        assert!(0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::liquidity(&arg4) > 0, 9223373172345436343);
        assert!(!0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::is_staked(0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::borrow_position_info(0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::position_manager<T0, T1>(arg3), 0x2::object::id<0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::Position>(&arg4))), 9223373175021174786);
        let (v1, v2) = 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::collect_fee<T0, T1>(arg0, arg3, &arg4, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg6), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg6), v0);
        deposit_position_internal<T0, T1>(arg2, arg3, arg4, arg5, arg6)
    }

    public fun deposit_position_by_locker<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig, arg2: &0xc3f7c8b6d8496b50ebb5c2c2ff476f30c3c49d95307312b60e38c82176edfcbc::locker_cap::LockerCap, arg3: &mut 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>, arg4: 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::Position, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : StakedPosition {
        assert!(0x2::object::id<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig>(arg1) == arg0.distribution_config, 9223373183611043839);
        assert!(0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::is_gauge_alive(arg1, 0x2::object::id<Gauge<T0, T1>>(arg0)), 9223373157842747416);
        assert!(0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::liquidity(&arg4) > 0, 9223373172345436343);
        assert!(check_gauger_pool<T0, T1>(arg0, arg3), 9223373162136666120);
        assert!(0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::pool_id(&arg4) == 0x2::object::id<0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>>(arg3), 9223373166431764490);
        assert!(!0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::is_staked(0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::borrow_position_info(0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::position_manager<T0, T1>(arg3), 0x2::object::id<0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::Position>(&arg4))), 9223373175021174786);
        deposit_position_internal<T0, T1>(arg0, arg3, arg4, arg5, arg6)
    }

    fun deposit_position_internal<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &mut 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>, arg2: 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::Position, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : StakedPosition {
        let v0 = 0x2::object::id<0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::Position>(&arg2);
        let (v1, v2) = 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::tick_range(&arg2);
        let v3 = 0x1::option::borrow<0x759fdf7bc2175c3dd078e16d4703ea5ef655cd055ff74eca9c516e6173c6b42e::gauge_cap::GaugeCap>(&arg0.gauge_cap);
        0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::update_fullsail_distribution_growth_global<T0, T1>(arg1, v3, arg3);
        if (!0x2::table::contains<0x2::object::ID, RewardProfile>(&arg0.rewards, v0)) {
            let v4 = RewardProfile{
                growth_inside    : 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::get_fullsail_distribution_growth_inside<T0, T1>(arg1, v1, v2, 0),
                amount           : 0,
                last_update_time : 0x2::clock::timestamp_ms(arg3) / 1000,
            };
            0x2::table::add<0x2::object::ID, RewardProfile>(&mut arg0.rewards, v0, v4);
        } else {
            let v5 = 0x2::table::borrow_mut<0x2::object::ID, RewardProfile>(&mut arg0.rewards, v0);
            v5.growth_inside = 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::get_fullsail_distribution_growth_inside<T0, T1>(arg1, v1, v2, 0);
            v5.last_update_time = 0x2::clock::timestamp_ms(arg3) / 1000;
        };
        0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::stake_in_fullsail_distribution<T0, T1>(arg1, v3, &arg2, arg3);
        0x2::object_table::add<0x2::object::ID, 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::Position>(&mut arg0.staked_positions, v0, arg2);
        let v6 = StakedPosition{
            id          : 0x2::object::new(arg4),
            position_id : v0,
        };
        let v7 = EventDepositGauge{
            gauger_id          : 0x2::object::id<Gauge<T0, T1>>(arg0),
            pool_id            : 0x2::object::id<0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>>(arg1),
            position_id        : v0,
            staked_position_id : 0x2::object::id<StakedPosition>(&v6),
        };
        0x2::event::emit<EventDepositGauge>(v7);
        v6
    }

    fun destroy_staked_positions(arg0: StakedPosition) {
        let StakedPosition {
            id          : v0,
            position_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun earned_by_position<T0, T1, T2>(arg0: &Gauge<T0, T1>, arg1: &0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : (u64, u128) {
        assert!(check_gauger_pool<T0, T1>(arg0, arg1), 9223372693985230856);
        assert!(0x2::object_table::contains<0x2::object::ID, 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::Position>(&arg0.staked_positions, arg2), 9223372698279936004);
        let v0 = 0x1::type_name::get<T2>();
        if (!0x2::linked_table::contains<0x1::type_name::TypeName, u128>(&arg0.growth_global_by_token, v0)) {
            return (0, 0)
        };
        earned_internal<T0, T1>(arg0, arg1, arg2, v0, 0x2::clock::timestamp_ms(arg3) / 1000)
    }

    public fun earned_by_position_ids<T0, T1, T2>(arg0: &Gauge<T0, T1>, arg1: &0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>, arg2: &vector<0x2::object::ID>, arg3: &0x2::clock::Clock) : u64 {
        assert!(check_gauger_pool<T0, T1>(arg0, arg1), 9223372724050001928);
        let v0 = 0x1::type_name::get<T2>();
        if (!0x2::linked_table::contains<0x1::type_name::TypeName, u128>(&arg0.growth_global_by_token, v0)) {
            return 0
        };
        let v1 = 0;
        let v2 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(arg2)) {
            let (v3, _) = earned_internal<T0, T1>(arg0, arg1, *0x1::vector::borrow<0x2::object::ID>(arg2, v1), v0, 0x2::clock::timestamp_ms(arg3) / 1000);
            v2 = v2 + v3;
            v1 = v1 + 1;
        };
        v2
    }

    public fun earned_by_staked_position<T0, T1, T2>(arg0: &Gauge<T0, T1>, arg1: &0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>, arg2: &vector<StakedPosition>, arg3: &0x2::clock::Clock) : u64 {
        assert!(check_gauger_pool<T0, T1>(arg0, arg1), 9223372724050001928);
        let v0 = 0x1::type_name::get<T2>();
        if (!0x2::linked_table::contains<0x1::type_name::TypeName, u128>(&arg0.growth_global_by_token, v0)) {
            return 0
        };
        let v1 = 0;
        let v2 = 0;
        while (v1 < 0x1::vector::length<StakedPosition>(arg2)) {
            let (v3, _) = earned_internal<T0, T1>(arg0, arg1, 0x1::vector::borrow<StakedPosition>(arg2, v1).position_id, v0, 0x2::clock::timestamp_ms(arg3) / 1000);
            v2 = v2 + v3;
            v1 = v1 + 1;
        };
        v2
    }

    fun earned_internal<T0, T1>(arg0: &Gauge<T0, T1>, arg1: &0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: 0x1::type_name::TypeName, arg4: u64) : (u64, u128) {
        let v0 = if (&arg3 == borrow_epoch_token<T0, T1>(arg0)) {
            get_current_growth_global<T0, T1>(arg0, arg1, arg4)
        } else {
            *0x2::linked_table::borrow<0x1::type_name::TypeName, u128>(&arg0.growth_global_by_token, arg3)
        };
        let v1 = 0x2::linked_table::prev<0x1::type_name::TypeName, u128>(&arg0.growth_global_by_token, arg3);
        let v2 = if (0x1::option::is_some<0x1::type_name::TypeName>(v1)) {
            *0x2::linked_table::borrow<0x1::type_name::TypeName, u128>(&arg0.growth_global_by_token, *0x1::option::borrow<0x1::type_name::TypeName>(v1))
        } else {
            0
        };
        let v3 = 0x2::object_table::borrow<0x2::object::ID, 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::Position>(&arg0.staked_positions, arg2);
        let (v4, v5) = 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::tick_range(v3);
        let v6 = 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::get_fullsail_distribution_growth_inside<T0, T1>(arg1, v4, v5, v0);
        let v7 = if (v2 > 0) {
            0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::get_fullsail_distribution_growth_inside<T0, T1>(arg1, v4, v5, v2)
        } else {
            0
        };
        let v8 = 0x2::table::borrow<0x2::object::ID, RewardProfile>(&arg0.rewards, arg2).growth_inside;
        let v9 = if (0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::math_u128::greater_or_equal_overflowing(v8, v7)) {
            v8
        } else {
            v7
        };
        let v10 = v9;
        if (0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::math_u128::is_neg(v9)) {
            v10 = 0;
        };
        let v11 = 0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::math_u128::wrapping_sub(v6, v10);
        if (0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::math_u128::is_neg(v11)) {
            return (0, v6)
        };
        ((0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::full_math_u128::mul_div_floor(v11, 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::liquidity(v3), 18446744073709551616) as u64), v6)
    }

    public fun full_earned_for_type<T0, T1, T2>(arg0: &Gauge<T0, T1>, arg1: &0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: u128) : (u64, u128) {
        assert!(check_gauger_pool<T0, T1>(arg0, arg1), 266845958013316900);
        let v0 = 0x1::type_name::get<T2>();
        assert!(&v0 != borrow_epoch_token<T0, T1>(arg0), 932952345345345345);
        assert!(0x2::linked_table::contains<0x1::type_name::TypeName, u128>(&arg0.growth_global_by_token, v0), 923483942940234034);
        assert!(0x2::object_table::contains<0x2::object::ID, 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::Position>(&arg0.staked_positions, arg2), 9223372698279936004);
        let v1 = 0x2::object_table::borrow<0x2::object::ID, 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::Position>(&arg0.staked_positions, arg2);
        let (v2, v3) = 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::tick_range(v1);
        let v4 = 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::get_fullsail_distribution_growth_inside<T0, T1>(arg1, v2, v3, *0x2::linked_table::borrow<0x1::type_name::TypeName, u128>(&arg0.growth_global_by_token, v0));
        let v5 = 0x2::linked_table::prev<0x1::type_name::TypeName, u128>(&arg0.growth_global_by_token, v0);
        let v6 = if (0x1::option::is_some<0x1::type_name::TypeName>(v5)) {
            *0x2::linked_table::borrow<0x1::type_name::TypeName, u128>(&arg0.growth_global_by_token, *0x1::option::borrow<0x1::type_name::TypeName>(v5))
        } else {
            0
        };
        let v7 = if (v6 > 0) {
            0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::get_fullsail_distribution_growth_inside<T0, T1>(arg1, v2, v3, v6)
        } else {
            0
        };
        let v8 = if (0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::math_u128::greater_or_equal_overflowing(arg3, v7)) {
            arg3
        } else {
            v7
        };
        let v9 = v8;
        if (0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::math_u128::is_neg(v8)) {
            v9 = 0;
        };
        let v10 = 0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::math_u128::wrapping_sub(v4, v9);
        if (0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::math_u128::is_neg(v10)) {
            return (0, v4)
        };
        ((0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::full_math_u128::mul_div_floor(v10, 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::liquidity(v1), 18446744073709551616) as u64), v4)
    }

    public fun get_current_growth_global<T0, T1>(arg0: &Gauge<T0, T1>, arg1: &0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>, arg2: u64) : u128 {
        assert!(check_gauger_pool<T0, T1>(arg0, arg1), 319134756481074050);
        let v0 = 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::get_fullsail_distribution_growth_global<T0, T1>(arg1);
        let v1 = v0;
        let v2 = arg2 - 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::get_fullsail_distribution_last_updated<T0, T1>(arg1);
        let v3 = 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::get_fullsail_distribution_staked_liquidity<T0, T1>(arg1);
        let v4 = (0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::get_fullsail_distribution_reserve<T0, T1>(arg1) as u128) * 18446744073709551616;
        let v5 = if (v2 >= 0) {
            if (v4 > 0) {
                v3 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v5) {
            let v6 = arg0.o_sail_reward_rate * (v2 as u128);
            let v7 = v6;
            if (v6 > v4) {
                v7 = v4;
            };
            v1 = v0 + 0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::math_u128::checked_div_round(v7, v3, false);
        };
        v1
    }

    public fun get_current_growth_inside<T0, T1>(arg0: &Gauge<T0, T1>, arg1: &0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: u64) : u128 {
        assert!(check_gauger_pool<T0, T1>(arg0, arg1), 9223372693985230856);
        assert!(0x2::object_table::contains<0x2::object::ID, 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::Position>(&arg0.staked_positions, arg2), 9223372698279936004);
        let (v0, v1) = 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::tick_range(0x2::object_table::borrow<0x2::object::ID, 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::Position>(&arg0.staked_positions, arg2));
        0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::get_fullsail_distribution_growth_inside<T0, T1>(arg1, v0, v1, get_current_growth_global<T0, T1>(arg0, arg1, arg3))
    }

    public fun get_position_reward<T0, T1, T2>(arg0: &mut Gauge<T0, T1>, arg1: &mut 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>, arg2: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter_cap::VoterCap, arg3: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig, arg4: &StakedPosition, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        validate_voter_cap<T0, T1>(arg0, arg2);
        assert!(check_gauger_pool<T0, T1>(arg0, arg1), 922337342842463847);
        assert!(0x2::object::id<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig>(arg3) == arg0.distribution_config, 12698781401347504);
        assert!(0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::is_gauge_alive(arg3, 0x2::object::id<Gauge<T0, T1>>(arg0)), 967793647569473700);
        assert!(is_valid_reward_token<T0, T1, T2>(arg0), 896435666705415200);
        get_reward_internal<T0, T1, T2>(arg0, arg1, arg4.position_id, arg5, arg6)
    }

    public fun get_reward<T0, T1, T2>(arg0: &mut Gauge<T0, T1>, arg1: &mut 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>, arg2: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter_cap::VoterCap, arg3: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig, arg4: &vector<StakedPosition>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        validate_voter_cap<T0, T1>(arg0, arg2);
        assert!(check_gauger_pool<T0, T1>(arg0, arg1), 922337345419444224);
        assert!(0x2::object::id<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig>(arg3) == arg0.distribution_config, 695673975436220400);
        assert!(0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::is_gauge_alive(arg3, 0x2::object::id<Gauge<T0, T1>>(arg0)), 993998734106655200);
        assert!(is_valid_reward_token<T0, T1, T2>(arg0), 364572745470385970);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<StakedPosition>(arg4)) {
            v0 = v0 + get_reward_internal<T0, T1, T2>(arg0, arg1, 0x1::vector::borrow<StakedPosition>(arg4, v1).position_id, arg5, arg6);
            v1 = v1 + 1;
        };
        v0
    }

    fun get_reward_internal<T0, T1, T2>(arg0: &mut Gauge<T0, T1>, arg1: &mut 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : u64 {
        let v0 = update_reward_internal<T0, T1, T2>(arg0, arg1, arg2, arg3);
        if (v0 > 0) {
            let v1 = EventClaimReward{
                from        : 0x2::tx_context::sender(arg4),
                position_id : arg2,
                amount      : v0,
                token       : 0x1::type_name::get<T2>(),
            };
            0x2::event::emit<EventClaimReward>(v1);
        };
        v0
    }

    public fun is_valid_epoch_token<T0, T1, T2>(arg0: &Gauge<T0, T1>) : bool {
        let v0 = 0x1::type_name::get<T2>();
        0x1::option::borrow<0x1::type_name::TypeName>(&arg0.current_epoch_token) == &v0
    }

    public fun is_valid_reward_token<T0, T1, T2>(arg0: &Gauge<T0, T1>) : bool {
        0x2::linked_table::contains<0x1::type_name::TypeName, u128>(&arg0.growth_global_by_token, 0x1::type_name::get<T2>())
    }

    public fun lock_position<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &0xc3f7c8b6d8496b50ebb5c2c2ff476f30c3c49d95307312b60e38c82176edfcbc::locker_cap::LockerCap, arg2: 0x2::object::ID) {
        if (!0x2::table::contains<0x2::object::ID, Locked>(&arg0.locked_positions, arg2)) {
            let v0 = Locked{dummy_field: false};
            0x2::table::add<0x2::object::ID, Locked>(&mut arg0.locked_positions, arg2, v0);
        };
    }

    public fun notify_epoch_token<T0, T1, T2>(arg0: &mut Gauge<T0, T1>, arg1: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig, arg2: &mut 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>, arg3: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter_cap::VoterCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        validate_voter_cap<T0, T1>(arg0, arg3);
        assert!(check_gauger_pool<T0, T1>(arg0, arg2), 4672810119034640000);
        assert!(0x2::object::id<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig>(arg1) == arg0.distribution_config, 218800936909496100);
        assert!(0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::is_gauge_alive(arg1, 0x2::object::id<Gauge<T0, T1>>(arg0)), 213816814886850880);
        assert!(!is_valid_reward_token<T0, T1, T2>(arg0), 4041460742273430500);
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        assert!(v0 >= arg0.period_finish, 4159845750300726000);
        let v1 = 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::to_period(arg0.epoch_token_last_notified);
        assert!(v0 >= v1 + 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::epoch(), 776925370166021200);
        0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::update_fullsail_distribution_growth_global<T0, T1>(arg2, 0x1::option::borrow<0x759fdf7bc2175c3dd078e16d4703ea5ef655cd055ff74eca9c516e6173c6b42e::gauge_cap::GaugeCap>(&arg0.gauge_cap), arg4);
        let v2 = 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::get_fullsail_distribution_reserve<T0, T1>(arg2);
        assert!(v2 == 0, 3254849085073565700);
        arg0.period_finish = 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::epoch_next(v0);
        arg0.usd_reward_rate = 0;
        arg0.o_sail_reward_rate = 0;
        let v3 = if (0x2::table::contains<u64, u64>(&arg0.o_sail_emission_by_epoch, v1)) {
            0x2::table::remove<u64, u64>(&mut arg0.o_sail_emission_by_epoch, v1)
        } else {
            0
        };
        let v4 = v3 + arg0.last_distribution_reserve - v2;
        0x2::table::add<u64, u64>(&mut arg0.o_sail_emission_by_epoch, v1, v4);
        let v5 = 0x1::type_name::get<T2>();
        if (0x1::option::is_some<0x1::type_name::TypeName>(&arg0.current_epoch_token)) {
            let v6 = 0x1::option::extract<0x1::type_name::TypeName>(&mut arg0.current_epoch_token);
            0x2::linked_table::remove<0x1::type_name::TypeName, u128>(&mut arg0.growth_global_by_token, v6);
            0x2::linked_table::push_back<0x1::type_name::TypeName, u128>(&mut arg0.growth_global_by_token, v6, 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::get_fullsail_distribution_growth_global<T0, T1>(arg2));
        };
        0x1::option::fill<0x1::type_name::TypeName>(&mut arg0.current_epoch_token, v5);
        0x2::linked_table::push_back<0x1::type_name::TypeName, u128>(&mut arg0.growth_global_by_token, v5, 0);
        let v7 = EventNotifyEpochToken{
            sender : 0x2::object::id_from_address(0x2::tx_context::sender(arg5)),
            token  : v5,
        };
        arg0.epoch_token_last_notified = v0;
        0x2::event::emit<EventNotifyEpochToken>(v7);
        v4
    }

    public fun notify_reward<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig, arg2: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter_cap::VoterCap, arg3: &mut 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>, arg4: u64, arg5: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        validate_voter_cap<T0, T1>(arg0, arg2);
        assert!(0x2::object::id<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig>(arg1) == arg0.distribution_config, 311080855434061200);
        assert!(0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::is_gauge_alive(arg1, 0x2::object::id<Gauge<T0, T1>>(arg0)), 927999301192928000);
        assert!(check_gauger_pool<T0, T1>(arg0, arg3), 5832633373805671000);
        assert!(0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::is_valid_o_sail_price_aggregator(arg1, arg5), 399948098172884900);
        assert!(arg4 > 0, 9223373716188102674);
        assert!(0x2::clock::timestamp_ms(arg6) / 1000 < arg0.period_finish, 256780623436252400);
        let (v0, v1) = claim_fees_internal<T0, T1>(arg0, arg3);
        notify_reward_amount_internal<T0, T1>(arg0, arg4, arg6);
        sync_o_sail_distribution_price_internal<T0, T1>(arg0, arg3, 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::get_time_checked_price_q64(arg5, arg6), arg6);
        (v0, v1)
    }

    fun notify_reward_amount_internal<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v1 = 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::epoch_next(v0) - v0;
        arg0.usd_reward_rate = 0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::full_math_u128::mul_div_floor((arg1 as u128) + 0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::full_math_u128::mul_div_floor((v1 as u128), arg0.usd_reward_rate, 18446744073709551616), 18446744073709551616, (v1 as u128));
        if (0x2::table::contains<u64, u128>(&arg0.usd_reward_rate_by_epoch, 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::epoch_start(v0))) {
            0x2::table::remove<u64, u128>(&mut arg0.usd_reward_rate_by_epoch, 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::epoch_start(v0));
        };
        0x2::table::add<u64, u128>(&mut arg0.usd_reward_rate_by_epoch, 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::epoch_start(v0), arg0.usd_reward_rate);
        assert!(arg0.usd_reward_rate != 0, 9223373952411435028);
        let v2 = EventNotifyReward{
            sender     : *0x1::option::borrow<0x2::object::ID>(&arg0.voter),
            usd_amount : arg1,
        };
        0x2::event::emit<EventNotifyReward>(v2);
    }

    public fun notify_reward_without_claim<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig, arg2: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter_cap::VoterCap, arg3: &mut 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>, arg4: u64, arg5: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        validate_voter_cap<T0, T1>(arg0, arg2);
        assert!(0x2::object::id<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig>(arg1) == arg0.distribution_config, 921517595696832600);
        assert!(0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::is_gauge_alive(arg1, 0x2::object::id<Gauge<T0, T1>>(arg0)), 388157577581832000);
        assert!(check_gauger_pool<T0, T1>(arg0, arg3), 6794499896215460000);
        assert!(0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::is_valid_o_sail_price_aggregator(arg1, arg5), 835496110456481800);
        assert!(arg4 > 0, 9223373819267317778);
        notify_reward_amount_internal<T0, T1>(arg0, arg4, arg6);
        sync_o_sail_distribution_price_internal<T0, T1>(arg0, arg3, 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::get_time_checked_price_q64(arg5, arg6), arg6);
    }

    public fun o_sail_emission_by_epoch<T0, T1>(arg0: &Gauge<T0, T1>, arg1: u64) : u64 {
        *0x2::table::borrow<u64, u64>(&arg0.o_sail_emission_by_epoch, arg1)
    }

    public fun o_sail_reward_rate<T0, T1>(arg0: &Gauge<T0, T1>) : u128 {
        arg0.o_sail_reward_rate
    }

    public fun period_finish<T0, T1>(arg0: &Gauge<T0, T1>) : u64 {
        arg0.period_finish
    }

    public fun pool_id<T0, T1>(arg0: &Gauge<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun position_id(arg0: &StakedPosition) : 0x2::object::ID {
        arg0.position_id
    }

    public fun prev_reward_claimed<T0, T1>(arg0: &Gauge<T0, T1>, arg1: &mut 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>, arg2: 0x1::type_name::TypeName, arg3: 0x2::object::ID) : bool {
        assert!(check_gauger_pool<T0, T1>(arg0, arg1), 555281531268615500);
        let (v0, v1) = 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::tick_range(0x2::object_table::borrow<0x2::object::ID, 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::Position>(&arg0.staked_positions, arg3));
        let v2 = 0x2::linked_table::prev<0x1::type_name::TypeName, u128>(&arg0.growth_global_by_token, arg2);
        let v3 = if (0x1::option::is_some<0x1::type_name::TypeName>(v2)) {
            *0x2::linked_table::borrow<0x1::type_name::TypeName, u128>(&arg0.growth_global_by_token, *0x1::option::borrow<0x1::type_name::TypeName>(v2))
        } else {
            0
        };
        let v4 = if (v3 > 0) {
            0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::get_fullsail_distribution_growth_inside<T0, T1>(arg1, v0, v1, v3)
        } else {
            0
        };
        0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::math_u128::greater_or_equal_overflowing(0x2::table::borrow<0x2::object::ID, RewardProfile>(&arg0.rewards, arg3).growth_inside, v4)
    }

    public(friend) fun receive_gauge_cap<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: 0x759fdf7bc2175c3dd078e16d4703ea5ef655cd055ff74eca9c516e6173c6b42e::gauge_cap::GaugeCap) {
        assert!(arg0.pool_id == 0x759fdf7bc2175c3dd078e16d4703ea5ef655cd055ff74eca9c516e6173c6b42e::gauge_cap::get_pool_id(&arg1), 9223373119186534399);
        0x1::option::fill<0x759fdf7bc2175c3dd078e16d4703ea5ef655cd055ff74eca9c516e6173c6b42e::gauge_cap::GaugeCap>(&mut arg0.gauge_cap, arg1);
    }

    public(friend) fun set_voter<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: 0x2::object::ID) {
        0x1::option::fill<0x2::object::ID>(&mut arg0.voter, arg1);
        let v0 = EventGaugeSetVoter{
            id       : 0x2::object::id<Gauge<T0, T1>>(arg0),
            voter_id : arg1,
        };
        0x2::event::emit<EventGaugeSetVoter>(v0);
    }

    public fun sync_o_sail_distribution_price<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig, arg2: &mut 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>, arg3: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg4: &0x2::clock::Clock) {
        assert!(0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::is_valid_o_sail_price_aggregator(arg1, arg3), 989270720807518800);
        assert!(0x2::object::id<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig>(arg1) == arg0.distribution_config, 490749102979896500);
        assert!(0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::is_gauge_alive(arg1, 0x2::object::id<Gauge<T0, T1>>(arg0)), 298752582283296830);
        assert!(check_gauger_pool<T0, T1>(arg0, arg2), 485510326827034900);
        sync_o_sail_distribution_price_internal<T0, T1>(arg0, arg2, 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::get_time_checked_price_q64(arg3, arg4), arg4);
    }

    fun sync_o_sail_distribution_price_internal<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &mut 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>, arg2: u128, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        assert!(v0 < arg0.period_finish, 524842288068695600);
        0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::update_fullsail_distribution_growth_global<T0, T1>(arg1, 0x1::option::borrow<0x759fdf7bc2175c3dd078e16d4703ea5ef655cd055ff74eca9c516e6173c6b42e::gauge_cap::GaugeCap>(&arg0.gauge_cap), arg3);
        let v1 = 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::to_period(arg0.epoch_token_last_notified);
        if (arg0.last_distribution_reserve > 0) {
            let v2 = if (0x2::table::contains<u64, u64>(&arg0.o_sail_emission_by_epoch, v1)) {
                0x2::table::remove<u64, u64>(&mut arg0.o_sail_emission_by_epoch, v1)
            } else {
                0
            };
            0x2::table::add<u64, u64>(&mut arg0.o_sail_emission_by_epoch, v1, v2 + arg0.last_distribution_reserve - 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::get_fullsail_distribution_reserve<T0, T1>(arg1));
        };
        let v3 = 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::epoch_next(v0);
        let v4 = v3 - v0;
        let v5 = 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::usd_q64_to_asset_q64(arg0.usd_reward_rate * (v4 as u128), arg2);
        let v6 = v5 / (v4 as u128);
        let v7 = ((v5 >> 64) as u64);
        arg0.o_sail_reward_rate = v6;
        arg0.last_distribution_reserve = v7;
        0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::sync_fullsail_distribution_reward<T0, T1>(arg1, 0x1::option::borrow<0x759fdf7bc2175c3dd078e16d4703ea5ef655cd055ff74eca9c516e6173c6b42e::gauge_cap::GaugeCap>(&arg0.gauge_cap), v6, v7, v3, arg3);
    }

    public fun unlock_position<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &0xc3f7c8b6d8496b50ebb5c2c2ff476f30c3c49d95307312b60e38c82176edfcbc::locker_cap::LockerCap, arg2: 0x2::object::ID) {
        if (0x2::table::contains<0x2::object::ID, Locked>(&arg0.locked_positions, arg2)) {
            0x2::table::remove<0x2::object::ID, Locked>(&mut arg0.locked_positions, arg2);
        };
    }

    fun update_reward_internal<T0, T1, T2>(arg0: &mut Gauge<T0, T1>, arg1: &mut 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T2>();
        assert!(prev_reward_claimed<T0, T1>(arg0, arg1, v0, arg2), 863923888158323800);
        let v1 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let (v2, v3) = earned_internal<T0, T1>(arg0, arg1, arg2, v0, v1);
        let v4 = 0x2::table::borrow_mut<0x2::object::ID, RewardProfile>(&mut arg0.rewards, arg2);
        0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::update_fullsail_distribution_growth_global<T0, T1>(arg1, 0x1::option::borrow<0x759fdf7bc2175c3dd078e16d4703ea5ef655cd055ff74eca9c516e6173c6b42e::gauge_cap::GaugeCap>(&arg0.gauge_cap), arg3);
        v4.last_update_time = v1;
        v4.amount = v4.amount + v2;
        v4.growth_inside = v3;
        v4.amount = 0;
        v4.amount
    }

    public fun usd_reward_rate<T0, T1>(arg0: &Gauge<T0, T1>) : u128 {
        arg0.usd_reward_rate
    }

    public fun usd_reward_rate_by_epoch_start<T0, T1>(arg0: &Gauge<T0, T1>, arg1: u64) : u128 {
        *0x2::table::borrow<u64, u128>(&arg0.usd_reward_rate_by_epoch, arg1)
    }

    fun validate_voter_cap<T0, T1>(arg0: &Gauge<T0, T1>, arg1: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter_cap::VoterCap) {
        let v0 = 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter_cap::get_voter_id(arg1);
        assert!(&v0 == 0x1::option::borrow<0x2::object::ID>(&arg0.voter), 922337365605842945);
    }

    public fun withdraw_position<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &mut 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>, arg2: StakedPosition, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::Position {
        assert!(0x2::object_table::contains<0x2::object::ID, 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::Position>(&arg0.staked_positions, arg2.position_id), 9223373570158297092);
        assert!(!0x2::table::contains<0x2::object::ID, Locked>(&arg0.locked_positions, arg2.position_id), 922337373443534534);
        let v0 = withdraw_position_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        let v1 = EventWithdrawPosition{
            position_id : 0x2::object::id<0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::Position>(&v0),
            gauger_id   : 0x2::object::id<Gauge<T0, T1>>(arg0),
        };
        0x2::event::emit<EventWithdrawPosition>(v1);
        v0
    }

    public fun withdraw_position_by_locker<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &0xc3f7c8b6d8496b50ebb5c2c2ff476f30c3c49d95307312b60e38c82176edfcbc::locker_cap::LockerCap, arg2: &mut 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>, arg3: StakedPosition, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::Position {
        assert!(0x2::object_table::contains<0x2::object::ID, 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::Position>(&arg0.staked_positions, arg3.position_id), 9223373570158297092);
        withdraw_position_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5)
    }

    fun withdraw_position_internal<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &mut 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>, arg2: StakedPosition, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::Position {
        assert!(check_gauger_pool<T0, T1>(arg0, arg1), 496532944256373500);
        assert!(all_rewards_claimed<T0, T1>(arg0, arg1, arg2.position_id, arg3), 51536857596176540);
        let v0 = 0x2::object_table::remove<0x2::object::ID, 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::position::Position>(&mut arg0.staked_positions, arg2.position_id);
        0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::unstake_from_fullsail_distribution<T0, T1>(arg1, 0x1::option::borrow<0x759fdf7bc2175c3dd078e16d4703ea5ef655cd055ff74eca9c516e6173c6b42e::gauge_cap::GaugeCap>(&arg0.gauge_cap), &v0, arg3);
        destroy_staked_positions(arg2);
        v0
    }

    // decompiled from Move bytecode v6
}

