module 0x2afb4567587bb94b11f6436511b1a4befd502d0b7aad05d9a5ae1c5b29ac7b79::pair {
    struct FeeMode has copy, drop, store {
        creator_bps: u64,
        buyback_bps: u64,
        holders_bps: u64,
    }

    struct Stream has store {
        queued: u64,
        streaming: u64,
        last_ms: u64,
        end_ms: u64,
    }

    struct Pair<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        creator: address,
        creator_bps: u64,
        min_buyback: u64,
        mode: FeeMode,
        creator_q: 0x2::balance::Balance<T1>,
        creator_t: 0x2::balance::Balance<T0>,
        buyback: 0x2::balance::Balance<T1>,
        to_burn: 0x2::balance::Balance<T0>,
        last_buyback_ms: u64,
        total_buyback_q: u64,
        total_burned: u64,
        rewards_q: 0x2::balance::Balance<T1>,
        rewards_t: 0x2::balance::Balance<T0>,
        stream_q: Stream,
        stream_t: Stream,
        total_staked: u64,
        acc_q: u256,
        acc_t: u256,
        total_fees_q: u64,
        total_fees_t: u64,
    }

    struct PositionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Stake<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pair_id: 0x2::object::ID,
        tokens: 0x2::balance::Balance<T0>,
        debt_q: u256,
        debt_t: u256,
    }

    struct Launched has copy, drop {
        pair_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        token: 0x1::ascii::String,
        quote: 0x1::ascii::String,
        creator: address,
        start_tick_bits: u32,
        upper_tick_bits: u32,
        start_sqrt_price: u128,
        start_fdv: u64,
        liquidity_tokens: u64,
        mode: u8,
        creator_bps: u64,
        dev_tokens: u64,
        dev_paid: u64,
        launch_fee: u64,
    }

    struct FeesCollected has copy, drop {
        pair_id: 0x2::object::ID,
        fee_q: u64,
        fee_t: u64,
        platform_q: u64,
        creator_q: u64,
        creator_t: u64,
        buyback_q: u64,
        holders_q: u64,
        holders_t: u64,
        burn_t: u64,
    }

    struct RewardCollected has copy, drop {
        pair_id: 0x2::object::ID,
        coin: 0x1::ascii::String,
        amount: u64,
        to: address,
    }

    struct TokensBurned has copy, drop {
        pair_id: 0x2::object::ID,
        amount: u64,
        total_burned: u64,
    }

    struct CreatorClaimed has copy, drop {
        pair_id: 0x2::object::ID,
        creator: address,
        amount_q: u64,
        amount_t: u64,
    }

    struct BuybackExecuted has copy, drop {
        pair_id: 0x2::object::ID,
        quote_spent: u64,
        tokens_bought: u64,
        caller_reward: u64,
        timestamp_ms: u64,
    }

    struct Staked has copy, drop {
        pair_id: 0x2::object::ID,
        stake_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        total_staked: u64,
    }

    struct Unstaked has copy, drop {
        pair_id: 0x2::object::ID,
        stake_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        total_staked: u64,
    }

    struct RewardsClaimed has copy, drop {
        pair_id: 0x2::object::ID,
        stake_id: 0x2::object::ID,
        owner: address,
        amount_q: u64,
        amount_t: u64,
    }

    struct RewardsReleased has copy, drop {
        pair_id: 0x2::object::ID,
        coin: u8,
        amount: u64,
        to_buyback: bool,
        streaming_left: u64,
        end_ms: u64,
    }

    public fun total_supply() : u64 {
        1000000000000000
    }

    public fun creator_bps<T0, T1>(arg0: &Pair<T0, T1>) : u64 {
        arg0.creator_bps
    }

    public fun min_buyback<T0, T1>(arg0: &Pair<T0, T1>) : u64 {
        arg0.min_buyback
    }

    public fun add_stake<T0, T1>(arg0: &mut Pair<T0, T1>, arg1: &0x2afb4567587bb94b11f6436511b1a4befd502d0b7aad05d9a5ae1c5b29ac7b79::config::Config, arg2: &mut Stake<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 215);
        let (v1, v2) = claim_rewards<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        arg0.total_staked = arg0.total_staked + v0;
        0x2::balance::join<T0>(&mut arg2.tokens, 0x2::coin::into_balance<T0>(arg3));
        let v3 = (0x2::balance::value<T0>(&arg2.tokens) as u256);
        arg2.debt_q = v3 * arg0.acc_q;
        arg2.debt_t = v3 * arg0.acc_t;
        let v4 = Staked{
            pair_id      : 0x2::object::id<Pair<T0, T1>>(arg0),
            stake_id     : 0x2::object::id<Stake<T0, T1>>(arg2),
            owner        : 0x2::tx_context::sender(arg5),
            amount       : v0,
            total_staked : arg0.total_staked,
        };
        0x2::event::emit<Staked>(v4);
        (v1, v2)
    }

    fun advance(arg0: &mut Stream, arg1: u64) : (u64, u64, u64) {
        let v0 = arg0.streaming;
        let v1 = if (v0 == 0 || arg1 <= arg0.last_ms) {
            0
        } else if (arg1 >= arg0.end_ms) {
            v0
        } else {
            mul_div(v0, arg1 - arg0.last_ms, arg0.end_ms - arg0.last_ms)
        };
        arg0.streaming = v0 - v1;
        if (arg1 > arg0.last_ms) {
            arg0.last_ms = arg1;
        };
        if (arg0.queued > 0) {
            arg0.streaming = arg0.streaming + arg0.queued;
            arg0.queued = 0;
            arg0.end_ms = arg1 + 259200000;
        };
        (v1, arg0.streaming, arg0.end_ms)
    }

    fun burn_pending<T0, T1>(arg0: &mut Pair<T0, T1>, arg1: &mut 0x2::coin_registry::Currency<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg0.to_burn);
        if (v0 == 0) {
            return
        };
        0x2::coin_registry::burn_balance<T0>(arg1, 0x2::balance::withdraw_all<T0>(&mut arg0.to_burn));
        arg0.total_burned = arg0.total_burned + v0;
        let v1 = TokensBurned{
            pair_id      : 0x2::object::id<Pair<T0, T1>>(arg0),
            amount       : v0,
            total_burned : arg0.total_burned,
        };
        0x2::event::emit<TokensBurned>(v1);
    }

    public fun buyback<T0, T1>(arg0: &mut Pair<T0, T1>, arg1: &0x2afb4567587bb94b11f6436511b1a4befd502d0b7aad05d9a5ae1c5b29ac7b79::config::Config, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x2::coin_registry::Currency<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2afb4567587bb94b11f6436511b1a4befd502d0b7aad05d9a5ae1c5b29ac7b79::config::assert_version(arg1);
        assert!(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3) == arg0.pool_id, 210);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg0.last_buyback_ms == 0 || v0 >= arg0.last_buyback_ms + 60000, 212);
        let v1 = 0x2::balance::value<T1>(&arg0.buyback);
        assert!(v1 >= arg0.min_buyback, 213);
        arg0.last_buyback_ms = v0;
        let v2 = 0x2::balance::withdraw_all<T1>(&mut arg0.buyback);
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3);
        let v4 = v3 + v3 * 25 / (10000 as u128);
        let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::max_sqrt_price() - 1;
        let v6 = if (v4 > v5) {
            v5
        } else {
            v4
        };
        let (v7, v8, v9) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg5, arg2, arg3, false, true, v1 - mul_div(v1, 50, 10000), v6);
        let v10 = v9;
        let v11 = v7;
        let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v10);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg2, arg3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v2, v12), v10);
        0x2::balance::destroy_zero<T1>(v8);
        let v13 = 0x1::u64::min(mul_div(v12, 50, 10000), 0x2::balance::value<T1>(&v2));
        if (v13 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v2, v13), arg6), 0x2::tx_context::sender(arg6));
        };
        0x2::balance::join<T1>(&mut arg0.buyback, v2);
        let v14 = 0x2::balance::value<T0>(&v11);
        assert!(v14 > 0, 213);
        0x2::balance::join<T0>(&mut arg0.to_burn, v11);
        arg0.total_buyback_q = arg0.total_buyback_q + v12;
        let v15 = BuybackExecuted{
            pair_id       : 0x2::object::id<Pair<T0, T1>>(arg0),
            quote_spent   : v12,
            tokens_bought : v14,
            caller_reward : v13,
            timestamp_ms  : v0,
        };
        0x2::event::emit<BuybackExecuted>(v15);
        burn_pending<T0, T1>(arg0, arg4);
    }

    public fun buyback_interval_ms() : u64 {
        60000
    }

    public fun buyback_reward_bps() : u64 {
        50
    }

    public fun buyback_stats<T0, T1>(arg0: &Pair<T0, T1>) : (u64, u64, u64, u64, u64) {
        (0x2::balance::value<T1>(&arg0.buyback), arg0.last_buyback_ms, arg0.total_buyback_q, arg0.total_burned, 0x2::balance::value<T0>(&arg0.to_burn))
    }

    public fun claim_creator<T0, T1>(arg0: &mut Pair<T0, T1>, arg1: &0x2afb4567587bb94b11f6436511b1a4befd502d0b7aad05d9a5ae1c5b29ac7b79::config::Config, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        0x2afb4567587bb94b11f6436511b1a4befd502d0b7aad05d9a5ae1c5b29ac7b79::config::assert_version(arg1);
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 211);
        let v0 = 0x2::balance::withdraw_all<T1>(&mut arg0.creator_q);
        let v1 = 0x2::balance::withdraw_all<T0>(&mut arg0.creator_t);
        let v2 = CreatorClaimed{
            pair_id  : 0x2::object::id<Pair<T0, T1>>(arg0),
            creator  : 0x2::tx_context::sender(arg2),
            amount_q : 0x2::balance::value<T1>(&v0),
            amount_t : 0x2::balance::value<T0>(&v1),
        };
        0x2::event::emit<CreatorClaimed>(v2);
        (0x2::coin::from_balance<T1>(v0, arg2), 0x2::coin::from_balance<T0>(v1, arg2))
    }

    fun claim_internal<T0, T1>(arg0: &mut Pair<T0, T1>, arg1: &mut Stake<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        let v0 = (0x2::balance::value<T0>(&arg1.tokens) as u256);
        let v1 = v0 * arg0.acc_q;
        let v2 = v0 * arg0.acc_t;
        arg1.debt_q = v1;
        arg1.debt_t = v2;
        let v3 = 0x1::u64::min((((v1 - arg1.debt_q) / 1000000000000000000) as u64), 0x2::balance::value<T1>(&arg0.rewards_q) - arg0.stream_q.queued - arg0.stream_q.streaming);
        let v4 = 0x1::u64::min((((v2 - arg1.debt_t) / 1000000000000000000) as u64), 0x2::balance::value<T0>(&arg0.rewards_t) - arg0.stream_t.queued - arg0.stream_t.streaming);
        if (v3 > 0 || v4 > 0) {
            let v5 = RewardsClaimed{
                pair_id  : 0x2::object::id<Pair<T0, T1>>(arg0),
                stake_id : 0x2::object::id<Stake<T0, T1>>(arg1),
                owner    : 0x2::tx_context::sender(arg2),
                amount_q : v3,
                amount_t : v4,
            };
            0x2::event::emit<RewardsClaimed>(v5);
        };
        (0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.rewards_q, v3), arg2), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.rewards_t, v4), arg2))
    }

    public fun claim_rewards<T0, T1>(arg0: &mut Pair<T0, T1>, arg1: &0x2afb4567587bb94b11f6436511b1a4befd502d0b7aad05d9a5ae1c5b29ac7b79::config::Config, arg2: &mut Stake<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        0x2afb4567587bb94b11f6436511b1a4befd502d0b7aad05d9a5ae1c5b29ac7b79::config::assert_version(arg1);
        assert!(arg2.pair_id == 0x2::object::id<Pair<T0, T1>>(arg0), 216);
        release<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg3));
        claim_internal<T0, T1>(arg0, arg2, arg4)
    }

    public fun collect<T0, T1>(arg0: &mut Pair<T0, T1>, arg1: &0x2afb4567587bb94b11f6436511b1a4befd502d0b7aad05d9a5ae1c5b29ac7b79::config::Config, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x2::coin_registry::Currency<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2afb4567587bb94b11f6436511b1a4befd502d0b7aad05d9a5ae1c5b29ac7b79::config::assert_version(arg1);
        assert!(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3) == arg0.pool_id, 210);
        let v0 = PositionKey{dummy_field: false};
        let (_, _, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg5, arg2, arg3, 0x2::dynamic_object_field::borrow_mut<PositionKey, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, v0));
        let v5 = split_fees<T0, T1>(arg0, v3, v4);
        if (0x2::balance::value<T1>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg6), 0x2afb4567587bb94b11f6436511b1a4befd502d0b7aad05d9a5ae1c5b29ac7b79::config::fee_recipient(arg1));
        } else {
            0x2::balance::destroy_zero<T1>(v5);
        };
        burn_pending<T0, T1>(arg0, arg4);
    }

    public fun collect_reward<T0, T1, T2>(arg0: &mut Pair<T0, T1>, arg1: &0x2afb4567587bb94b11f6436511b1a4befd502d0b7aad05d9a5ae1c5b29ac7b79::config::Config, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2afb4567587bb94b11f6436511b1a4befd502d0b7aad05d9a5ae1c5b29ac7b79::config::assert_version(arg1);
        assert!(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3) == arg0.pool_id, 210);
        let v0 = PositionKey{dummy_field: false};
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg4, arg2, arg3, 0x2::dynamic_object_field::borrow_mut<PositionKey, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, v0));
        let v2 = 0x2::balance::value<T2>(&v1);
        if (v2 == 0) {
            0x2::balance::destroy_zero<T2>(v1);
            return
        };
        let v3 = RewardCollected{
            pair_id : 0x2::object::id<Pair<T0, T1>>(arg0),
            coin    : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T2>()),
            amount  : v2,
            to      : arg0.creator,
        };
        0x2::event::emit<RewardCollected>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v1, arg5), arg0.creator);
    }

    public fun creator<T0, T1>(arg0: &Pair<T0, T1>) : address {
        arg0.creator
    }

    public fun creator_balances<T0, T1>(arg0: &Pair<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T1>(&arg0.creator_q), 0x2::balance::value<T0>(&arg0.creator_t))
    }

    public fun fee_mode<T0, T1>(arg0: &Pair<T0, T1>) : (u64, u64, u64) {
        (arg0.mode.creator_bps, arg0.mode.buyback_bps, arg0.mode.holders_bps)
    }

    public fun fee_mode_preset(arg0: u8) : FeeMode {
        if (arg0 == 0) {
            FeeMode{creator_bps: 10000, buyback_bps: 0, holders_bps: 0}
        } else if (arg0 == 1) {
            FeeMode{creator_bps: 0, buyback_bps: 10000, holders_bps: 0}
        } else if (arg0 == 2) {
            FeeMode{creator_bps: 0, buyback_bps: 0, holders_bps: 10000}
        } else {
            assert!(arg0 == 3, 206);
            FeeMode{creator_bps: 5000, buyback_bps: 2500, holders_bps: 2500}
        }
    }

    public fun holders_stats<T0, T1>(arg0: &Pair<T0, T1>) : (u64, u64, u64) {
        (arg0.total_staked, 0x2::balance::value<T1>(&arg0.rewards_q), 0x2::balance::value<T0>(&arg0.rewards_t))
    }

    public fun launch<T0, T1>(arg0: &0x2afb4567587bb94b11f6436511b1a4befd502d0b7aad05d9a5ae1c5b29ac7b79::config::Config, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin_registry::MetadataCap<T0>, arg4: &mut 0x2::coin_registry::Currency<T0>, arg5: &0x2::coin_registry::Currency<T1>, arg6: u32, arg7: u8, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: 0x2::coin::Coin<T1>, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2afb4567587bb94b11f6436511b1a4befd502d0b7aad05d9a5ae1c5b29ac7b79::config::assert_launch<T1>(arg0);
        assert!(0x2::coin_registry::treasury_cap_id<T0>(arg4) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::coin::TreasuryCap<T0>>(&arg2)), 200);
        assert!(!0x2::coin_registry::is_regulated<T0>(arg4), 201);
        assert!(0x2::coin_registry::decimals<T0>(arg4) == 6, 202);
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0, 203);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg6);
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::is_valid_index(v1, 200), 204);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mod(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(200)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::zero()), 204);
        let v2 = upper_tick_bits();
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v2)), 204);
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_sqrt_price_at_tick(v1);
        let v4 = start_fdv(v3);
        assert!(v4 >= 0x2afb4567587bb94b11f6436511b1a4befd502d0b7aad05d9a5ae1c5b29ac7b79::config::min_start_fdv(&v0) && v4 <= 0x2afb4567587bb94b11f6436511b1a4befd502d0b7aad05d9a5ae1c5b29ac7b79::config::max_start_fdv(&v0), 205);
        let v5 = 0x2afb4567587bb94b11f6436511b1a4befd502d0b7aad05d9a5ae1c5b29ac7b79::config::launch_fee(arg0);
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg8, v5, arg12), 0x2afb4567587bb94b11f6436511b1a4befd502d0b7aad05d9a5ae1c5b29ac7b79::config::fee_recipient(arg0));
        };
        let (v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::get_pool_creation_fee_amount<0x2::sui::SUI>(arg1);
        assert!(v6 || v7 == 0, 207);
        return_or_destroy<0x2::sui::SUI>(arg8, arg12);
        0x2::coin_registry::make_supply_burn_only<T0>(arg4, arg2);
        0x2::coin_registry::delete_metadata_cap<T0>(arg4, arg3);
        let v8 = 0x1::string::into_bytes(0x2::coin_registry::symbol<T0>(arg4));
        let v9 = 0x1::string::into_bytes(0x2::coin_registry::symbol<T1>(arg5));
        0x1::vector::append<u8>(&mut v8, b"-");
        0x1::vector::append<u8>(&mut v8, v9);
        let v10 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::create_pool_and_get_object<T0, T1, 0x2::sui::SUI>(arg11, arg1, v8, 0x1::string::into_bytes(0x2::coin_registry::icon_url<T0>(arg4)), v8, 6, b"", v9, 0x2::coin_registry::decimals<T1>(arg5), b"", 200, 10000, v3, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg8, v7, arg12)), arg12);
        let v11 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, &mut v10, arg6, v2, arg12);
        let (v12, _, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg11, arg1, &mut v10, &mut v11, 0x2::coin::mint_balance<T0>(&mut arg2, 1000000000000000), 0x2::balance::zero<T1>(), 1000000000000000, true);
        let v16 = v15;
        let v17 = v14;
        assert!(0x2::balance::value<T1>(&v16) == 0, 217);
        0x2::balance::destroy_zero<T1>(v16);
        let v18 = 0x2::coin::value<T1>(&arg9);
        let v19 = if (v18 > 0) {
            let (v20, v21, v22) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg11, arg1, &mut v10, false, true, v18, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::max_sqrt_price() - 1);
            let v23 = v22;
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, &mut v10, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg9, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v23), arg12)), v23);
            0x2::balance::destroy_zero<T1>(v21);
            v20
        } else {
            0x2::balance::zero<T0>()
        };
        let v24 = v19;
        let v25 = 0x2::balance::value<T0>(&v24);
        assert!(v25 <= mul_div(1000000000000000, 0x2afb4567587bb94b11f6436511b1a4befd502d0b7aad05d9a5ae1c5b29ac7b79::config::max_dev_buy_bps(arg0), 10000), 208);
        assert!(v25 >= arg10, 209);
        return_or_destroy<T1>(arg9, arg12);
        let v26 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(&v10);
        let v27 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v11);
        let v28 = 0x2::tx_context::sender(arg12);
        let v29 = new_pair<T0, T1>(v26, v27, v28, 0x2afb4567587bb94b11f6436511b1a4befd502d0b7aad05d9a5ae1c5b29ac7b79::config::creator_bps(arg0), 0x2afb4567587bb94b11f6436511b1a4befd502d0b7aad05d9a5ae1c5b29ac7b79::config::min_buyback(&v0), fee_mode_preset(arg7), arg12);
        let v30 = PositionKey{dummy_field: false};
        0x2::dynamic_object_field::add<PositionKey, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut v29.id, v30, v11);
        let v31 = 0x2::balance::value<T0>(&v17);
        if (v31 > 0) {
            0x2::coin_registry::burn_balance<T0>(arg4, v17);
            v29.total_burned = v31;
            let v32 = TokensBurned{
                pair_id      : 0x2::object::id<Pair<T0, T1>>(&v29),
                amount       : v31,
                total_burned : v31,
            };
            0x2::event::emit<TokensBurned>(v32);
        } else {
            0x2::balance::destroy_zero<T0>(v17);
        };
        let v33 = Launched{
            pair_id          : 0x2::object::id<Pair<T0, T1>>(&v29),
            pool_id          : v26,
            position_id      : v27,
            token            : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            quote            : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>()),
            creator          : 0x2::tx_context::sender(arg12),
            start_tick_bits  : arg6,
            upper_tick_bits  : v2,
            start_sqrt_price : v3,
            start_fdv        : v4,
            liquidity_tokens : v12,
            mode             : arg7,
            creator_bps      : v29.creator_bps,
            dev_tokens       : v25,
            dev_paid         : v18 - 0x2::coin::value<T1>(&arg9),
            launch_fee       : v5,
        };
        0x2::event::emit<Launched>(v33);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::share_pool_object<T0, T1>(v10);
        0x2::transfer::share_object<Pair<T0, T1>>(v29);
        0x2::coin::from_balance<T0>(v24, arg12)
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    fun new_pair<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: FeeMode, arg6: &mut 0x2::tx_context::TxContext) : Pair<T0, T1> {
        let v0 = Stream{
            queued    : 0,
            streaming : 0,
            last_ms   : 0,
            end_ms    : 0,
        };
        let v1 = Stream{
            queued    : 0,
            streaming : 0,
            last_ms   : 0,
            end_ms    : 0,
        };
        Pair<T0, T1>{
            id              : 0x2::object::new(arg6),
            pool_id         : arg0,
            position_id     : arg1,
            creator         : arg2,
            creator_bps     : arg3,
            min_buyback     : arg4,
            mode            : arg5,
            creator_q       : 0x2::balance::zero<T1>(),
            creator_t       : 0x2::balance::zero<T0>(),
            buyback         : 0x2::balance::zero<T1>(),
            to_burn         : 0x2::balance::zero<T0>(),
            last_buyback_ms : 0,
            total_buyback_q : 0,
            total_burned    : 0,
            rewards_q       : 0x2::balance::zero<T1>(),
            rewards_t       : 0x2::balance::zero<T0>(),
            stream_q        : v0,
            stream_t        : v1,
            total_staked    : 0,
            acc_q           : 0,
            acc_t           : 0,
            total_fees_q    : 0,
            total_fees_t    : 0,
        }
    }

    public fun pending_rewards<T0, T1>(arg0: &Pair<T0, T1>, arg1: &Stake<T0, T1>) : (u64, u64) {
        let v0 = (0x2::balance::value<T0>(&arg1.tokens) as u256);
        ((((v0 * arg0.acc_q - arg1.debt_q) / 1000000000000000000) as u64), (((v0 * arg0.acc_t - arg1.debt_t) / 1000000000000000000) as u64))
    }

    public fun pool_fee_rate() : u64 {
        10000
    }

    public fun pool_id<T0, T1>(arg0: &Pair<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun position_id<T0, T1>(arg0: &Pair<T0, T1>) : 0x2::object::ID {
        arg0.position_id
    }

    fun release<T0, T1>(arg0: &mut Pair<T0, T1>, arg1: u64) {
        let v0 = 0x2::object::id<Pair<T0, T1>>(arg0);
        let v1 = arg0.total_staked;
        let v2 = &mut arg0.stream_q;
        let (v3, v4, v5) = advance(v2, arg1);
        if (v3 > 0) {
            let v6 = v1 == 0;
            if (v6) {
                0x2::balance::join<T1>(&mut arg0.buyback, 0x2::balance::split<T1>(&mut arg0.rewards_q, v3));
            } else {
                arg0.acc_q = arg0.acc_q + (v3 as u256) * 1000000000000000000 / (v1 as u256);
            };
            let v7 = RewardsReleased{
                pair_id        : v0,
                coin           : 0,
                amount         : v3,
                to_buyback     : v6,
                streaming_left : v4,
                end_ms         : v5,
            };
            0x2::event::emit<RewardsReleased>(v7);
        };
        let v8 = &mut arg0.stream_t;
        let (v9, v10, v11) = advance(v8, arg1);
        if (v9 > 0) {
            let v12 = v1 == 0;
            if (v12) {
                0x2::balance::join<T0>(&mut arg0.to_burn, 0x2::balance::split<T0>(&mut arg0.rewards_t, v9));
            } else {
                arg0.acc_t = arg0.acc_t + (v9 as u256) * 1000000000000000000 / (v1 as u256);
            };
            let v13 = RewardsReleased{
                pair_id        : v0,
                coin           : 1,
                amount         : v9,
                to_buyback     : v12,
                streaming_left : v10,
                end_ms         : v11,
            };
            0x2::event::emit<RewardsReleased>(v13);
        };
    }

    public fun release_rewards<T0, T1>(arg0: &mut Pair<T0, T1>, arg1: &0x2afb4567587bb94b11f6436511b1a4befd502d0b7aad05d9a5ae1c5b29ac7b79::config::Config, arg2: &0x2::clock::Clock) {
        0x2afb4567587bb94b11f6436511b1a4befd502d0b7aad05d9a5ae1c5b29ac7b79::config::assert_version(arg1);
        release<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg2));
    }

    fun return_or_destroy<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun reward_stream_ms() : u64 {
        259200000
    }

    fun split_fees<T0, T1>(arg0: &mut Pair<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T1>(&arg2);
        let v1 = 0x2::balance::value<T0>(&arg1);
        arg0.total_fees_q = arg0.total_fees_q + v0;
        arg0.total_fees_t = arg0.total_fees_t + v1;
        let v2 = v0 - mul_div(v0, arg0.creator_bps, 10000);
        let v3 = v1 - mul_div(v1, arg0.creator_bps, 10000);
        0x2::balance::join<T0>(&mut arg0.to_burn, 0x2::balance::split<T0>(&mut arg1, v3));
        let v4 = 0x2::balance::value<T1>(&arg2);
        let v5 = 0x2::balance::value<T0>(&arg1);
        let v6 = mul_div(v4, arg0.mode.buyback_bps, 10000);
        let v7 = v6;
        let v8 = mul_div(v5, arg0.mode.buyback_bps, 10000);
        let v9 = v8;
        let v10 = mul_div(v4, arg0.mode.holders_bps, 10000);
        let v11 = mul_div(v5, arg0.mode.holders_bps, 10000);
        let v12 = 0;
        let v13 = 0;
        if (arg0.total_staked > 0) {
            if (v10 > 0) {
                arg0.stream_q.queued = arg0.stream_q.queued + v10;
                0x2::balance::join<T1>(&mut arg0.rewards_q, 0x2::balance::split<T1>(&mut arg2, v10));
                v13 = v10;
            };
            if (v11 > 0) {
                arg0.stream_t.queued = arg0.stream_t.queued + v11;
                0x2::balance::join<T0>(&mut arg0.rewards_t, 0x2::balance::split<T0>(&mut arg1, v11));
                v12 = v11;
            };
        } else {
            v7 = v6 + v10;
            v9 = v8 + v11;
        };
        0x2::balance::join<T1>(&mut arg0.buyback, 0x2::balance::split<T1>(&mut arg2, v7));
        0x2::balance::join<T0>(&mut arg0.to_burn, 0x2::balance::split<T0>(&mut arg1, v9));
        0x2::balance::join<T1>(&mut arg0.creator_q, arg2);
        0x2::balance::join<T0>(&mut arg0.creator_t, arg1);
        let v14 = FeesCollected{
            pair_id    : 0x2::object::id<Pair<T0, T1>>(arg0),
            fee_q      : v0,
            fee_t      : v1,
            platform_q : v2,
            creator_q  : 0x2::balance::value<T1>(&arg2),
            creator_t  : 0x2::balance::value<T0>(&arg1),
            buyback_q  : v7,
            holders_q  : v13,
            holders_t  : v12,
            burn_t     : v3 + v9,
        };
        0x2::event::emit<FeesCollected>(v14);
        0x2::balance::split<T1>(&mut arg2, v2)
    }

    public fun stake<T0, T1>(arg0: &mut Pair<T0, T1>, arg1: &0x2afb4567587bb94b11f6436511b1a4befd502d0b7aad05d9a5ae1c5b29ac7b79::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : Stake<T0, T1> {
        0x2afb4567587bb94b11f6436511b1a4befd502d0b7aad05d9a5ae1c5b29ac7b79::config::assert_version(arg1);
        assert!(arg0.mode.holders_bps > 0, 214);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 215);
        release<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg3));
        arg0.total_staked = arg0.total_staked + v0;
        let v1 = Stake<T0, T1>{
            id      : 0x2::object::new(arg4),
            pair_id : 0x2::object::id<Pair<T0, T1>>(arg0),
            tokens  : 0x2::coin::into_balance<T0>(arg2),
            debt_q  : (v0 as u256) * arg0.acc_q,
            debt_t  : (v0 as u256) * arg0.acc_t,
        };
        let v2 = Staked{
            pair_id      : 0x2::object::id<Pair<T0, T1>>(arg0),
            stake_id     : 0x2::object::id<Stake<T0, T1>>(&v1),
            owner        : 0x2::tx_context::sender(arg4),
            amount       : v0,
            total_staked : arg0.total_staked,
        };
        0x2::event::emit<Staked>(v2);
        v1
    }

    public fun stake_amount<T0, T1>(arg0: &Stake<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.tokens)
    }

    public fun stake_pair_id<T0, T1>(arg0: &Stake<T0, T1>) : 0x2::object::ID {
        arg0.pair_id
    }

    public fun start_fdv(arg0: u128) : u64 {
        let v0 = (arg0 as u256);
        let v1 = (v0 * v0 >> 64) * (1000000000000000 as u256) >> 64;
        if (v1 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v1 as u64)
        }
    }

    public fun stream_stats<T0, T1>(arg0: &Pair<T0, T1>) : (u64, u64, u64, u64, u64, u64, u64, u64) {
        let v0 = &arg0.stream_q;
        let v1 = &arg0.stream_t;
        (v0.queued, v0.streaming, v0.last_ms, v0.end_ms, v1.queued, v1.streaming, v1.last_ms, v1.end_ms)
    }

    public fun tick_spacing() : u32 {
        200
    }

    public fun total_fees<T0, T1>(arg0: &Pair<T0, T1>) : (u64, u64) {
        (arg0.total_fees_q, arg0.total_fees_t)
    }

    public fun unstake<T0, T1>(arg0: &mut Pair<T0, T1>, arg1: &0x2afb4567587bb94b11f6436511b1a4befd502d0b7aad05d9a5ae1c5b29ac7b79::config::Config, arg2: Stake<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg2.pair_id == 0x2::object::id<Pair<T0, T1>>(arg0), 216);
        release<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg3));
        let v0 = &mut arg2;
        let (v1, v2) = claim_internal<T0, T1>(arg0, v0, arg4);
        let v3 = v2;
        let Stake {
            id      : v4,
            pair_id : _,
            tokens  : v6,
            debt_q  : _,
            debt_t  : _,
        } = arg2;
        let v9 = v6;
        let v10 = v4;
        let v11 = 0x2::balance::value<T0>(&v9);
        arg0.total_staked = arg0.total_staked - v11;
        let v12 = Unstaked{
            pair_id      : 0x2::object::id<Pair<T0, T1>>(arg0),
            stake_id     : 0x2::object::uid_to_inner(&v10),
            owner        : 0x2::tx_context::sender(arg4),
            amount       : v11,
            total_staked : arg0.total_staked,
        };
        0x2::event::emit<Unstaked>(v12);
        0x2::object::delete(v10);
        0x2::coin::join<T0>(&mut v3, 0x2::coin::from_balance<T0>(v9, arg4));
        (v3, v1)
    }

    public fun upper_tick_bits() : u32 {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::max_tick());
        v0 - v0 % 200
    }

    // decompiled from Move bytecode v7
}

