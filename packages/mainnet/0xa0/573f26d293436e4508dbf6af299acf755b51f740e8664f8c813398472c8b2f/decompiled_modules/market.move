module 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market {
    struct Market<phantom T0> has key {
        id: 0x2::object::UID,
        inner: 0x8256e107385261b483aad47fdbcf99b22706396d9f49b53a756ee4af0d11f977::versioned_object::VersionedObject,
    }

    struct CreatorCap has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
    }

    struct MarketCreated has copy, drop {
        market_id: 0x2::object::ID,
        oracle_id: 0x1::option::Option<0x2::object::ID>,
        starts_at_ms: u64,
        created_at_ms: u64,
        expires_at_ms: 0x1::option::Option<u64>,
        outcome_values: vector<vector<u8>>,
    }

    struct MarketResolved has copy, drop {
        market_id: 0x2::object::ID,
        outcome_index: u64,
        resolved_at_ms: u64,
        final_prices: vector<u64>,
    }

    struct Trade has copy, drop {
        market_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        amount: u64,
        is_buy: bool,
        quantity: u64,
        fee_amount: u64,
        min_payout: u64,
        timestamp_ms: u64,
        outcome_index: u64,
        max_total_cost: u64,
        new_prices: vector<u64>,
    }

    struct Redeem has copy, drop {
        market_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        amount: u64,
        payout: u64,
        timestamp_ms: u64,
        outcome_index: u64,
    }

    struct VoidRedeemed has copy, drop {
        market_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        amount: u64,
        timestamp_ms: u64,
    }

    struct MarketPaused has copy, drop {
        market_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct MarketResumed has copy, drop {
        market_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct CreationFeeAdded has copy, drop {
        market_id: 0x2::object::ID,
        fee_amount: u64,
        timestamp_ms: u64,
    }

    struct LockBought has copy, drop {
        market_id: 0x2::object::ID,
        lock_id: 0x2::object::ID,
        cost: u64,
        quantity: u64,
        timestamp_ms: u64,
    }

    struct LockRedeemed has copy, drop {
        market_id: 0x2::object::ID,
        lock_id: 0x2::object::ID,
        payout: u64,
        timestamp_ms: u64,
        outcome_index: u64,
        locker_fee_share: u64,
    }

    struct LockVoidRedeemed has copy, drop {
        market_id: 0x2::object::ID,
        lock_id: 0x2::object::ID,
        payout: u64,
        timestamp_ms: u64,
    }

    struct BalanceClaimed has copy, drop {
        market_id: 0x2::object::ID,
        is_protocol: bool,
        amount: u64,
    }

    struct MarketVoided has copy, drop {
        market_id: 0x2::object::ID,
        voided_at_ms: u64,
        final_prices: vector<u64>,
    }

    struct OracleIDUpdated has copy, drop {
        market_id: 0x2::object::ID,
        oracle_id: 0x2::object::ID,
    }

    struct MarketExpiredEarly has copy, drop {
        market_id: 0x2::object::ID,
        previous_expires_at_ms: 0x1::option::Option<u64>,
        expired_at_ms: u64,
    }

    public fun share<T0>(arg0: Market<T0>, arg1: &0x2::clock::Clock) {
        let v0 = &mut arg0;
        let v1 = load_data<T0>(v0);
        assert!(!0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::is_paused<T0>(v1), 15);
        assert!(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::is_shareable<T0>(v1, arg1), 13);
        0x2::transfer::share_object<Market<T0>>(arg0);
    }

    public fun id<T0>(arg0: &mut Market<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun add_creation_fee<T0>(arg0: &mut Market<T0>, arg1: &0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::config::ProtocolConfig, arg2: &CreatorCap, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock) {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        assert!(v0 == arg2.market_id, 4);
        let v1 = load_data_mut<T0>(arg0);
        assert!(!0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::is_paused<T0>(v1), 15);
        assert!(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::state<T0>(v1, arg4) == 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::state_initializing(), 0);
        let v2 = 0x2::coin::value<T0>(&arg3);
        assert!(v2 == 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::config::creation_fee(arg1, 0x1::type_name::with_defining_ids<T0>()), 1);
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::add_creation_fee<T0>(v1, 0x2::coin::into_balance<T0>(arg3));
        let v3 = CreationFeeAdded{
            market_id    : v0,
            fee_amount   : v2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<CreationFeeAdded>(v3);
    }

    public fun bailout_market<T0>(arg0: &mut Market<T0>, arg1: &0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::config::ProtocolCap, arg2: 0x2::coin::Coin<T0>) {
        let v0 = load_data_mut<T0>(arg0);
        assert!(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::is_paused<T0>(v0), 16);
        0x2::balance::join<T0>(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::pool_balance_mut<T0>(v0), 0x2::coin::into_balance<T0>(arg2));
    }

    public fun buy<T0>(arg0: &mut Market<T0>, arg1: &mut 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::position::Position<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::share::Share, 0x2::coin::Coin<T0>) {
        assert!(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::position::market_id<T0>(arg1) == 0x2::object::uid_to_inner(&arg0.id), 7);
        let v0 = load_data_mut<T0>(arg0);
        assert!(!0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::is_paused<T0>(v0), 15);
        assert!(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::state<T0>(v0, arg6) == 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::state_active(), 0);
        assert!(arg3 < 0x2::vec_set::length<vector<u8>>(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::outcome_values<T0>(v0)), 2);
        let (v1, v2) = preview_cost<T0>(v0, arg3, arg4);
        let v3 = v1 + v2;
        assert!(v3 <= arg5, 8);
        assert!(0x2::coin::value<T0>(&arg2) >= v3, 1);
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::deposit<T0>(v0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v3, arg7)), v2);
        let v4 = 0x2::clock::timestamp_ms(arg6);
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::position::apply_buy<T0>(arg1, arg3, arg4, v3, v2, v4);
        let v5 = v0;
        let v6 = 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::config<T0>(v5);
        let v7 = Trade{
            market_id      : 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::position::market_id<T0>(arg1),
            position_id    : 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::position::id<T0>(arg1),
            amount         : v3,
            is_buy         : true,
            quantity       : arg4,
            fee_amount     : v2,
            min_payout     : 0,
            timestamp_ms   : v4,
            outcome_index  : arg3,
            max_total_cost : arg5,
            new_prices     : 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::pricing::prices(0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::supply::supply_values(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::supply_state<T0>(v5)), 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::alpha_bps(v6), 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::base_liquidity_param<T0>(v5), 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::decimals(v6)),
        };
        0x2::event::emit<Trade>(v7);
        (0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::mint_share<T0>(v0, arg3, arg4, arg7), arg2)
    }

    public fun buy_and_lock<T0>(arg0: &mut Market<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::locked_shares::LockedShares, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = load_data_mut<T0>(arg0);
        assert!(!0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::is_paused<T0>(v1), 15);
        let v2 = 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::expires_at<T0>(v1);
        assert!(0x1::option::is_some<u64>(&v2), 19);
        assert!(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::state<T0>(v1, arg4) == 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::state_active(), 0);
        let v3 = preview_lock_cost<T0>(v1, arg2);
        assert!(v3 <= arg3, 8);
        assert!(0x2::coin::value<T0>(&arg1) >= v3, 1);
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::deposit_lock<T0>(v1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v3, arg5)), v3);
        let v4 = 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::locked_shares::new(v0, v3, 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::mint_shares<T0>(v1, arg2, arg5), arg5);
        let v5 = LockBought{
            market_id    : v0,
            lock_id      : 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::locked_shares::id(&v4),
            cost         : v3,
            quantity     : arg2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<LockBought>(v5);
        (v4, arg1)
    }

    public fun claim_creator_balance<T0>(arg0: &mut Market<T0>, arg1: &CreatorCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.market_id == 0x2::object::uid_to_inner(&arg0.id), 4);
        let v0 = load_data_mut<T0>(arg0);
        assert!(!0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::is_paused<T0>(v0), 15);
        let v1 = 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::withdraw_creator_balance<T0>(v0);
        let v2 = BalanceClaimed{
            market_id   : 0x2::object::uid_to_inner(&arg0.id),
            is_protocol : false,
            amount      : 0x2::balance::value<T0>(&v1),
        };
        0x2::event::emit<BalanceClaimed>(v2);
        0x2::coin::from_balance<T0>(v1, arg2)
    }

    public fun claim_protocol_balance<T0>(arg0: &mut Market<T0>, arg1: &0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::config::ProtocolCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = load_data_mut<T0>(arg0);
        assert!(!0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::is_paused<T0>(v0), 15);
        let v1 = 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::withdraw_protocol_balance<T0>(v0);
        let v2 = BalanceClaimed{
            market_id   : 0x2::object::uid_to_inner(&arg0.id),
            is_protocol : true,
            amount      : 0x2::balance::value<T0>(&v1),
        };
        0x2::event::emit<BalanceClaimed>(v2);
        0x2::coin::from_balance<T0>(v1, arg2)
    }

    public fun create_market<T0, T1: drop>(arg0: &0x2::coin_registry::Currency<T0>, arg1: &0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::config::ProtocolConfig, arg2: T1, arg3: 0x1::option::Option<0x2::object::ID>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: vector<u8>, arg7: vector<vector<u8>>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (Market<T0>, CreatorCap) {
        let v0 = 0x1::vector::length<vector<u8>>(&arg7);
        assert!(v0 >= 2 && v0 < 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::config::max_outcomes_count(arg1), 14);
        assert!(0x1::vector::length<u8>(&arg6) <= 16384, 21);
        assert!(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::config::is_quote_allowed(arg1, 0x1::type_name::with_defining_ids<T0>()), 11);
        assert!(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::config::is_resolver_allowed(arg1, 0x1::type_name::with_defining_ids<T1>()), 20);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        let v2 = 0x1::option::destroy_with_default<u64>(arg4, v1);
        assert!(v2 >= v1, 6);
        if (0x1::option::is_some<u64>(&arg5)) {
            let v3 = 0x1::option::destroy_some<u64>(arg5);
            assert!(v3 > v2, 10);
            assert!(v3 - v2 >= 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::config::min_duration_ms(arg1), 10);
        } else {
            0x1::option::destroy_none<u64>(arg5);
        };
        let v4 = 0x2::object::new(arg9);
        let v5 = MarketCreated{
            market_id      : 0x2::object::uid_to_inner(&v4),
            oracle_id      : arg3,
            starts_at_ms   : v2,
            created_at_ms  : v1,
            expires_at_ms  : arg5,
            outcome_values : arg7,
        };
        0x2::event::emit<MarketCreated>(v5);
        let v6 = CreatorCap{
            id        : 0x2::derived_object::claim<vector<u8>>(&mut v4, b"CREATOR_CAP"),
            market_id : 0x2::object::uid_to_inner(&v4),
        };
        let v7 = Market<T0>{
            id    : v4,
            inner : 0x8256e107385261b483aad47fdbcf99b22706396d9f49b53a756ee4af0d11f977::versioned_object::create<0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::MarketDataV2<T0>>(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::current_version(), 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::create<T0>(&mut v4, 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::new_config<T0>(arg0, 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::config::trading_fee_bps(arg1), 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::config::creator_fee_share_bps(arg1), 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::config::locker_fee_share_bps(arg1), 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::config::vig_bps(arg1), v0), 0x1::type_name::with_defining_ids<T1>(), arg3, v2, arg5, arg6, 0x2::vec_set::from_keys<vector<u8>>(arg7), arg8), arg9),
        };
        (v7, v6)
    }

    public fun create_position<T0>(arg0: &mut Market<T0>, arg1: address) : 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::position::Position<T0> {
        let v0 = load_data<T0>(arg0);
        assert!(!0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::is_paused<T0>(v0), 15);
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::position::new<T0>(&mut arg0.id, arg1, 0x2::vec_set::length<vector<u8>>(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::outcome_values<T0>(v0)))
    }

    public fun expire_market<T0, T1: drop>(arg0: &mut Market<T0>, arg1: T1, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = load_data_mut<T0>(arg0);
        assert!(0x1::type_name::with_defining_ids<T1>() == 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::resolver_witness<T0>(v1), 17);
        assert!(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::state<T0>(v1, arg2) == 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::state_active(), 0);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::set_expires_at<T0>(v1, 0x1::option::some<u64>(v2));
        let v3 = MarketExpiredEarly{
            market_id              : v0,
            previous_expires_at_ms : 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::expires_at<T0>(v1),
            expired_at_ms          : v2,
        };
        0x2::event::emit<MarketExpiredEarly>(v3);
    }

    public fun keep_position<T0>(arg0: 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::position::Position<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::position::transfer<T0>(arg0, 0x2::tx_context::sender(arg1));
    }

    fun load_data<T0>(arg0: &mut Market<T0>) : &0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::MarketDataV2<T0> {
        maybe_upgrade<T0>(arg0);
        assert!(0x8256e107385261b483aad47fdbcf99b22706396d9f49b53a756ee4af0d11f977::versioned_object::version(&arg0.inner) == 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::current_version(), 9);
        0x8256e107385261b483aad47fdbcf99b22706396d9f49b53a756ee4af0d11f977::versioned_object::load_value<0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::MarketDataV2<T0>>(&arg0.inner)
    }

    fun load_data_mut<T0>(arg0: &mut Market<T0>) : &mut 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::MarketDataV2<T0> {
        maybe_upgrade<T0>(arg0);
        assert!(0x8256e107385261b483aad47fdbcf99b22706396d9f49b53a756ee4af0d11f977::versioned_object::version(&arg0.inner) == 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::current_version(), 9);
        0x8256e107385261b483aad47fdbcf99b22706396d9f49b53a756ee4af0d11f977::versioned_object::load_value_mut<0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::MarketDataV2<T0>>(&mut arg0.inner)
    }

    fun maybe_upgrade<T0>(arg0: &mut Market<T0>) {
        if (0x8256e107385261b483aad47fdbcf99b22706396d9f49b53a756ee4af0d11f977::versioned_object::version(&arg0.inner) == 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::current_version()) {
            return
        };
        let (v0, v1) = 0x8256e107385261b483aad47fdbcf99b22706396d9f49b53a756ee4af0d11f977::versioned_object::remove_value_for_upgrade<0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::MarketData<T0>>(&mut arg0.inner);
        0x8256e107385261b483aad47fdbcf99b22706396d9f49b53a756ee4af0d11f977::versioned_object::upgrade<0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::MarketDataV2<T0>>(&mut arg0.inner, 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::current_version(), 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::migrate_to_v2<T0>(&mut arg0.id, v0), v1);
    }

    public fun oracle_id<T0>(arg0: &mut Market<T0>) : 0x1::option::Option<0x2::object::ID> {
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::oracle_id<T0>(load_data<T0>(arg0))
    }

    public fun outcome_values<T0>(arg0: &mut Market<T0>) : &0x2::vec_set::VecSet<vector<u8>> {
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::outcome_values<T0>(load_data<T0>(arg0))
    }

    public fun pause_market<T0>(arg0: &mut Market<T0>, arg1: &0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::config::ProtocolCap, arg2: &0x2::clock::Clock) {
        let v0 = load_data_mut<T0>(arg0);
        assert!(!0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::is_paused<T0>(v0), 15);
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::set_paused<T0>(v0, true);
        let v1 = MarketPaused{
            market_id    : 0x2::object::uid_to_inner(&arg0.id),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<MarketPaused>(v1);
    }

    fun preview_cost<T0>(arg0: &0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::MarketDataV2<T0>, arg1: u64, arg2: u64) : (u64, u64) {
        assert!(arg1 < 0x2::vec_set::length<vector<u8>>(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::outcome_values<T0>(arg0)), 2);
        let v0 = 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::config<T0>(arg0);
        let v1 = 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::pricing::cost(arg1, arg2, 0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::supply::supply_values(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::supply_state<T0>(arg0)), 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::alpha_bps(v0), 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::base_liquidity_param<T0>(arg0), 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::decimals(v0));
        (v1, 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::u64::mul_div_up(v1, 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::trading_fee_bps(v0), 10000))
    }

    fun preview_lock_cost<T0>(arg0: &0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::MarketDataV2<T0>, arg1: u64) : u64 {
        let v0 = 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::config<T0>(arg0);
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::pricing::cost_all(0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::supply::supply_values(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::supply_state<T0>(arg0)), arg1, 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::alpha_bps(v0), 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::base_liquidity_param<T0>(arg0), 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::decimals(v0))
    }

    fun preview_payout<T0>(arg0: &0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::MarketDataV2<T0>, arg1: u64, arg2: u64) : (u64, u64) {
        assert!(arg1 < 0x2::vec_set::length<vector<u8>>(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::outcome_values<T0>(arg0)), 2);
        let v0 = 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::config<T0>(arg0);
        let v1 = 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::pricing::payout(arg1, arg2, 0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::supply::supply_values(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::supply_state<T0>(arg0)), 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::alpha_bps(v0), 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::base_liquidity_param<T0>(arg0), 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::decimals(v0));
        (v1, 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::u64::mul_div_up(v1, 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::trading_fee_bps(v0), 10000))
    }

    public fun redeem<T0>(arg0: &mut Market<T0>, arg1: &mut 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::position::Position<T0>, arg2: 0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::share::Share, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        assert!(0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::share::belongs_to_market(&arg2, v0), 5);
        assert!(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::position::market_id<T0>(arg1) == v0, 7);
        let v1 = load_data_mut<T0>(arg0);
        assert!(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::state<T0>(v1, arg3) == 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::state_resolved(), 3);
        let v2 = 0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::share::value(&arg2);
        let v3 = 0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::share::outcome_index(&arg2);
        let v4 = 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::resolution<T0>(v1);
        if (0x1::option::is_some<0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::Resolution>(v4)) {
            assert!(v3 == 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::outcome_index(0x1::option::borrow<0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::Resolution>(v4)), 2);
        };
        let v5 = 0x2::clock::timestamp_ms(arg3);
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::position::apply_redeem<T0>(arg1, v3, v2, v5);
        let v6 = Redeem{
            market_id     : v0,
            position_id   : 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::position::id<T0>(arg1),
            amount        : v2,
            payout        : v2,
            timestamp_ms  : v5,
            outcome_index : v3,
        };
        0x2::event::emit<Redeem>(v6);
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::burn_share<T0>(v1, arg2);
        0x2::coin::from_balance<T0>(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::redeem<T0>(v1, v2), arg4)
    }

    public fun redeem_lock<T0>(arg0: &mut Market<T0>, arg1: 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::locked_shares::LockedShares, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::locked_shares::unlock(arg1);
        let v3 = v2;
        assert!(0x2::object::uid_to_inner(&arg0.id) == v0, 18);
        let v4 = load_data_mut<T0>(arg0);
        assert!(!0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::is_paused<T0>(v4), 15);
        assert!(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::state<T0>(v4, arg2) == 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::state_resolved(), 0);
        let v5 = 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::outcome_index(0x1::option::borrow<0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::Resolution>(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::resolution<T0>(v4)));
        let v6 = 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::redeem<T0>(v4, 0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::share::value(0x1::vector::borrow<0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::share::Share>(&v3, v5)));
        let v7 = 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::locker_share_balance<T0>(v4, v1);
        let v8 = LockRedeemed{
            market_id        : v0,
            lock_id          : 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::locked_shares::id(&arg1),
            payout           : 0x2::balance::value<T0>(&v6),
            timestamp_ms     : 0x2::clock::timestamp_ms(arg2),
            outcome_index    : v5,
            locker_fee_share : 0x2::balance::value<T0>(&v7),
        };
        0x2::event::emit<LockRedeemed>(v8);
        0x2::balance::join<T0>(&mut v6, v7);
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::burn_shares<T0>(v4, v3);
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::reduce_total_lock_amount<T0>(v4, v1);
        0x2::coin::from_balance<T0>(v6, arg3)
    }

    public fun redeem_void<T0>(arg0: &mut Market<T0>, arg1: &mut 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::position::Position<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        assert!(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::position::market_id<T0>(arg1) == v0, 7);
        let v1 = load_data_mut<T0>(arg0);
        assert!(!0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::position::is_closed<T0>(arg1), 22);
        assert!(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::is_void<T0>(v1), 25);
        let v2 = 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::position::net_spent_without_fees<T0>(arg1);
        assert!(0x2::balance::value<T0>(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::settlement_balance<T0>(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::balances<T0>(v1))) >= v2, 23);
        let v3 = 0x2::clock::timestamp_ms(arg2);
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::position::apply_void_refund<T0>(arg1, v2, v3);
        let v4 = VoidRedeemed{
            market_id    : v0,
            position_id  : 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::position::id<T0>(arg1),
            amount       : v2,
            timestamp_ms : v3,
        };
        0x2::event::emit<VoidRedeemed>(v4);
        0x2::coin::from_balance<T0>(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::redeem_void<T0>(v1, v2), arg3)
    }

    public fun redeem_void_lock<T0>(arg0: &mut Market<T0>, arg1: 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::locked_shares::LockedShares, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::locked_shares::unlock(arg1);
        assert!(0x2::object::uid_to_inner(&arg0.id) == v0, 18);
        let v3 = load_data_mut<T0>(arg0);
        assert!(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::is_void<T0>(v3), 25);
        assert!(0x2::balance::value<T0>(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::settlement_balance<T0>(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::balances<T0>(v3))) >= v1, 23);
        let v4 = LockVoidRedeemed{
            market_id    : v0,
            lock_id      : 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::locked_shares::id(&arg1),
            payout       : v1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<LockVoidRedeemed>(v4);
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::burn_shares<T0>(v3, v2);
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::reduce_total_lock_amount<T0>(v3, v1);
        0x2::coin::from_balance<T0>(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::redeem_void<T0>(v3, v1), arg3)
    }

    public(friend) fun resolve<T0>(arg0: &mut Market<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = load_data_mut<T0>(arg0);
        let v1 = 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::supply_state<T0>(v0);
        assert!(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::state<T0>(v0, arg2) == 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::state_expired(), 0);
        assert!(0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::supply::is_state_cap(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::supply_cap<T0>(v0), v1), 12);
        assert!(arg1 < 0x2::vec_set::length<vector<u8>>(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::outcome_values<T0>(v0)), 2);
        let v2 = v0;
        let v3 = 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::config<T0>(v2);
        let v4 = 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::pricing::prices(0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::supply::supply_values(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::supply_state<T0>(v2)), 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::alpha_bps(v3), 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::base_liquidity_param<T0>(v2), 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::decimals(v3));
        let v5 = 0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::supply::supply_values(v1);
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::resolve<T0>(v0, v4, arg1, *0x1::vector::borrow<u64>(&v5, arg1), arg2);
        let v6 = MarketResolved{
            market_id      : 0x2::object::uid_to_inner(&arg0.id),
            outcome_index  : arg1,
            resolved_at_ms : 0x2::clock::timestamp_ms(arg2),
            final_prices   : v4,
        };
        0x2::event::emit<MarketResolved>(v6);
    }

    public fun resolve_market<T0, T1: drop>(arg0: &mut Market<T0>, arg1: u64, arg2: T1, arg3: &0x2::clock::Clock) {
        let v0 = load_data_mut<T0>(arg0);
        assert!(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::resolver_witness<T0>(v0) == 0x1::type_name::with_defining_ids<T1>(), 17);
        resolve<T0>(arg0, arg1, arg3);
    }

    public(friend) fun resolver_witness<T0>(arg0: &mut Market<T0>) : 0x1::type_name::TypeName {
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::resolver_witness<T0>(load_data<T0>(arg0))
    }

    public fun resume_market<T0>(arg0: &mut Market<T0>, arg1: &0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::config::ProtocolCap, arg2: &0x2::clock::Clock) {
        let v0 = load_data_mut<T0>(arg0);
        assert!(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::is_paused<T0>(v0), 16);
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::set_paused<T0>(v0, false);
        let v1 = MarketResumed{
            market_id    : 0x2::object::uid_to_inner(&arg0.id),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<MarketResumed>(v1);
    }

    public fun sell<T0>(arg0: &mut Market<T0>, arg1: &mut 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::position::Position<T0>, arg2: 0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::share::Share, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::share::belongs_to_market(&arg2, 0x2::object::uid_to_inner(&arg0.id)), 5);
        assert!(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::position::market_id<T0>(arg1) == 0x2::object::uid_to_inner(&arg0.id), 7);
        let v0 = 0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::share::outcome_index(&arg2);
        let v1 = load_data_mut<T0>(arg0);
        assert!(!0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::is_paused<T0>(v1), 15);
        assert!(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::state<T0>(v1, arg4) == 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::state_active(), 0);
        assert!(v0 < 0x2::vec_set::length<vector<u8>>(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::outcome_values<T0>(v1)), 2);
        let v2 = 0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::share::value(&arg2);
        let (v3, v4) = preview_payout<T0>(v1, v0, v2);
        let v5 = 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::withdraw<T0>(v1, v3, v4);
        assert!(0x2::balance::value<T0>(&v5) >= arg3, 8);
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::burn_share<T0>(v1, arg2);
        let v6 = 0x2::clock::timestamp_ms(arg4);
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::position::apply_sell<T0>(arg1, v0, v2, 0x2::balance::value<T0>(&v5), v4, v6);
        let v7 = v1;
        let v8 = 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::config<T0>(v7);
        let v9 = Trade{
            market_id      : 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::position::market_id<T0>(arg1),
            position_id    : 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::position::id<T0>(arg1),
            amount         : 0x2::balance::value<T0>(&v5),
            is_buy         : false,
            quantity       : v2,
            fee_amount     : v4,
            min_payout     : arg3,
            timestamp_ms   : v6,
            outcome_index  : v0,
            max_total_cost : 0,
            new_prices     : 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::pricing::prices(0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::supply::supply_values(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::supply_state<T0>(v7)), 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::alpha_bps(v8), 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::base_liquidity_param<T0>(v7), 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::decimals(v8)),
        };
        0x2::event::emit<Trade>(v9);
        0x2::coin::from_balance<T0>(v5, arg5)
    }

    public fun set_oracle_id<T0, T1: drop>(arg0: &mut Market<T0>, arg1: T1, arg2: 0x2::object::ID) {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = load_data_mut<T0>(arg0);
        assert!(0x1::type_name::with_defining_ids<T1>() == 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::resolver_witness<T0>(v1), 17);
        let v2 = OracleIDUpdated{
            market_id : v0,
            oracle_id : arg2,
        };
        0x2::event::emit<OracleIDUpdated>(v2);
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::set_oracle_id<T0>(v1, arg2);
    }

    public fun set_trading_fee_bps<T0>(arg0: &mut Market<T0>, arg1: &0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::config::ProtocolCap, arg2: u64) {
        let v0 = load_data_mut<T0>(arg0);
        assert!(arg2 <= 5000, 24);
        assert!(!0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::is_paused<T0>(v0), 15);
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::set_trading_fee_bps<T0>(v0, arg2);
    }

    public fun state_active() : 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::State {
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::state_active()
    }

    public fun state_expired() : 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::State {
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::state_expired()
    }

    public fun state_paused() : 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::State {
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::state_paused()
    }

    public fun state_pending() : 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::State {
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::state_pending()
    }

    public fun state_resolved() : 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::State {
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::state_resolved()
    }

    public fun transfer_position<T0>(arg0: 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::position::Position<T0>, arg1: address) {
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::position::transfer<T0>(arg0, arg1);
    }

    public fun void_market<T0, T1: drop>(arg0: &mut Market<T0>, arg1: T1, arg2: &0x2::clock::Clock) {
        let v0 = load_data_mut<T0>(arg0);
        assert!(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::state<T0>(v0, arg2) == 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::state_expired(), 0);
        assert!(0x1::type_name::with_defining_ids<T1>() == 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::resolver_witness<T0>(v0), 17);
        0x2::balance::join<T0>(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::settlement_balance_mut<T0>(v0), 0x2::balance::withdraw_all<T0>(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::pool_balance_mut<T0>(v0)));
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::void_market<T0>(v0);
        let v1 = v0;
        let v2 = 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::config<T0>(v1);
        let v3 = MarketVoided{
            market_id    : 0x2::object::uid_to_inner(&arg0.id),
            voided_at_ms : 0x2::clock::timestamp_ms(arg2),
            final_prices : 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::pricing::prices(0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::supply::supply_values(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::supply_state<T0>(v1)), 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::alpha_bps(v2), 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::base_liquidity_param<T0>(v1), 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market_data::decimals(v2)),
        };
        0x2::event::emit<MarketVoided>(v3);
    }

    // decompiled from Move bytecode v6
}

