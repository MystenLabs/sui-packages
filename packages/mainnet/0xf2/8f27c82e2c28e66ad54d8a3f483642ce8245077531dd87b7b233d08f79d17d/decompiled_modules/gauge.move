module 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::gauge {
    struct TRANSFORMER has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct EventNotifyReward has copy, drop, store {
        sender: 0x2::object::ID,
        amount: u64,
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
        receiver: address,
        amount: u64,
    }

    struct EventWithdrawPosition has copy, drop, store {
        position_id: 0x2::object::ID,
        gauger_id: 0x2::object::ID,
    }

    struct EventDepositGauge has copy, drop, store {
        gauger_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
    }

    struct EventGaugeCreated has copy, drop, store {
        id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
    }

    struct EventGaugeSetVoter has copy, drop, store {
        id: 0x2::object::ID,
        voter_id: 0x2::object::ID,
    }

    struct Gauge<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        gauge_cap: 0x1::option::Option<0xd5dca9246b84c016555cc96c8b2f183db9341e97103da6d787087a0e9277f62b::gauge_cap::GaugeCap>,
        staked_positions: 0x2::object_table::ObjectTable<0x2::object::ID, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::Position>,
        staked_position_infos: 0x2::table::Table<0x2::object::ID, PositionStakeInfo>,
        reserves_balance: 0x2::balance::Balance<T2>,
        fee_a: 0x2::balance::Balance<T0>,
        fee_b: 0x2::balance::Balance<T1>,
        voter: 0x1::option::Option<0x2::object::ID>,
        reward_rate: u128,
        period_finish: u64,
        reward_rate_by_epoch: 0x2::table::Table<u64, u128>,
        stakes: 0x2::table::Table<address, vector<0x2::object::ID>>,
        rewards: 0x2::table::Table<0x2::object::ID, RewardProfile>,
    }

    struct PositionStakeInfo has drop, store {
        from: address,
        received: bool,
    }

    public fun pool_id<T0, T1, T2>(arg0: &Gauge<T0, T1, T2>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun check_gauger_pool<T0, T1, T2>(arg0: &Gauge<T0, T1, T2>, arg1: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::Pool<T0, T1>) : bool {
        (arg0.pool_id != 0x2::object::id<0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::Pool<T0, T1>>(arg1) || 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::get_magma_distribution_gauger_id<T0, T1>(arg1) != 0x2::object::id<Gauge<T0, T1, T2>>(arg0)) && false || true
    }

    fun check_voter_cap<T0, T1, T2>(arg0: &Gauge<T0, T1, T2>, arg1: &0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter_cap::VoterCap) {
        let v0 = 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter_cap::get_voter_id(arg1);
        assert!(&v0 == 0x1::option::borrow<0x2::object::ID>(&arg0.voter), 9223373656058429456);
    }

    public fun claim_fees<T0, T1, T2>(arg0: &mut Gauge<T0, T1, T2>, arg1: &0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::notify_reward_cap::NotifyRewardCap, arg2: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::Pool<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        claim_fees_internal<T0, T1, T2>(arg0, arg2)
    }

    fun claim_fees_internal<T0, T1, T2>(arg0: &mut Gauge<T0, T1, T2>, arg1: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::Pool<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::collect_magma_distribution_gauger_fees<T0, T1>(arg1, 0x1::option::borrow<0xd5dca9246b84c016555cc96c8b2f183db9341e97103da6d787087a0e9277f62b::gauge_cap::GaugeCap>(&arg0.gauge_cap));
        let v2 = v1;
        let v3 = v0;
        if (0x2::balance::value<T0>(&v3) > 0 || 0x2::balance::value<T1>(&v2) > 0) {
            let v4 = 0x2::balance::join<T0>(&mut arg0.fee_a, v3);
            let v5 = 0x2::balance::join<T1>(&mut arg0.fee_b, v2);
            let v6 = if (v4 > 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::week()) {
                0x2::balance::withdraw_all<T0>(&mut arg0.fee_a)
            } else {
                0x2::balance::zero<T0>()
            };
            let v7 = if (v5 > 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::week()) {
                0x2::balance::withdraw_all<T1>(&mut arg0.fee_b)
            } else {
                0x2::balance::zero<T1>()
            };
            let v8 = EventClaimFees{
                amount_a : v4,
                amount_b : v5,
            };
            0x2::event::emit<EventClaimFees>(v8);
            return (v6, v7)
        };
        0x2::balance::destroy_zero<T0>(v3);
        0x2::balance::destroy_zero<T1>(v2);
        (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
    }

    public(friend) fun create<T0, T1, T2>(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : Gauge<T0, T1, T2> {
        let v0 = 0x2::object::new(arg1);
        let v1 = EventGaugeCreated{
            id      : 0x2::object::uid_to_inner(&v0),
            pool_id : arg0,
        };
        0x2::event::emit<EventGaugeCreated>(v1);
        Gauge<T0, T1, T2>{
            id                    : v0,
            pool_id               : arg0,
            gauge_cap             : 0x1::option::none<0xd5dca9246b84c016555cc96c8b2f183db9341e97103da6d787087a0e9277f62b::gauge_cap::GaugeCap>(),
            staked_positions      : 0x2::object_table::new<0x2::object::ID, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::Position>(arg1),
            staked_position_infos : 0x2::table::new<0x2::object::ID, PositionStakeInfo>(arg1),
            reserves_balance      : 0x2::balance::zero<T2>(),
            fee_a                 : 0x2::balance::zero<T0>(),
            fee_b                 : 0x2::balance::zero<T1>(),
            voter                 : 0x1::option::none<0x2::object::ID>(),
            reward_rate           : 0,
            period_finish         : 0,
            reward_rate_by_epoch  : 0x2::table::new<u64, u128>(arg1),
            stakes                : 0x2::table::new<address, vector<0x2::object::ID>>(arg1),
            rewards               : 0x2::table::new<0x2::object::ID, RewardProfile>(arg1),
        }
    }

    public fun deposit_position<T0, T1, T2>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &mut Gauge<T0, T1, T2>, arg2: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::Pool<T0, T1>, arg3: 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::Position, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::checked_package_version(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::object::id<0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::Pool<T0, T1>>(arg2);
        let v2 = 0x2::object::id<0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::Position>(&arg3);
        assert!(0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::is_gauge_alive(arg0, 0x2::object::id<Gauge<T0, T1, T2>>(arg1)), 9223373157842747416);
        assert!(check_gauger_pool<T0, T1, T2>(arg1, arg2), 9223373162136666120);
        assert!(0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::pool_id(&arg3) == v1, 9223373166431764490);
        assert!(!0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::is_staked(0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::borrow_position_info(0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::position_manager<T0, T1>(arg2), v2)), 9223373175021174786);
        let v3 = PositionStakeInfo{
            from     : v0,
            received : false,
        };
        0x2::table::add<0x2::object::ID, PositionStakeInfo>(&mut arg1.staked_position_infos, v2, v3);
        let (v4, v5) = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::collect_fee<T0, T1>(arg0, arg2, &arg3, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg5), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg5), v0);
        let (v6, v7) = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::tick_range(&arg3);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg1.stakes, v0)) {
            let v8 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v8, v2);
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg1.stakes, v0, v8);
        } else {
            0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg1.stakes, v0), v2);
        };
        0x2::object_table::add<0x2::object::ID, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::Position>(&mut arg1.staked_positions, v2, arg3);
        if (!0x2::table::contains<0x2::object::ID, RewardProfile>(&arg1.rewards, v2)) {
            let v9 = RewardProfile{
                growth_inside    : 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::get_magma_distribution_growth_inside<T0, T1>(arg2, v6, v7, 0),
                amount           : 0,
                last_update_time : 0x2::clock::timestamp_ms(arg4) / 1000,
            };
            0x2::table::add<0x2::object::ID, RewardProfile>(&mut arg1.rewards, v2, v9);
        } else {
            let v10 = 0x2::table::borrow_mut<0x2::object::ID, RewardProfile>(&mut arg1.rewards, v2);
            v10.growth_inside = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::get_magma_distribution_growth_inside<T0, T1>(arg2, v6, v7, 0);
            v10.last_update_time = 0x2::clock::timestamp_ms(arg4) / 1000;
        };
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::mark_position_staked<T0, T1>(arg2, 0x1::option::borrow<0xd5dca9246b84c016555cc96c8b2f183db9341e97103da6d787087a0e9277f62b::gauge_cap::GaugeCap>(&arg1.gauge_cap), v2);
        0x2::table::borrow_mut<0x2::object::ID, PositionStakeInfo>(&mut arg1.staked_position_infos, v2).received = true;
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::stake_in_magma_distribution<T0, T1>(arg2, 0x1::option::borrow<0xd5dca9246b84c016555cc96c8b2f183db9341e97103da6d787087a0e9277f62b::gauge_cap::GaugeCap>(&arg1.gauge_cap), 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::liquidity(&arg3), v6, v7, arg4);
        let v11 = EventDepositGauge{
            gauger_id   : 0x2::object::id<Gauge<T0, T1, T2>>(arg1),
            pool_id     : v1,
            position_id : v2,
        };
        0x2::event::emit<EventDepositGauge>(v11);
    }

    public fun earned_by_account<T0, T1, T2>(arg0: &Gauge<T0, T1, T2>, arg1: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::Pool<T0, T1>, arg2: address, arg3: &0x2::clock::Clock) : u64 {
        assert!(check_gauger_pool<T0, T1, T2>(arg0, arg1), 9223372724050001928);
        let v0 = 0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.stakes, arg2);
        let v1 = 0;
        let v2 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(v0)) {
            v2 = v2 + earned_internal<T0, T1, T2>(arg0, arg1, *0x1::vector::borrow<0x2::object::ID>(v0, v1), 0x2::clock::timestamp_ms(arg3) / 1000);
            v1 = v1 + 1;
        };
        v2
    }

    public fun earned_by_position<T0, T1, T2>(arg0: &Gauge<T0, T1, T2>, arg1: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : u64 {
        assert!(check_gauger_pool<T0, T1, T2>(arg0, arg1), 9223372693985230856);
        assert!(0x2::object_table::contains<0x2::object::ID, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::Position>(&arg0.staked_positions, arg2), 9223372698279936004);
        earned_internal<T0, T1, T2>(arg0, arg1, arg2, 0x2::clock::timestamp_ms(arg3) / 1000)
    }

    fun earned_internal<T0, T1, T2>(arg0: &Gauge<T0, T1, T2>, arg1: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: u64) : u64 {
        let v0 = arg3 - 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::get_magma_distribution_last_updated<T0, T1>(arg1);
        let v1 = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::get_magma_distribution_growth_global<T0, T1>(arg1);
        let v2 = v1;
        let v3 = (0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::get_magma_distribution_reserve<T0, T1>(arg1) as u128) * 18446744073709551616;
        let v4 = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::get_magma_distribution_staked_liquidity<T0, T1>(arg1);
        if (v0 >= 0 && v3 > 0 && v4 > 0) {
            let v5 = arg0.reward_rate * (v0 as u128);
            let v6 = v5;
            if (v5 > v3) {
                v6 = v3;
            };
            v2 = v1 + 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::math_u128::checked_div_round(v6, v4, false);
        };
        let v7 = 0x2::object_table::borrow<0x2::object::ID, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::Position>(&arg0.staked_positions, arg2);
        let (v8, v9) = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::tick_range(v7);
        (0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::full_math_u128::mul_div_floor(0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::get_magma_distribution_growth_inside<T0, T1>(arg1, v8, v9, v2) - 0x2::table::borrow<0x2::object::ID, RewardProfile>(&arg0.rewards, arg2).growth_inside, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::liquidity(v7), 18446744073709551616) as u64)
    }

    public fun get_position_reward<T0, T1, T2>(arg0: &mut Gauge<T0, T1, T2>, arg1: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(check_gauger_pool<T0, T1, T2>(arg0, arg1), 9223373428424638472);
        assert!(0x2::object_table::contains<0x2::object::ID, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::Position>(&arg0.staked_positions, arg2), 9223373432719343620);
        get_reward_internal<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun get_reward<T0, T1, T2>(arg0: &mut Gauge<T0, T1, T2>, arg1: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(check_gauger_pool<T0, T1, T2>(arg0, arg1), 9223373454194442248);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.stakes, v0), 9223373462784638988);
        let v1 = 0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.stakes, v0);
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x2::object::ID>(v1)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v2, *0x1::vector::borrow<0x2::object::ID>(v1, v3));
            v3 = v3 + 1;
        };
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x2::object::ID>(&v2)) {
            get_reward_internal<T0, T1, T2>(arg0, arg1, *0x1::vector::borrow<0x2::object::ID>(&v2, v4), arg2, arg3);
            v4 = v4 + 1;
        };
    }

    public fun get_reward_for<T0, T1, T2>(arg0: &mut Gauge<T0, T1, T2>, arg1: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::Pool<T0, T1>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(check_gauger_pool<T0, T1, T2>(arg0, arg1), 9223373510029017096);
        assert!(0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.stakes, arg2), 9223373514324246540);
        let v0 = 0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.stakes, arg2);
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(v0)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v1, *0x1::vector::borrow<0x2::object::ID>(v0, v2));
            v2 = v2 + 1;
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            get_reward_internal<T0, T1, T2>(arg0, arg1, *0x1::vector::borrow<0x2::object::ID>(&v1, v3), arg3, arg4);
            v3 = v3 + 1;
        };
    }

    fun get_reward_internal<T0, T1, T2>(arg0: &mut Gauge<T0, T1, T2>, arg1: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::tick_range(0x2::object_table::borrow<0x2::object::ID, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::Position>(&arg0.staked_positions, arg2));
        let v2 = update_reward_internal<T0, T1, T2>(arg0, arg1, arg2, v0, v1, arg3);
        if (0x2::balance::value<T2>(&v2) > 0) {
            let v3 = 0x2::table::borrow<0x2::object::ID, PositionStakeInfo>(&arg0.staked_position_infos, arg2).from;
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v2, arg4), v3);
            let v4 = EventClaimReward{
                from        : 0x2::tx_context::sender(arg4),
                position_id : arg2,
                receiver    : v3,
                amount      : 0x2::balance::value<T2>(&v2),
            };
            0x2::event::emit<EventClaimReward>(v4);
        } else {
            0x2::balance::destroy_zero<T2>(v2);
        };
    }

    public fun notify_reward<T0, T1, T2>(arg0: &mut Gauge<T0, T1, T2>, arg1: &0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter_cap::VoterCap, arg2: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        check_voter_cap<T0, T1, T2>(arg0, arg1);
        let v0 = 0x2::balance::value<T2>(&arg3);
        assert!(v0 > 0, 9223373716188102674);
        0x2::balance::join<T2>(&mut arg0.reserves_balance, arg3);
        let (v1, v2) = claim_fees_internal<T0, T1, T2>(arg0, arg2);
        notify_reward_amount_internal<T0, T1, T2>(arg0, arg2, v0, arg4);
        let v3 = EventNotifyReward{
            sender : 0x2::object::id_from_address(0x2::tx_context::sender(arg5)),
            amount : v0,
        };
        0x2::event::emit<EventNotifyReward>(v3);
        (v1, v2)
    }

    fun notify_reward_amount_internal<T0, T1, T2>(arg0: &mut Gauge<T0, T1, T2>, arg1: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v1 = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::epoch_next(v0) - v0;
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::update_magma_distribution_growth_global<T0, T1>(arg1, 0x1::option::borrow<0xd5dca9246b84c016555cc96c8b2f183db9341e97103da6d787087a0e9277f62b::gauge_cap::GaugeCap>(&arg0.gauge_cap), arg3);
        let v2 = v0 + v1;
        let v3 = arg2 + 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::get_magma_distribution_rollover<T0, T1>(arg1);
        if (v0 >= arg0.period_finish) {
            arg0.reward_rate = 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::full_math_u128::mul_div_floor((v3 as u128), 18446744073709551616, (v1 as u128));
            0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::sync_magma_distribution_reward<T0, T1>(arg1, 0x1::option::borrow<0xd5dca9246b84c016555cc96c8b2f183db9341e97103da6d787087a0e9277f62b::gauge_cap::GaugeCap>(&arg0.gauge_cap), arg0.reward_rate, 0x2::balance::value<T2>(&arg0.reserves_balance), v2);
        } else {
            let v4 = (v1 as u128) * arg0.reward_rate;
            arg0.reward_rate = 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::full_math_u128::mul_div_floor((v3 as u128) + v4, 18446744073709551616, (v1 as u128));
            0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::sync_magma_distribution_reward<T0, T1>(arg1, 0x1::option::borrow<0xd5dca9246b84c016555cc96c8b2f183db9341e97103da6d787087a0e9277f62b::gauge_cap::GaugeCap>(&arg0.gauge_cap), arg0.reward_rate, 0x2::balance::value<T2>(&arg0.reserves_balance) + ((v4 / 18446744073709551616) as u64), v2);
        };
        0x2::table::add<u64, u128>(&mut arg0.reward_rate_by_epoch, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::epoch_start(v0), arg0.reward_rate);
        assert!(arg0.reward_rate != 0, 9223373952411435028);
        assert!(arg0.reward_rate <= 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::full_math_u128::mul_div_floor((0x2::balance::value<T2>(&arg0.reserves_balance) as u128), 18446744073709551616, (v1 as u128)), 9223373956706533398);
        arg0.period_finish = v2;
        let v5 = EventNotifyReward{
            sender : *0x1::option::borrow<0x2::object::ID>(&arg0.voter),
            amount : v3,
        };
        0x2::event::emit<EventNotifyReward>(v5);
    }

    public fun notify_reward_without_claim<T0, T1, T2>(arg0: &mut Gauge<T0, T1, T2>, arg1: &0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter_cap::VoterCap, arg2: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check_voter_cap<T0, T1, T2>(arg0, arg1);
        let v0 = 0x2::balance::value<T2>(&arg3);
        assert!(v0 > 0, 9223373819267317778);
        0x2::balance::join<T2>(&mut arg0.reserves_balance, arg3);
        notify_reward_amount_internal<T0, T1, T2>(arg0, arg2, v0, arg4);
        let v1 = EventNotifyReward{
            sender : 0x2::object::id_from_address(0x2::tx_context::sender(arg5)),
            amount : v0,
        };
        0x2::event::emit<EventNotifyReward>(v1);
    }

    public fun period_finish<T0, T1, T2>(arg0: &Gauge<T0, T1, T2>) : u64 {
        arg0.period_finish
    }

    public(friend) fun receive_gauge_cap<T0, T1, T2>(arg0: &mut Gauge<T0, T1, T2>, arg1: 0xd5dca9246b84c016555cc96c8b2f183db9341e97103da6d787087a0e9277f62b::gauge_cap::GaugeCap) {
        assert!(arg0.pool_id == 0xd5dca9246b84c016555cc96c8b2f183db9341e97103da6d787087a0e9277f62b::gauge_cap::get_pool_id(&arg1), 9223373119186534399);
        0x1::option::fill<0xd5dca9246b84c016555cc96c8b2f183db9341e97103da6d787087a0e9277f62b::gauge_cap::GaugeCap>(&mut arg0.gauge_cap, arg1);
    }

    public fun reserves_balance<T0, T1, T2>(arg0: &Gauge<T0, T1, T2>) : u64 {
        0x2::balance::value<T2>(&arg0.reserves_balance)
    }

    public fun reward_rate<T0, T1, T2>(arg0: &Gauge<T0, T1, T2>) : u128 {
        arg0.reward_rate
    }

    public fun reward_rate_by_epoch<T0, T1, T2>(arg0: &Gauge<T0, T1, T2>, arg1: u64) : u128 {
        *0x2::table::borrow<u64, u128>(&arg0.reward_rate_by_epoch, arg1)
    }

    public(friend) fun set_voter<T0, T1, T2>(arg0: &mut Gauge<T0, T1, T2>, arg1: 0x2::object::ID) {
        0x1::option::fill<0x2::object::ID>(&mut arg0.voter, arg1);
        let v0 = EventGaugeSetVoter{
            id       : 0x2::object::id<Gauge<T0, T1, T2>>(arg0),
            voter_id : arg1,
        };
        0x2::event::emit<EventGaugeSetVoter>(v0);
    }

    public fun stakes<T0, T1, T2>(arg0: &Gauge<T0, T1, T2>, arg1: address) : vector<0x2::object::ID> {
        let v0 = 0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.stakes, arg1);
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(v0)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v1, *0x1::vector::borrow<0x2::object::ID>(v0, v2));
            v2 = v2 + 1;
        };
        v1
    }

    fun update_reward_internal<T0, T1, T2>(arg0: &mut Gauge<T0, T1, T2>, arg1: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32, arg4: 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::i32::I32, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<T2> {
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, RewardProfile>(&mut arg0.rewards, arg2);
        if (v1.last_update_time >= v0) {
            v1.amount = 0;
            return 0x2::balance::split<T2>(&mut arg0.reserves_balance, v1.amount)
        };
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::update_magma_distribution_growth_global<T0, T1>(arg1, 0x1::option::borrow<0xd5dca9246b84c016555cc96c8b2f183db9341e97103da6d787087a0e9277f62b::gauge_cap::GaugeCap>(&arg0.gauge_cap), arg5);
        v1.last_update_time = v0;
        v1.amount = v1.amount + earned_internal<T0, T1, T2>(arg0, arg1, arg2, v0);
        v1.growth_inside = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::get_magma_distribution_growth_inside<T0, T1>(arg1, arg3, arg4, 0);
        v1.amount = 0;
        0x2::balance::split<T2>(&mut arg0.reserves_balance, v1.amount)
    }

    public fun withdraw_position<T0, T1, T2>(arg0: &mut Gauge<T0, T1, T2>, arg1: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object_table::contains<0x2::object::ID, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::Position>(&arg0.staked_positions, arg2) && 0x2::table::contains<0x2::object::ID, PositionStakeInfo>(&arg0.staked_position_infos, arg2), 9223373570158297092);
        let v0 = 0x2::table::remove<0x2::object::ID, PositionStakeInfo>(&mut arg0.staked_position_infos, arg2);
        assert!(v0.received, 9223373578748887054);
        if (v0.from != 0x2::tx_context::sender(arg4)) {
            0x2::table::add<0x2::object::ID, PositionStakeInfo>(&mut arg0.staked_position_infos, arg2, v0);
        } else {
            let v1 = 0x2::object_table::remove<0x2::object::ID, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::Position>(&mut arg0.staked_positions, arg2);
            let v2 = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::liquidity(&v1);
            if (v2 > 0) {
                let (v3, v4) = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::tick_range(&v1);
                0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::unstake_from_magma_distribution<T0, T1>(arg1, 0x1::option::borrow<0xd5dca9246b84c016555cc96c8b2f183db9341e97103da6d787087a0e9277f62b::gauge_cap::GaugeCap>(&arg0.gauge_cap), v2, v3, v4, arg3);
            };
            0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::mark_position_unstaked<T0, T1>(arg1, 0x1::option::borrow<0xd5dca9246b84c016555cc96c8b2f183db9341e97103da6d787087a0e9277f62b::gauge_cap::GaugeCap>(&arg0.gauge_cap), arg2);
            0x2::transfer::public_transfer<0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::Position>(v1, v0.from);
            let v5 = EventWithdrawPosition{
                position_id : arg2,
                gauger_id   : 0x2::object::id<Gauge<T0, T1, T2>>(arg0),
            };
            0x2::event::emit<EventWithdrawPosition>(v5);
        };
    }

    // decompiled from Move bytecode v6
}

