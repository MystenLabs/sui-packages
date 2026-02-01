module 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge {
    struct GAUGE has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct StakedPosition has store, key {
        id: 0x2::object::UID,
        position_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        description: 0x1::string::String,
        name: 0x1::string::String,
    }

    struct EventNotifyEpochToken has copy, drop, store {
        sender: 0x2::object::ID,
        gauge_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
        prev_token: 0x1::option::Option<0x1::type_name::TypeName>,
        growth_global_prev_token: u128,
    }

    struct EventNotifyReward has copy, drop, store {
        sender: 0x2::object::ID,
        usd_amount: u64,
    }

    struct EventSyncOSailDistributionPrice has copy, drop, store {
        gauge_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        price_q64: u128,
        remaining_o_sail_q64: u128,
        remaining_usd_q64: u128,
    }

    struct EventSyncOSailDistributionFinish has copy, drop, store {
        gauge_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        period_finish: u64,
        usd_reward_rate: u128,
        o_sail_reward_rate: u128,
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

    struct EventWithdrawPosition has copy, drop, store {
        staked_position_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        gauger_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
    }

    struct EventDepositGauge has copy, drop, store {
        gauger_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        staked_position_id: 0x2::object::ID,
        start_growth_inside: u128,
    }

    struct EventGaugeSetVoter has copy, drop, store {
        id: 0x2::object::ID,
        voter_id: 0x2::object::ID,
    }

    struct EventUpdateRewardPosition has copy, drop, store {
        gauger_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        growth_inside: u128,
        amount: u64,
    }

    struct EventNullRewards has copy, drop, store {
        gauge_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        rewards_nulled_usd: u64,
    }

    struct EventAddUnclaimedOsail has copy, drop, store {
        gauge_id: 0x2::object::ID,
        amount: u64,
    }

    struct EventRemoveUnclaimedOsail has copy, drop, store {
        gauge_id: 0x2::object::ID,
        amount: u64,
    }

    struct EventPoolRewardRedeposited has copy, drop, store {
        gauge_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        staked_position_id: 0x2::object::ID,
        reward_token: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct EventUpdateOsailDistribution has copy, drop, store {
        gauge_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        epoch_start: u64,
        o_sail_emission: u64,
        o_sail_distribution_reserve: u64,
    }

    struct EventCollectEarlyWithdrawalPenalty has copy, drop, store {
        gauge_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        early_withdrawal_penalty: u128,
        penalty_amount_a: u64,
        penalty_amount_b: u64,
        fee_a: u64,
        fee_b: u64,
        timestamp: u64,
    }

    struct Locked has copy, drop, store {
        dummy_field: bool,
    }

    struct Gauge<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        gauge_cap: 0x1::option::Option<0x500636366963eb62bee705e420dacd6e3770447914043d7978deb49372401e::gauge_cap::GaugeCap>,
        distribution_config: 0x2::object::ID,
        staked_positions: 0x2::object_table::ObjectTable<0x2::object::ID, 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>,
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
        rewards: 0x2::table::Table<0x2::object::ID, RewardProfile>,
        bag: 0x2::bag::Bag,
    }

    public fun get_pool_id(arg0: &StakedPosition) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun pool_id<T0, T1>(arg0: &Gauge<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public(friend) fun add_unclaimed_o_sail<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: u64) {
        let v0 = if (0x2::bag::contains<vector<u8>>(&arg0.bag, b"unclaimed_o_sail")) {
            0x2::bag::remove<vector<u8>, u64>(&mut arg0.bag, b"unclaimed_o_sail")
        } else {
            0
        };
        0x2::bag::add<vector<u8>, u64>(&mut arg0.bag, b"unclaimed_o_sail", v0 + arg1);
        let v1 = EventAddUnclaimedOsail{
            gauge_id : 0x2::object::id<Gauge<T0, T1>>(arg0),
            amount   : arg1,
        };
        0x2::event::emit<EventAddUnclaimedOsail>(v1);
    }

    public fun all_rewards_claimed<T0, T1>(arg0: &Gauge<T0, T1>, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : bool {
        assert!(check_gauger_pool<T0, T1>(arg0, arg1), 577203795438525600);
        let (v0, _) = earned_internal<T0, T1>(arg0, arg1, arg2, 0x2::clock::timestamp_ms(arg3) / 1000);
        v0 == 0
    }

    public fun borrow_epoch_token<T0, T1>(arg0: &Gauge<T0, T1>) : &0x1::type_name::TypeName {
        0x1::option::borrow<0x1::type_name::TypeName>(&arg0.current_epoch_token)
    }

    public fun borrow_position<T0, T1>(arg0: &Gauge<T0, T1>, arg1: &StakedPosition) : &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position {
        abort 13906843116465291263
    }

    fun calc_future_rewards<T0, T1>(arg0: &Gauge<T0, T1>, arg1: u64) : (u64, u64) {
        let v0 = 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::epoch_next(arg1) - arg1;
        ((0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor((v0 as u128), arg0.usd_reward_rate, 18446744073709551616) as u64), v0)
    }

    public fun check_gauger_pool<T0, T1>(arg0: &Gauge<T0, T1>, arg1: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>) : bool {
        arg0.pool_id == 0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg1)
    }

    public fun claim_fees<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribute_cap::DistributeCap, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        claim_fees_internal<T0, T1>(arg0, arg2)
    }

    fun claim_fees_internal<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::epoch();
        let (v1, v2) = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::collect_fullsail_distribution_gauger_fees<T0, T1>(arg1, 0x1::option::borrow<0x500636366963eb62bee705e420dacd6e3770447914043d7978deb49372401e::gauge_cap::GaugeCap>(&arg0.gauge_cap));
        let v3 = v2;
        let v4 = v1;
        let v5 = if (0x2::balance::value<T0>(&v4) > 0) {
            true
        } else if (0x2::balance::value<T1>(&v3) > 0) {
            true
        } else if (0x2::balance::value<T0>(&arg0.fee_a) > 0) {
            true
        } else {
            0x2::balance::value<T1>(&arg0.fee_b) > 0
        };
        if (v5) {
            let v6 = 0x2::balance::join<T0>(&mut arg0.fee_a, v4);
            let v7 = 0x2::balance::join<T1>(&mut arg0.fee_b, v3);
            let v8 = if (v0 > 0 && v6 / v0 > 0) {
                0x2::balance::withdraw_all<T0>(&mut arg0.fee_a)
            } else {
                0x2::balance::zero<T0>()
            };
            let v9 = if (v0 > 0 && v7 / v0 > 0) {
                0x2::balance::withdraw_all<T1>(&mut arg0.fee_b)
            } else {
                0x2::balance::zero<T1>()
            };
            let v10 = EventClaimFees{
                amount_a : v6,
                amount_b : v7,
            };
            0x2::event::emit<EventClaimFees>(v10);
            return (v8, v9)
        };
        0x2::balance::destroy_zero<T0>(v4);
        0x2::balance::destroy_zero<T1>(v3);
        (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
    }

    fun collect_early_withdrawal_penalty<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg3: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg4: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg5: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        if (!is_withdrawal_restricted<T0, T1>(arg0, arg1, 0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(arg5), arg6, arg7)) {
            return
        };
        let v0 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::liquidity(arg5);
        if (v0 == 0) {
            return
        };
        let v1 = 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::get_early_withdrawal_penalty_percentage(arg1);
        if (v1 == 0) {
            return
        };
        let v2 = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor(v0, (v1 as u128), (0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::get_early_withdrawal_penalty_multiplier() as u128));
        if (v2 == 0) {
            return
        };
        let (v3, v4) = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::remove_liquidity<T0, T1>(arg2, arg3, arg4, arg5, v2, arg6);
        let v5 = v4;
        let v6 = v3;
        let v7 = EventCollectEarlyWithdrawalPenalty{
            gauge_id                 : 0x2::object::id<Gauge<T0, T1>>(arg0),
            position_id              : 0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(arg5),
            early_withdrawal_penalty : v2,
            penalty_amount_a         : 0x2::balance::value<T0>(&v6),
            penalty_amount_b         : 0x2::balance::value<T1>(&v5),
            fee_a                    : 0x2::balance::join<T0>(&mut arg0.fee_a, v6),
            fee_b                    : 0x2::balance::join<T1>(&mut arg0.fee_b, v5),
            timestamp                : 0x2::clock::timestamp_ms(arg6) / 1000,
        };
        0x2::event::emit<EventCollectEarlyWithdrawalPenalty>(v7);
    }

    public(friend) fun create<T0, T1>(arg0: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : Gauge<T0, T1> {
        Gauge<T0, T1>{
            id                        : 0x2::object::new(arg2),
            pool_id                   : arg1,
            gauge_cap                 : 0x1::option::none<0x500636366963eb62bee705e420dacd6e3770447914043d7978deb49372401e::gauge_cap::GaugeCap>(),
            distribution_config       : 0x2::object::id<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig>(arg0),
            staked_positions          : 0x2::object_table::new<0x2::object::ID, 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(arg2),
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
            rewards                   : 0x2::table::new<0x2::object::ID, RewardProfile>(arg2),
            bag                       : 0x2::bag::new(arg2),
        }
    }

    public fun decrease_liquidity<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg3: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg4: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg5: &StakedPosition, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::object::id<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig>(arg1) == arg0.distribution_config, 9223373183611043839);
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg1);
        assert!(!0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::is_gauge_paused(arg1, 0x2::object::id<Gauge<T0, T1>>(arg0)), 252715892968864860);
        assert!(check_gauger_pool<T0, T1>(arg0, arg4), 9223373162136666120);
        assert!(0x2::object_table::contains<0x2::object::ID, 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(&arg0.staked_positions, arg5.position_id), 9223373570158297092);
        assert!(!0x2::table::contains<0x2::object::ID, Locked>(&arg0.locked_positions, arg5.position_id), 922337373443534534);
        assert!(all_rewards_claimed<T0, T1>(arg0, arg4, arg5.position_id, arg7), 51536857596176540);
        let v0 = position_id(arg5);
        let v1 = 0x2::object_table::remove<0x2::object::ID, 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(&mut arg0.staked_positions, arg5.position_id);
        assert!(0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg4) == 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::pool_id(&v1), 9223373162136666120);
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::unstake_from_fullsail_distribution<T0, T1>(arg4, 0x1::option::borrow<0x500636366963eb62bee705e420dacd6e3770447914043d7978deb49372401e::gauge_cap::GaugeCap>(&arg0.gauge_cap), &v1, arg7);
        assert!(arg6 < 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::liquidity(&v1), 9934967927031223221);
        let (v2, v3) = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::remove_liquidity<T0, T1>(arg2, arg3, arg4, &mut v1, arg6, arg7);
        let (v4, v5) = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::tick_range(&v1);
        let v6 = 0x1::option::borrow<0x500636366963eb62bee705e420dacd6e3770447914043d7978deb49372401e::gauge_cap::GaugeCap>(&arg0.gauge_cap);
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::update_fullsail_distribution_growth_global<T0, T1>(arg4, v6, arg7);
        if (!0x2::table::contains<0x2::object::ID, RewardProfile>(&arg0.rewards, v0)) {
            let v7 = RewardProfile{
                growth_inside    : 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::get_fullsail_distribution_growth_inside<T0, T1>(arg4, v4, v5, 0),
                amount           : 0,
                last_update_time : 0x2::clock::timestamp_ms(arg7) / 1000,
            };
            0x2::table::add<0x2::object::ID, RewardProfile>(&mut arg0.rewards, v0, v7);
        } else {
            let v8 = 0x2::table::borrow_mut<0x2::object::ID, RewardProfile>(&mut arg0.rewards, v0);
            v8.growth_inside = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::get_fullsail_distribution_growth_inside<T0, T1>(arg4, v4, v5, 0);
            v8.last_update_time = 0x2::clock::timestamp_ms(arg7) / 1000;
        };
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::stake_in_fullsail_distribution<T0, T1>(arg4, v6, &v1, arg7);
        0x2::object_table::add<0x2::object::ID, 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(&mut arg0.staked_positions, v0, v1);
        (v2, v3)
    }

    public fun deposit_position<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &mut Gauge<T0, T1>, arg3: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg4: 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : StakedPosition {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg1);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::object::id<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig>(arg1) == arg2.distribution_config, 9223373183611043839);
        assert!(0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::is_gauge_alive(arg1, 0x2::object::id<Gauge<T0, T1>>(arg2)), 647757079824953500);
        assert!(!0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::is_gauge_paused(arg1, 0x2::object::id<Gauge<T0, T1>>(arg2)), 543618285971711100);
        assert!(check_gauger_pool<T0, T1>(arg2, arg3), 9223373162136666120);
        assert!(0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::pool_id(&arg4) == 0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg3), 9223373166431764490);
        assert!(0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::liquidity(&arg4) > 0, 9223373172345436343);
        assert!(!0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::is_staked(0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::borrow_position_info(0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::position_manager<T0, T1>(arg3), 0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(&arg4))), 9223373175021174786);
        let (v1, v2) = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::collect_fee<T0, T1>(arg0, arg3, &arg4, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg6), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg6), v0);
        deposit_position_internal<T0, T1>(arg2, arg3, arg4, arg5, arg6)
    }

    public fun deposit_position_by_locker<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &0x6a1e9c271f2723f8de99d929f11961fd00c88a51048cbbcee472c933856703f7::locker_cap::LockerCap, arg3: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg4: 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : StakedPosition {
        assert!(0x2::object::id<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig>(arg1) == arg0.distribution_config, 9223373183611043839);
        assert!(0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::is_gauge_alive(arg1, 0x2::object::id<Gauge<T0, T1>>(arg0)), 647757079824953500);
        assert!(!0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::is_gauge_paused(arg1, 0x2::object::id<Gauge<T0, T1>>(arg0)), 543618285971711100);
        assert!(0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::liquidity(&arg4) > 0, 9223373172345436343);
        assert!(check_gauger_pool<T0, T1>(arg0, arg3), 9223373162136666120);
        assert!(0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::pool_id(&arg4) == 0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg3), 9223373166431764490);
        assert!(!0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::is_staked(0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::borrow_position_info(0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::position_manager<T0, T1>(arg3), 0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(&arg4))), 9223373175021174786);
        deposit_position_internal<T0, T1>(arg0, arg3, arg4, arg5, arg6)
    }

    fun deposit_position_internal<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg2: 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : StakedPosition {
        let v0 = 0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(&arg2);
        assert!(0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg1) == 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::pool_id(&arg2), 9223373162136666120);
        let (v1, v2) = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::tick_range(&arg2);
        let v3 = 0x1::option::borrow<0x500636366963eb62bee705e420dacd6e3770447914043d7978deb49372401e::gauge_cap::GaugeCap>(&arg0.gauge_cap);
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::update_fullsail_distribution_growth_global<T0, T1>(arg1, v3, arg3);
        if (!0x2::table::contains<0x2::object::ID, RewardProfile>(&arg0.rewards, v0)) {
            let v4 = RewardProfile{
                growth_inside    : 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::get_fullsail_distribution_growth_inside<T0, T1>(arg1, v1, v2, 0),
                amount           : 0,
                last_update_time : 0x2::clock::timestamp_ms(arg3) / 1000,
            };
            0x2::table::add<0x2::object::ID, RewardProfile>(&mut arg0.rewards, v0, v4);
        } else {
            let v5 = 0x2::table::borrow_mut<0x2::object::ID, RewardProfile>(&mut arg0.rewards, v0);
            v5.growth_inside = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::get_fullsail_distribution_growth_inside<T0, T1>(arg1, v1, v2, 0);
            v5.last_update_time = 0x2::clock::timestamp_ms(arg3) / 1000;
        };
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::stake_in_fullsail_distribution<T0, T1>(arg1, v3, &arg2, arg3);
        let v6 = StakedPosition{
            id          : 0x2::object::new(arg4),
            position_id : v0,
            pool_id     : 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::pool_id(&arg2),
            description : 0x1::string::utf8(b"Full Sail Staked Liquidity Position"),
            name        : new_staked_position_name(0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::index<T0, T1>(arg1), 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::index(&arg2)),
        };
        0x2::object_table::add<0x2::object::ID, 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(&mut arg0.staked_positions, v0, arg2);
        let v7 = EventDepositGauge{
            gauger_id           : 0x2::object::id<Gauge<T0, T1>>(arg0),
            pool_id             : 0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg1),
            position_id         : v0,
            staked_position_id  : 0x2::object::id<StakedPosition>(&v6),
            start_growth_inside : 0x2::table::borrow<0x2::object::ID, RewardProfile>(&arg0.rewards, v0).growth_inside,
        };
        0x2::event::emit<EventDepositGauge>(v7);
        v6
    }

    public fun description(arg0: &StakedPosition) : 0x1::string::String {
        arg0.description
    }

    fun destroy_staked_positions(arg0: StakedPosition) {
        let StakedPosition {
            id          : v0,
            position_id : _,
            pool_id     : _,
            description : _,
            name        : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun earned<T0, T1>(arg0: &Gauge<T0, T1>, arg1: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : u64 {
        assert!(check_gauger_pool<T0, T1>(arg0, arg1), 9223372693985230856);
        if (!0x2::object_table::contains<0x2::object::ID, 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(&arg0.staked_positions, arg2)) {
            return 0
        };
        let (v0, _) = earned_internal<T0, T1>(arg0, arg1, arg2, 0x2::clock::timestamp_ms(arg3) / 1000);
        v0
    }

    fun earned_internal<T0, T1>(arg0: &Gauge<T0, T1>, arg1: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: u64) : (u64, u128) {
        let v0 = 0x2::object_table::borrow<0x2::object::ID, 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(&arg0.staked_positions, arg2);
        let (v1, v2) = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::tick_range(v0);
        let v3 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::get_fullsail_distribution_growth_inside<T0, T1>(arg1, v1, v2, get_current_growth_global<T0, T1>(arg0, arg1, arg3));
        let v4 = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::math_u128::wrapping_sub(v3, 0x2::table::borrow<0x2::object::ID, RewardProfile>(&arg0.rewards, arg2).growth_inside);
        if (0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::math_u128::is_neg(v4)) {
            return (0, v3)
        };
        ((0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor(v4, 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::liquidity(v0), 18446744073709551616) as u64), v3)
    }

    public fun full_earned_for_type<T0, T1, T2>(arg0: &Gauge<T0, T1>, arg1: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: u128, arg4: &0x2::clock::Clock) : (u64, u128) {
        assert!(check_gauger_pool<T0, T1>(arg0, arg1), 266845958013316900);
        assert!(0x2::object_table::contains<0x2::object::ID, 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(&arg0.staked_positions, arg2), 9223372698279936004);
        0x1::type_name::get<T2>();
        if (is_valid_epoch_token<T0, T1, T2>(arg0)) {
            let v0 = 0x2::object_table::borrow<0x2::object::ID, 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(&arg0.staked_positions, arg2);
            let (v1, v2) = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::tick_range(v0);
            let v3 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::get_fullsail_distribution_growth_inside<T0, T1>(arg1, v1, v2, get_current_growth_global<T0, T1>(arg0, arg1, 0x2::clock::timestamp_ms(arg4) / 1000));
            let v4 = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::math_u128::wrapping_sub(v3, arg3);
            if (0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::math_u128::is_neg(v4)) {
                return (0, v3)
            };
            return ((0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor(v4, 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::liquidity(v0), 18446744073709551616) as u64), v3)
        };
        (0, 0)
    }

    public fun get_current_growth_global<T0, T1>(arg0: &Gauge<T0, T1>, arg1: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg2: u64) : u128 {
        assert!(check_gauger_pool<T0, T1>(arg0, arg1), 319134756481074050);
        let v0 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::get_fullsail_distribution_growth_global<T0, T1>(arg1);
        let v1 = v0;
        let v2 = arg2 - 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::get_fullsail_distribution_last_updated<T0, T1>(arg1);
        let v3 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::get_fullsail_distribution_staked_liquidity<T0, T1>(arg1);
        let v4 = (0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::get_fullsail_distribution_reserve<T0, T1>(arg1) as u128) * 18446744073709551616;
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
            v1 = v0 + 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::math_u128::checked_div_round(v7, v3, false);
        };
        v1
    }

    public fun get_current_growth_inside<T0, T1>(arg0: &Gauge<T0, T1>, arg1: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: u64) : u128 {
        assert!(check_gauger_pool<T0, T1>(arg0, arg1), 9223372693985230856);
        assert!(0x2::object_table::contains<0x2::object::ID, 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(&arg0.staked_positions, arg2), 9223372698279936004);
        let (v0, v1) = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::tick_range(0x2::object_table::borrow<0x2::object::ID, 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(&arg0.staked_positions, arg2));
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::get_fullsail_distribution_growth_inside<T0, T1>(arg1, v0, v1, get_current_growth_global<T0, T1>(arg0, arg1, arg3))
    }

    public fun get_pool_reward<T0, T1, T2>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg2: &mut Gauge<T0, T1>, arg3: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg4: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg5: &StakedPosition, arg6: &0x2::clock::Clock) : 0x2::balance::Balance<T2> {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg3);
        assert!(!0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::is_gauge_paused(arg3, 0x2::object::id<Gauge<T0, T1>>(arg2)), 266213185215138140);
        assert!(check_gauger_pool<T0, T1>(arg2, arg4), 73727195005154130);
        let v0 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::collect_reward<T0, T1, T2>(arg0, arg4, 0x2::object_table::borrow<0x2::object::ID, 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(&arg2.staked_positions, arg5.position_id), arg1, true, arg6);
        let v1 = 0x2::balance::value<T2>(&v0);
        if (0x2::table::borrow<0x2::object::ID, RewardProfile>(&arg2.rewards, arg5.position_id).last_update_time > 0x2::clock::timestamp_ms(arg6) / 1000 - 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::get_liquidity_update_cooldown(arg3) && v1 > 0) {
            0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::deposit_reward<T2>(arg0, arg1, v0);
            let v2 = EventPoolRewardRedeposited{
                gauge_id           : 0x2::object::id<Gauge<T0, T1>>(arg2),
                pool_id            : 0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg4),
                position_id        : arg5.position_id,
                staked_position_id : 0x2::object::id<StakedPosition>(arg5),
                reward_token       : 0x1::type_name::get<T2>(),
                amount             : v1,
            };
            0x2::event::emit<EventPoolRewardRedeposited>(v2);
            return 0x2::balance::zero<T2>()
        };
        v0
    }

    public fun get_pool_reward_v2<T0, T1, T2>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg2: &mut Gauge<T0, T1>, arg3: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg4: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg5: &StakedPosition, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg3);
        assert!(check_gauger_pool<T0, T1>(arg2, arg4), 73727195005154130);
        if (is_withdrawal_restricted<T0, T1>(arg2, arg3, position_id(arg5), arg6, arg7)) {
            0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::deposit_reward<T2>(arg0, arg1, 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::collect_reward<T0, T1, T2>(arg0, arg4, 0x2::object_table::borrow<0x2::object::ID, 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(&arg2.staked_positions, arg5.position_id), arg1, true, arg6));
            return 0x2::balance::zero<T2>()
        };
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::collect_reward<T0, T1, T2>(arg0, arg4, 0x2::object_table::borrow<0x2::object::ID, 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(&arg2.staked_positions, arg5.position_id), arg1, true, arg6)
    }

    public fun get_unclaimed_o_sail<T0, T1>(arg0: &Gauge<T0, T1>) : u64 {
        if (0x2::bag::contains<vector<u8>>(&arg0.bag, b"unclaimed_o_sail")) {
            *0x2::bag::borrow<vector<u8>, u64>(&arg0.bag, b"unclaimed_o_sail")
        } else {
            0
        }
    }

    fun init(arg0: GAUGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<GAUGE>(arg0, arg1);
        let v1 = update_display(&v0, 0x1::string::utf8(b"{name}"), 0x1::string::utf8(b"https://app.fullsail.finance/liquidity/{pool_id}/positions/{position_id}"), 0x1::string::utf8(b"https://app.fullsail.finance/static_files/staked_position.png"), 0x1::string::utf8(b"{description}"), 0x1::string::utf8(b"https://app.fullsail.finance"), 0x1::string::utf8(b"FULLSAIL"), arg1);
        0x2::transfer::public_transfer<0x2::display::Display<StakedPosition>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_valid_epoch_token<T0, T1, T2>(arg0: &Gauge<T0, T1>) : bool {
        let v0 = 0x1::type_name::get<T2>();
        0x1::option::borrow<0x1::type_name::TypeName>(&arg0.current_epoch_token) == &v0
    }

    public fun is_withdrawal_restricted<T0, T1>(arg0: &Gauge<T0, T1>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::table::borrow<0x2::object::ID, RewardProfile>(&arg0.rewards, arg2);
        !0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::contains_unrestricted_address(arg1, 0x2::tx_context::sender(arg4)) && v0.last_update_time > 0x2::clock::timestamp_ms(arg3) / 1000 - 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::get_liquidity_update_cooldown(arg1)
    }

    public fun lock_position<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &0x6a1e9c271f2723f8de99d929f11961fd00c88a51048cbbcee472c933856703f7::locker_cap::LockerCap, arg2: 0x2::object::ID) {
        if (!0x2::table::contains<0x2::object::ID, Locked>(&arg0.locked_positions, arg2)) {
            let v0 = Locked{dummy_field: false};
            0x2::table::add<0x2::object::ID, Locked>(&mut arg0.locked_positions, arg2, v0);
        };
    }

    public fun name(arg0: &StakedPosition) : 0x1::string::String {
        arg0.name
    }

    fun new_staked_position_name(arg0: u64, arg1: u64) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"Fullsail Staked Position:");
        0x1::string::append(&mut v0, 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::utils::str(arg0));
        0x1::string::append_utf8(&mut v0, b"-");
        0x1::string::append(&mut v0, 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::utils::str(arg1));
        v0
    }

    public fun notices() : (vector<u8>, vector<u8>) {
        (x"c2a92032303235204d65746162797465204c6162732c20496e632e2020416c6c205269676874732052657365727665642e", b"Patent pending - U.S. Patent Application No. 63/861,982")
    }

    public fun notify_epoch_token<T0, T1, T2>(arg0: &mut Gauge<T0, T1>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter_cap::VoterCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        validate_voter_cap<T0, T1>(arg0, arg3);
        assert!(check_gauger_pool<T0, T1>(arg0, arg2), 4672810119034640000);
        assert!(0x2::object::id<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig>(arg1) == arg0.distribution_config, 218800936909496100);
        assert!(0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::is_gauge_alive(arg1, 0x2::object::id<Gauge<T0, T1>>(arg0)), 213816814886850880);
        assert!(!0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::is_gauge_paused(arg1, 0x2::object::id<Gauge<T0, T1>>(arg0)), 976193917387744300);
        assert!(0x1::option::is_none<0x1::type_name::TypeName>(&arg0.current_epoch_token) || !is_valid_epoch_token<T0, T1, T2>(arg0), 4041460742273430500);
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        assert!(v0 >= arg0.period_finish, 4159845750300726000);
        assert!(v0 >= 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::to_period(arg0.epoch_token_last_notified) + 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::epoch(), 776925370166021200);
        let (v1, v2) = update_o_sail_distribution<T0, T1>(arg0, arg2, arg4);
        assert!(v2 == 0, 3254849085073565700);
        arg0.usd_reward_rate = 0;
        arg0.o_sail_reward_rate = 0;
        arg0.period_finish = 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::epoch_next(v0);
        let v3 = 0x1::type_name::get<T2>();
        let v4 = EventNotifyEpochToken{
            sender                   : 0x2::object::id_from_address(0x2::tx_context::sender(arg5)),
            gauge_id                 : 0x2::object::id<Gauge<T0, T1>>(arg0),
            pool_id                  : 0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg2),
            token                    : v3,
            prev_token               : 0x1::option::none<0x1::type_name::TypeName>(),
            growth_global_prev_token : 0,
        };
        if (0x1::option::is_some<0x1::type_name::TypeName>(&arg0.current_epoch_token)) {
            0x1::option::fill<0x1::type_name::TypeName>(&mut v4.prev_token, 0x1::option::extract<0x1::type_name::TypeName>(&mut arg0.current_epoch_token));
            v4.growth_global_prev_token = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::get_fullsail_distribution_growth_global<T0, T1>(arg2);
        };
        0x1::option::fill<0x1::type_name::TypeName>(&mut arg0.current_epoch_token, v3);
        arg0.epoch_token_last_notified = v0;
        0x2::event::emit<EventNotifyEpochToken>(v4);
        v1
    }

    public(friend) fun notify_reward<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::object::id<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig>(arg1) == arg0.distribution_config, 311080855434061200);
        assert!(0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::is_gauge_alive(arg1, 0x2::object::id<Gauge<T0, T1>>(arg0)), 927999301192928000);
        assert!(!0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::is_gauge_paused(arg1, 0x2::object::id<Gauge<T0, T1>>(arg0)), 754601601697991000);
        assert!(check_gauger_pool<T0, T1>(arg0, arg2), 5832633373805671000);
        assert!(arg3 > 0, 9223373716188102674);
        assert!(0x2::clock::timestamp_ms(arg5) / 1000 < arg0.period_finish, 256780623436252400);
        let (v0, v1) = claim_fees_internal<T0, T1>(arg0, arg2);
        notify_reward_amount_internal<T0, T1>(arg0, arg3, arg5);
        sync_o_sail_distribution_price_internal<T0, T1>(arg0, arg2, arg4, arg5);
        (v0, v1)
    }

    fun notify_reward_amount_internal<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let (v1, v2) = calc_future_rewards<T0, T1>(arg0, v0);
        arg0.usd_reward_rate = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor((arg1 as u128) + (v1 as u128), 18446744073709551616, (v2 as u128));
        if (0x2::table::contains<u64, u128>(&arg0.usd_reward_rate_by_epoch, 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::epoch_start(v0))) {
            0x2::table::remove<u64, u128>(&mut arg0.usd_reward_rate_by_epoch, 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::epoch_start(v0));
        };
        0x2::table::add<u64, u128>(&mut arg0.usd_reward_rate_by_epoch, 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::epoch_start(v0), arg0.usd_reward_rate);
        assert!(arg0.usd_reward_rate != 0, 9223373952411435028);
        let v3 = EventNotifyReward{
            sender     : *0x1::option::borrow<0x2::object::ID>(&arg0.voter),
            usd_amount : arg1,
        };
        0x2::event::emit<EventNotifyReward>(v3);
    }

    public(friend) fun notify_reward_without_claim<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig>(arg1) == arg0.distribution_config, 921517595696832600);
        assert!(0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::is_gauge_alive(arg1, 0x2::object::id<Gauge<T0, T1>>(arg0)), 388157577581832000);
        assert!(!0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::is_gauge_paused(arg1, 0x2::object::id<Gauge<T0, T1>>(arg0)), 689128363966604200);
        assert!(check_gauger_pool<T0, T1>(arg0, arg2), 6794499896215460000);
        assert!(arg3 > 0, 9223373819267317778);
        assert!(0x2::clock::timestamp_ms(arg5) / 1000 < arg0.period_finish, 256780623436252400);
        notify_reward_amount_internal<T0, T1>(arg0, arg3, arg5);
        sync_o_sail_distribution_price_internal<T0, T1>(arg0, arg2, arg4, arg5);
    }

    public(friend) fun null_rewards<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::object::id<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig>(arg1) == arg0.distribution_config, 803388616803070000);
        assert!(check_gauger_pool<T0, T1>(arg0, arg2), 119295864650511570);
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        assert!(v0 < arg0.period_finish, 453228670707964700);
        let (v1, _) = calc_future_rewards<T0, T1>(arg0, v0);
        arg0.usd_reward_rate = 0;
        sync_o_sail_distribution_price_internal<T0, T1>(arg0, arg2, arg3, arg4);
        let v3 = EventNullRewards{
            gauge_id           : 0x2::object::id<Gauge<T0, T1>>(arg0),
            pool_id            : 0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg2),
            rewards_nulled_usd : v1,
        };
        0x2::event::emit<EventNullRewards>(v3);
        v1
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

    public fun position_id(arg0: &StakedPosition) : 0x2::object::ID {
        arg0.position_id
    }

    public fun position_index<T0, T1>(arg0: &Gauge<T0, T1>, arg1: &StakedPosition) : u64 {
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::index(0x2::object_table::borrow<0x2::object::ID, 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(&arg0.staked_positions, arg1.position_id))
    }

    public fun position_liquidity<T0, T1>(arg0: &Gauge<T0, T1>, arg1: &StakedPosition) : u128 {
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::liquidity(0x2::object_table::borrow<0x2::object::ID, 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(&arg0.staked_positions, arg1.position_id))
    }

    public fun position_tick_range<T0, T1>(arg0: &Gauge<T0, T1>, arg1: &StakedPosition) : (0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32) {
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::tick_range(0x2::object_table::borrow<0x2::object::ID, 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(&arg0.staked_positions, arg1.position_id))
    }

    public(friend) fun receive_gauge_cap<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: 0x500636366963eb62bee705e420dacd6e3770447914043d7978deb49372401e::gauge_cap::GaugeCap) {
        assert!(arg0.pool_id == 0x500636366963eb62bee705e420dacd6e3770447914043d7978deb49372401e::gauge_cap::get_pool_id(&arg1), 9223373119186534399);
        0x1::option::fill<0x500636366963eb62bee705e420dacd6e3770447914043d7978deb49372401e::gauge_cap::GaugeCap>(&mut arg0.gauge_cap, arg1);
    }

    public(friend) fun remove_unclaimed_o_sail<T0, T1>(arg0: &mut Gauge<T0, T1>) : u64 {
        let v0 = if (0x2::bag::contains<vector<u8>>(&arg0.bag, b"unclaimed_o_sail")) {
            0x2::bag::remove<vector<u8>, u64>(&mut arg0.bag, b"unclaimed_o_sail")
        } else {
            0
        };
        let v1 = EventRemoveUnclaimedOsail{
            gauge_id : 0x2::object::id<Gauge<T0, T1>>(arg0),
            amount   : v0,
        };
        0x2::event::emit<EventRemoveUnclaimedOsail>(v1);
        v0
    }

    public fun set_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<GAUGE>(arg0), 9843325239567326443);
        let v0 = update_display(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::display::Display<StakedPosition>>(v0, 0x2::tx_context::sender(arg7));
    }

    public(friend) fun set_voter<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: 0x2::object::ID) {
        0x1::option::fill<0x2::object::ID>(&mut arg0.voter, arg1);
        let v0 = EventGaugeSetVoter{
            id       : 0x2::object::id<Gauge<T0, T1>>(arg0),
            voter_id : arg1,
        };
        0x2::event::emit<EventGaugeSetVoter>(v0);
    }

    public(friend) fun sync_o_sail_distribution_finish<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock) : u64 {
        let (v0, v1) = update_o_sail_distribution<T0, T1>(arg0, arg1, arg2);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 >= arg0.period_finish, 905941490554673900);
        assert!(v1 == 0, 877996288127818900);
        arg0.usd_reward_rate = 0;
        arg0.o_sail_reward_rate = 0;
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::sync_fullsail_distribution_reward<T0, T1>(arg1, 0x1::option::borrow<0x500636366963eb62bee705e420dacd6e3770447914043d7978deb49372401e::gauge_cap::GaugeCap>(&arg0.gauge_cap), 0, 0, arg0.period_finish, arg2);
        let v2 = EventSyncOSailDistributionFinish{
            gauge_id           : 0x2::object::id<Gauge<T0, T1>>(arg0),
            pool_id            : 0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg1),
            period_finish      : arg0.period_finish,
            usd_reward_rate    : 0,
            o_sail_reward_rate : 0,
        };
        0x2::event::emit<EventSyncOSailDistributionFinish>(v2);
        v0
    }

    public(friend) fun sync_o_sail_distribution_price<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: u128, arg4: &0x2::clock::Clock) {
        assert!(0x2::object::id<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig>(arg1) == arg0.distribution_config, 490749102979896500);
        assert!(!0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::is_gauge_paused(arg1, 0x2::object::id<Gauge<T0, T1>>(arg0)), 613016774975398800);
        assert!(check_gauger_pool<T0, T1>(arg0, arg2), 485510326827034900);
        sync_o_sail_distribution_price_internal<T0, T1>(arg0, arg2, arg3, arg4);
    }

    fun sync_o_sail_distribution_price_internal<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg2: u128, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        assert!(v0 < arg0.period_finish, 524842288068695600);
        let (_, _) = update_o_sail_distribution<T0, T1>(arg0, arg1, arg3);
        let v3 = 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::epoch_next(v0);
        let v4 = v3 - v0;
        let v5 = arg0.usd_reward_rate * (v4 as u128);
        let v6 = 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::usd_q64_to_asset_q64(v5, arg2);
        let v7 = v6 / (v4 as u128);
        let v8 = ((v6 >> 64) as u64);
        arg0.o_sail_reward_rate = v7;
        arg0.last_distribution_reserve = v8;
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::sync_fullsail_distribution_reward<T0, T1>(arg1, 0x1::option::borrow<0x500636366963eb62bee705e420dacd6e3770447914043d7978deb49372401e::gauge_cap::GaugeCap>(&arg0.gauge_cap), v7, v8, v3, arg3);
        let v9 = EventSyncOSailDistributionPrice{
            gauge_id             : 0x2::object::id<Gauge<T0, T1>>(arg0),
            pool_id              : 0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg1),
            price_q64            : arg2,
            remaining_o_sail_q64 : v6,
            remaining_usd_q64    : v5,
        };
        0x2::event::emit<EventSyncOSailDistributionPrice>(v9);
    }

    public fun unlock_position<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &0x6a1e9c271f2723f8de99d929f11961fd00c88a51048cbbcee472c933856703f7::locker_cap::LockerCap, arg2: 0x2::object::ID) {
        if (0x2::table::contains<0x2::object::ID, Locked>(&arg0.locked_positions, arg2)) {
            0x2::table::remove<0x2::object::ID, Locked>(&mut arg0.locked_positions, arg2);
        };
    }

    fun update_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<StakedPosition> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"creator"));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg1);
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg2);
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg3);
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg4);
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg5);
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg6);
        let v2 = 0x2::display::new_with_fields<StakedPosition>(arg0, v0, v1, arg7);
        0x2::display::update_version<StakedPosition>(&mut v2);
        v2
    }

    public(friend) fun update_o_sail_distribution<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::to_period(arg0.epoch_token_last_notified);
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::update_fullsail_distribution_growth_global<T0, T1>(arg1, 0x1::option::borrow<0x500636366963eb62bee705e420dacd6e3770447914043d7978deb49372401e::gauge_cap::GaugeCap>(&arg0.gauge_cap), arg2);
        let v1 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::get_fullsail_distribution_reserve<T0, T1>(arg1);
        let v2 = if (0x2::table::contains<u64, u64>(&arg0.o_sail_emission_by_epoch, v0)) {
            0x2::table::remove<u64, u64>(&mut arg0.o_sail_emission_by_epoch, v0)
        } else {
            0
        };
        let v3 = v2;
        if (arg0.last_distribution_reserve > 0) {
            v3 = v2 + arg0.last_distribution_reserve - v1;
        };
        0x2::table::add<u64, u64>(&mut arg0.o_sail_emission_by_epoch, v0, v3);
        arg0.last_distribution_reserve = v1;
        let v4 = EventUpdateOsailDistribution{
            gauge_id                    : 0x2::object::id<Gauge<T0, T1>>(arg0),
            pool_id                     : 0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg1),
            epoch_start                 : v0,
            o_sail_emission             : v3,
            o_sail_distribution_reserve : v1,
        };
        0x2::event::emit<EventUpdateOsailDistribution>(v4);
        (v3, v1)
    }

    public(friend) fun update_reward_internal<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : (u64, u128) {
        assert!(check_gauger_pool<T0, T1>(arg0, arg2), 922337345419444224);
        let (v0, v1) = earned_internal<T0, T1>(arg0, arg2, arg3, 0x2::clock::timestamp_ms(arg4) / 1000);
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, RewardProfile>(&mut arg0.rewards, arg3);
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::update_fullsail_distribution_growth_global<T0, T1>(arg2, 0x1::option::borrow<0x500636366963eb62bee705e420dacd6e3770447914043d7978deb49372401e::gauge_cap::GaugeCap>(&arg0.gauge_cap), arg4);
        v2.amount = v2.amount + v0;
        let v3 = v2.amount;
        v2.growth_inside = v1;
        let v4 = EventUpdateRewardPosition{
            gauger_id     : 0x2::object::id<Gauge<T0, T1>>(arg0),
            pool_id       : 0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg2),
            position_id   : arg3,
            growth_inside : v2.growth_inside,
            amount        : v2.amount,
        };
        0x2::event::emit<EventUpdateRewardPosition>(v4);
        if (is_withdrawal_restricted<T0, T1>(arg0, arg1, arg3, arg4, arg5)) {
            return (0, v1)
        };
        v2.amount = 0;
        (v3, v1)
    }

    public fun usd_reward_rate<T0, T1>(arg0: &Gauge<T0, T1>) : u128 {
        arg0.usd_reward_rate
    }

    public fun usd_reward_rate_by_epoch_start<T0, T1>(arg0: &Gauge<T0, T1>, arg1: u64) : u128 {
        *0x2::table::borrow<u64, u128>(&arg0.usd_reward_rate_by_epoch, arg1)
    }

    fun validate_voter_cap<T0, T1>(arg0: &Gauge<T0, T1>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter_cap::VoterCap) {
        let v0 = 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter_cap::get_voter_id(arg1);
        assert!(&v0 == 0x1::option::borrow<0x2::object::ID>(&arg0.voter), 922337365605842945);
    }

    public fun withdraw_position<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: StakedPosition, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position {
        abort 13906841286809223167
    }

    public fun withdraw_position_by_locker<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &0x6a1e9c271f2723f8de99d929f11961fd00c88a51048cbbcee472c933856703f7::locker_cap::LockerCap, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: StakedPosition, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position {
        abort 0
    }

    fun withdraw_position_internal<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg4: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg5: StakedPosition, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position {
        assert!(check_gauger_pool<T0, T1>(arg0, arg1), 496532944256373500);
        assert!(all_rewards_claimed<T0, T1>(arg0, arg1, arg5.position_id, arg6), 51536857596176540);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, RewardProfile>(&mut arg0.rewards, arg5.position_id);
        if (v0.amount > 0) {
            add_unclaimed_o_sail<T0, T1>(arg0, v0.amount);
        };
        let v1 = 0x2::object_table::remove<0x2::object::ID, 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(&mut arg0.staked_positions, arg5.position_id);
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::unstake_from_fullsail_distribution<T0, T1>(arg1, 0x1::option::borrow<0x500636366963eb62bee705e420dacd6e3770447914043d7978deb49372401e::gauge_cap::GaugeCap>(&arg0.gauge_cap), &v1, arg6);
        destroy_staked_positions(arg5);
        let v2 = &mut v1;
        collect_early_withdrawal_penalty<T0, T1>(arg0, arg2, arg3, arg4, arg1, v2, arg6, arg7);
        let v3 = EventWithdrawPosition{
            staked_position_id : 0x2::object::id<StakedPosition>(&arg5),
            position_id        : 0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(&v1),
            gauger_id          : 0x2::object::id<Gauge<T0, T1>>(arg0),
            pool_id            : 0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg1),
        };
        0x2::event::emit<EventWithdrawPosition>(v3);
        v1
    }

    public fun withdraw_position_v2<T0, T1>(arg0: &mut Gauge<T0, T1>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg3: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg4: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg5: StakedPosition, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg1);
        assert!(check_gauger_pool<T0, T1>(arg0, arg4), 922337345419444224);
        assert!(!0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::is_gauge_paused(arg1, 0x2::object::id<Gauge<T0, T1>>(arg0)), 568694560355628600);
        assert!(0x2::object_table::contains<0x2::object::ID, 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(&arg0.staked_positions, arg5.position_id), 9223373570158297092);
        assert!(!0x2::table::contains<0x2::object::ID, Locked>(&arg0.locked_positions, arg5.position_id), 922337373443534534);
        withdraw_position_internal<T0, T1>(arg0, arg4, arg1, arg2, arg3, arg5, arg6, arg7)
    }

    // decompiled from Move bytecode v6
}

