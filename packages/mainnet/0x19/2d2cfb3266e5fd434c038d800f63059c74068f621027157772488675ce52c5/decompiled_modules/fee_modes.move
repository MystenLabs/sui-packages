module 0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::fee_modes {
    struct StateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct State has store {
        buyback: 0x2::balance::Balance<0x2::sui::SUI>,
        last_buyback_ms: u64,
        total_buyback_sui: u64,
        total_burned: u64,
        rewards: 0x2::balance::Balance<0x2::sui::SUI>,
        total_staked: u64,
        acc_per_token: u256,
        total_rewards: u64,
    }

    struct Stake<phantom T0> has store, key {
        id: 0x2::object::UID,
        curve_id: 0x2::object::ID,
        tokens: 0x2::balance::Balance<T0>,
        reward_debt: u256,
    }

    struct FeesDistributed has copy, drop {
        curve_id: 0x2::object::ID,
        creator: u64,
        buyback: u64,
        holders: u64,
    }

    struct BuybackExecuted has copy, drop {
        curve_id: 0x2::object::ID,
        venue: u8,
        sui_spent: u64,
        tokens_burned: u64,
        caller_reward: u64,
        timestamp_ms: u64,
    }

    struct Staked has copy, drop {
        curve_id: 0x2::object::ID,
        stake_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        total_staked: u64,
    }

    struct Unstaked has copy, drop {
        curve_id: 0x2::object::ID,
        stake_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        total_staked: u64,
    }

    struct RewardsClaimed has copy, drop {
        curve_id: 0x2::object::ID,
        stake_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct CreatorClaimed has copy, drop {
        curve_id: 0x2::object::ID,
        creator: address,
        amount: u64,
    }

    public fun add_stake<T0>(arg0: &mut 0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::Curve<T0>, arg1: &0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::config::Config, arg2: &mut Stake<T0>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 606);
        let v1 = claim_rewards<T0>(arg0, arg1, arg2, arg4);
        let v2 = 0x2::object::id<0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::Curve<T0>>(arg0);
        let v3 = state_mut<T0>(arg0);
        v3.total_staked = v3.total_staked + v0;
        0x2::balance::join<T0>(&mut arg2.tokens, 0x2::coin::into_balance<T0>(arg3));
        arg2.reward_debt = (0x2::balance::value<T0>(&arg2.tokens) as u256) * v3.acc_per_token;
        let v4 = Staked{
            curve_id     : v2,
            stake_id     : 0x2::object::id<Stake<T0>>(arg2),
            owner        : 0x2::tx_context::sender(arg4),
            amount       : v0,
            total_staked : v3.total_staked,
        };
        0x2::event::emit<Staked>(v4);
        v1
    }

    public fun buyback_interval_ms() : u64 {
        60000
    }

    public fun buyback_on_cetus<T0>(arg0: &mut 0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::Curve<T0>, arg1: &0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::config::Config, arg2: &0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::graduation::TokenVault<T0>, arg3: &mut 0x2::coin_registry::Currency<T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::config::assert_version(arg1);
        assert!(0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::is_graduated<T0>(arg0), 609);
        assert!(0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::graduation::curve_id<T0>(arg2) == 0x2::object::id<0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::Curve<T0>>(arg0), 605);
        assert!(0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::graduation::pool_id<T0>(arg2) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg5), 608);
        distribute_internal<T0>(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = take_buyback_chunk<T0>(arg0, 18446744073709551615, v0);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&v1);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0x2::sui::SUI>(arg5);
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg4, arg5, false, true, v2 - 0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::math::mul_div(v2, 50, 10000), v3 + v3 * 25 / (10000 as u128), arg6);
        let v7 = v6;
        let v8 = v4;
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v7);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg4, arg5, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(&mut v1, v9), v7);
        let v10 = 0x1::u64::min(0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::math::mul_div(v9, 50, 10000), 0x2::balance::value<0x2::sui::SUI>(&v1));
        if (v10 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1, v10), arg7), 0x2::tx_context::sender(arg7));
        };
        0x2::balance::destroy_zero<0x2::sui::SUI>(v5);
        0x2::balance::join<T0>(&mut v8, 0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::take_tokens_to_burn<T0>(arg0));
        0x2::coin_registry::burn_balance<T0>(arg3, v8);
        assert!(0x2::balance::value<T0>(&v8) > 0, 604);
        finish_buyback<T0>(arg0, v1, v2 - v10, 0x2::balance::value<T0>(&v8), v10, 1, v0);
    }

    public fun buyback_on_curve<T0>(arg0: &mut 0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::Curve<T0>, arg1: &0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::config::Config, arg2: &mut 0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::config::Treasury, arg3: &mut 0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::referral::Registry, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::config::assert_version(arg1);
        assert!(!0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::config::is_sell_only(arg1), 607);
        distribute_internal<T0>(arg0);
        let (v0, _) = 0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::reserves<T0>(arg0);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        let v3 = take_buyback_chunk<T0>(arg0, 0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::math::mul_div(v0, 50, 10000), v2);
        let v4 = &mut v3;
        let (v5, v6) = 0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::buyback_buy<T0>(arg0, arg2, arg3, v3, arg4);
        finish_buyback<T0>(arg0, v5, 0x2::balance::value<0x2::sui::SUI>(&v3), v6, take_reward(v4, arg5), 0, v2);
    }

    public fun buyback_stats<T0>(arg0: &0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::Curve<T0>) : (u64, u64, u64, u64) {
        let v0 = StateKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<StateKey, State>(0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::uid<T0>(arg0), v0)) {
            return (0, 0, 0, 0)
        };
        let v1 = StateKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<StateKey, State>(0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::uid<T0>(arg0), v1);
        (0x2::balance::value<0x2::sui::SUI>(&v2.buyback), v2.total_buyback_sui, v2.total_burned, v2.last_buyback_ms)
    }

    public fun claim_creator<T0>(arg0: &mut 0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::Curve<T0>, arg1: &0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::config::Config, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::config::assert_version(arg1);
        assert!(0x2::tx_context::sender(arg2) == 0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::creator<T0>(arg0), 601);
        distribute_internal<T0>(arg0);
        let v0 = 0x2::balance::withdraw_all<0x2::sui::SUI>(0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::creator_claim_mut<T0>(arg0));
        let v1 = CreatorClaimed{
            curve_id : 0x2::object::id<0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::Curve<T0>>(arg0),
            creator  : 0x2::tx_context::sender(arg2),
            amount   : 0x2::balance::value<0x2::sui::SUI>(&v0),
        };
        0x2::event::emit<CreatorClaimed>(v1);
        0x2::coin::from_balance<0x2::sui::SUI>(v0, arg2)
    }

    public fun claim_rewards<T0>(arg0: &mut 0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::Curve<T0>, arg1: &0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::config::Config, arg2: &mut Stake<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::config::assert_version(arg1);
        assert!(arg2.curve_id == 0x2::object::id<0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::Curve<T0>>(arg0), 605);
        distribute_internal<T0>(arg0);
        let v0 = 0x2::object::id<0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::Curve<T0>>(arg0);
        let v1 = state_mut<T0>(arg0);
        let v2 = (0x2::balance::value<T0>(&arg2.tokens) as u256) * v1.acc_per_token;
        arg2.reward_debt = v2;
        let v3 = 0x1::u64::min((((v2 - arg2.reward_debt) / 1000000000000000000) as u64), 0x2::balance::value<0x2::sui::SUI>(&v1.rewards));
        if (v3 > 0) {
            let v4 = RewardsClaimed{
                curve_id : v0,
                stake_id : 0x2::object::id<Stake<T0>>(arg2),
                owner    : 0x2::tx_context::sender(arg3),
                amount   : v3,
            };
            0x2::event::emit<RewardsClaimed>(v4);
        };
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1.rewards, v3), arg3)
    }

    public fun curve_chunk_bps() : u64 {
        50
    }

    public fun distribute<T0>(arg0: &mut 0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::Curve<T0>, arg1: &0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::config::Config) {
        0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::config::assert_version(arg1);
        distribute_internal<T0>(arg0);
    }

    fun distribute_internal<T0>(arg0: &mut 0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::Curve<T0>) {
        assert!(0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::has_fee_mode<T0>(arg0), 600);
        ensure_state<T0>(arg0);
        let v0 = 0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::take_creator_fees<T0>(arg0);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
            return
        };
        let (_, v3, v4) = 0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::fee_mode<T0>(arg0);
        let v5 = 0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::math::mul_div(v1, v3, 10000);
        let v6 = v5;
        let v7 = 0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::math::mul_div(v1, v4, 10000);
        let v8 = 0x2::object::id<0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::Curve<T0>>(arg0);
        let v9 = state_mut<T0>(arg0);
        let v10 = 0;
        if (v7 > 0) {
            if (v9.total_staked > 0) {
                v9.acc_per_token = v9.acc_per_token + (v7 as u256) * 1000000000000000000 / (v9.total_staked as u256);
                0x2::balance::join<0x2::sui::SUI>(&mut v9.rewards, 0x2::balance::split<0x2::sui::SUI>(&mut v0, v7));
                v9.total_rewards = v9.total_rewards + v7;
                v10 = v7;
            } else {
                v6 = v5 + v7;
            };
        };
        0x2::balance::join<0x2::sui::SUI>(&mut v9.buyback, 0x2::balance::split<0x2::sui::SUI>(&mut v0, v6));
        0x2::balance::join<0x2::sui::SUI>(0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::creator_claim_mut<T0>(arg0), v0);
        let v11 = FeesDistributed{
            curve_id : v8,
            creator  : 0x2::balance::value<0x2::sui::SUI>(&v0),
            buyback  : v6,
            holders  : v10,
        };
        0x2::event::emit<FeesDistributed>(v11);
    }

    fun ensure_state<T0>(arg0: &mut 0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::Curve<T0>) {
        let v0 = StateKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<StateKey, State>(0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::uid<T0>(arg0), v0)) {
            return
        };
        let v1 = StateKey{dummy_field: false};
        let v2 = State{
            buyback           : 0x2::balance::zero<0x2::sui::SUI>(),
            last_buyback_ms   : 0,
            total_buyback_sui : 0,
            total_burned      : 0,
            rewards           : 0x2::balance::zero<0x2::sui::SUI>(),
            total_staked      : 0,
            acc_per_token     : 0,
            total_rewards     : 0,
        };
        0x2::dynamic_field::add<StateKey, State>(0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::uid_mut<T0>(arg0), v1, v2);
    }

    fun finish_buyback<T0>(arg0: &mut 0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::Curve<T0>, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: u64) {
        let v0 = 0x2::object::id<0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::Curve<T0>>(arg0);
        let v1 = arg2 - 0x2::balance::value<0x2::sui::SUI>(&arg1);
        let v2 = state_mut<T0>(arg0);
        0x2::balance::join<0x2::sui::SUI>(&mut v2.buyback, arg1);
        v2.total_buyback_sui = v2.total_buyback_sui + v1;
        v2.total_burned = v2.total_burned + arg3;
        let v3 = BuybackExecuted{
            curve_id      : v0,
            venue         : arg5,
            sui_spent     : v1,
            tokens_burned : arg3,
            caller_reward : arg4,
            timestamp_ms  : arg6,
        };
        0x2::event::emit<BuybackExecuted>(v3);
    }

    public fun holders_stats<T0>(arg0: &0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::Curve<T0>) : (u64, u64, u64) {
        let v0 = StateKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<StateKey, State>(0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::uid<T0>(arg0), v0)) {
            return (0, 0, 0)
        };
        let v1 = StateKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<StateKey, State>(0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::uid<T0>(arg0), v1);
        (v2.total_staked, 0x2::balance::value<0x2::sui::SUI>(&v2.rewards), v2.total_rewards)
    }

    public fun min_buyback_mist() : u64 {
        10000000
    }

    public fun pending_rewards<T0>(arg0: &0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::Curve<T0>, arg1: &Stake<T0>) : u64 {
        let v0 = StateKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<StateKey, State>(0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::uid<T0>(arg0), v0)) {
            return 0
        };
        let v1 = StateKey{dummy_field: false};
        ((((0x2::balance::value<T0>(&arg1.tokens) as u256) * 0x2::dynamic_field::borrow<StateKey, State>(0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::uid<T0>(arg0), v1).acc_per_token - arg1.reward_debt) / 1000000000000000000) as u64)
    }

    public fun stake<T0>(arg0: &mut 0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::Curve<T0>, arg1: &0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : Stake<T0> {
        0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::config::assert_version(arg1);
        let (_, _, v2) = 0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::fee_mode<T0>(arg0);
        assert!(v2 > 0, 602);
        let v3 = 0x2::coin::value<T0>(&arg2);
        assert!(v3 > 0, 606);
        distribute_internal<T0>(arg0);
        let v4 = 0x2::object::id<0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::Curve<T0>>(arg0);
        let v5 = state_mut<T0>(arg0);
        v5.total_staked = v5.total_staked + v3;
        let v6 = Stake<T0>{
            id          : 0x2::object::new(arg3),
            curve_id    : v4,
            tokens      : 0x2::coin::into_balance<T0>(arg2),
            reward_debt : (v3 as u256) * v5.acc_per_token,
        };
        let v7 = Staked{
            curve_id     : v4,
            stake_id     : 0x2::object::id<Stake<T0>>(&v6),
            owner        : 0x2::tx_context::sender(arg3),
            amount       : v3,
            total_staked : v5.total_staked,
        };
        0x2::event::emit<Staked>(v7);
        v6
    }

    public fun stake_amount<T0>(arg0: &Stake<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.tokens)
    }

    public fun stake_curve_id<T0>(arg0: &Stake<T0>) : 0x2::object::ID {
        arg0.curve_id
    }

    fun state_mut<T0>(arg0: &mut 0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::Curve<T0>) : &mut State {
        ensure_state<T0>(arg0);
        let v0 = StateKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<StateKey, State>(0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::uid_mut<T0>(arg0), v0)
    }

    fun take_buyback_chunk<T0>(arg0: &mut 0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::Curve<T0>, arg1: u64, arg2: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = state_mut<T0>(arg0);
        assert!(v0.last_buyback_ms == 0 || arg2 >= v0.last_buyback_ms + 60000, 603);
        let v1 = 0x1::u64::min(0x2::balance::value<0x2::sui::SUI>(&v0.buyback), arg1);
        assert!(v1 >= 10000000, 604);
        v0.last_buyback_ms = arg2;
        0x2::balance::split<0x2::sui::SUI>(&mut v0.buyback, v1)
    }

    fun take_reward(arg0: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::math::mul_div(0x2::balance::value<0x2::sui::SUI>(arg0), 50, 10000);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(arg0, v0), arg1), 0x2::tx_context::sender(arg1));
        };
        v0
    }

    public fun unstake<T0>(arg0: &mut 0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::Curve<T0>, arg1: &0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::config::Config, arg2: Stake<T0>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = &mut arg2;
        let v1 = claim_rewards<T0>(arg0, arg1, v0, arg3);
        let v2 = 0x2::object::id<0x192d2cfb3266e5fd434c038d800f63059c74068f621027157772488675ce52c5::curve::Curve<T0>>(arg0);
        let Stake {
            id          : v3,
            curve_id    : _,
            tokens      : v5,
            reward_debt : _,
        } = arg2;
        let v7 = v5;
        let v8 = v3;
        let v9 = 0x2::balance::value<T0>(&v7);
        let v10 = state_mut<T0>(arg0);
        v10.total_staked = v10.total_staked - v9;
        let v11 = Unstaked{
            curve_id     : v2,
            stake_id     : 0x2::object::uid_to_inner(&v8),
            owner        : 0x2::tx_context::sender(arg3),
            amount       : v9,
            total_staked : v10.total_staked,
        };
        0x2::event::emit<Unstaked>(v11);
        0x2::object::delete(v8);
        (0x2::coin::from_balance<T0>(v7, arg3), v1)
    }

    // decompiled from Move bytecode v7
}

