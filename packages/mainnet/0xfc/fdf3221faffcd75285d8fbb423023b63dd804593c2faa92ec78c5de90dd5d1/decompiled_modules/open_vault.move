module 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault {
    struct Depth has copy, drop, store {
        ms: u64,
        liquidity: u128,
    }

    struct OpenVault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        book: 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Book<T0, T1>,
        total_shares: u64,
        perf_fee_bps: u64,
        max_pool_share_bps: u64,
        max_deposit_dev_bps: u64,
        daily_deposit_bps: u64,
        min_hold_ms: u64,
        depth: vector<Depth>,
        depth_next: u64,
        deposits: 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::limits::Turnover,
        opened_ms: u64,
        total_deposited_t: u64,
        total_withdrawn_t: u64,
        total_withdrawn_q: u64,
        total_fees_t: u64,
        total_fees_q: u64,
        total_perf_t: u64,
        total_perf_q: u64,
    }

    struct Deposit<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        shares: u64,
        deposited_ms: u64,
    }

    struct OpenVaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        token: 0x1::ascii::String,
        quote: 0x1::ascii::String,
        tick_spacing: u32,
        perf_fee_bps: u64,
        max_pool_share_bps: u64,
        min_hold_ms: u64,
        venue: u8,
    }

    struct Observed has copy, drop {
        vault_id: 0x2::object::ID,
        sqrt_price: u128,
        liquidity: u128,
        timestamp_ms: u64,
    }

    struct Deposited has copy, drop {
        vault_id: 0x2::object::ID,
        deposit_id: 0x2::object::ID,
        owner: address,
        tokens: u64,
        value: u64,
        vault_value: u64,
        sqrt_price: u128,
        shares: u64,
        total_shares: u64,
    }

    struct Withdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        deposit_id: 0x2::object::ID,
        owner: address,
        shares: u64,
        tokens: u64,
        quote: u64,
        total_shares: u64,
    }

    struct DepositSplit has copy, drop {
        vault_id: 0x2::object::ID,
        from_id: 0x2::object::ID,
        new_id: 0x2::object::ID,
        shares: u64,
    }

    struct DepositsMerged has copy, drop {
        vault_id: 0x2::object::ID,
        into_id: 0x2::object::ID,
        from_id: 0x2::object::ID,
        shares: u64,
        deposited_ms: u64,
    }

    struct FeesCollected has copy, drop {
        vault_id: 0x2::object::ID,
        fee_t: u64,
        fee_q: u64,
        perf_t: u64,
        perf_q: u64,
    }

    struct RangeAdded has copy, drop {
        vault_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        lower_tick_bits: u32,
        upper_tick_bits: u32,
        tokens: u64,
        quote: u64,
    }

    struct RangeRemoved has copy, drop {
        vault_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        liquidity: u128,
        tokens: u64,
        quote: u64,
        fee_t: u64,
        fee_q: u64,
        closed: bool,
    }

    struct Rebalanced has copy, drop {
        vault_id: 0x2::object::ID,
        ref_sqrt_price: u128,
        value: u64,
        added_quote: u64,
        turnover_24h: u64,
        ranges: u64,
        timestamp_ms: u64,
    }

    struct RangeRetired has copy, drop {
        vault_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
    }

    struct RangeClosed has copy, drop {
        vault_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
    }

    struct RewardCollected has copy, drop {
        vault_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        coin: 0x1::ascii::String,
        amount: u64,
        to: address,
    }

    struct RebalancePauseChanged has copy, drop {
        vault_id: 0x2::object::ID,
        paused: bool,
    }

    public fun split<T0, T1>(arg0: &mut Deposit<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Deposit<T0, T1> {
        assert!(arg1 > 0 && arg1 < arg0.shares, 505);
        arg0.shares = arg0.shares - arg1;
        let v0 = Deposit<T0, T1>{
            id           : 0x2::object::new(arg2),
            vault_id     : arg0.vault_id,
            shares       : arg1,
            deposited_ms : arg0.deposited_ms,
        };
        let v1 = DepositSplit{
            vault_id : arg0.vault_id,
            from_id  : 0x2::object::id<Deposit<T0, T1>>(arg0),
            new_id   : 0x2::object::id<Deposit<T0, T1>>(&v0),
            shares   : arg1,
        };
        0x2::event::emit<DepositSplit>(v1);
        v0
    }

    fun new<T0, T1>(arg0: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::OpenParams, arg1: u8, arg2: bool, arg3: u32, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : OpenVault<T0, T1> {
        OpenVault<T0, T1>{
            id                  : 0x2::object::new(arg5),
            book                : 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::new_on<T0, T1>(arg1, arg2, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::open_pool_id(arg0), 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::open_limits(arg0), arg3, 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>()),
            total_shares        : 0,
            perf_fee_bps        : 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::perf_fee_bps(arg0),
            max_pool_share_bps  : 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::max_pool_share_bps(arg0),
            max_deposit_dev_bps : 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::max_deposit_dev_bps(arg0),
            daily_deposit_bps   : 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::daily_deposit_bps(arg0),
            min_hold_ms         : 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::min_hold_ms(arg0),
            depth               : 0x1::vector::empty<Depth>(),
            depth_next          : 0,
            deposits            : 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::limits::new_turnover(),
            opened_ms           : arg4,
            total_deposited_t   : 0,
            total_withdrawn_t   : 0,
            total_withdrawn_q   : 0,
            total_fees_t        : 0,
            total_fees_q        : 0,
            total_perf_t        : 0,
            total_perf_q        : 0,
        }
    }

    public fun add<T0, T1>(arg0: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Ticket, arg1: &mut OpenVault<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: u32, arg5: u32, arg6: u64, arg7: bool, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_ticket(arg0, &arg1.id);
        let v0 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::add<T0, T1>(arg0, &mut arg1.id, &mut arg1.book, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        emit_added(0x2::object::id<OpenVault<T0, T1>>(arg1), &v0);
    }

    public fun begin<T0, T1>(arg0: &mut OpenVault<T0, T1>, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Ticket {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::assert_version(arg1);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::assert_keeper(arg1, arg4);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::begin<T0, T1>(&arg0.id, &mut arg0.book, arg2, 0x2::clock::timestamp_ms(arg3))
    }

    public fun close_retired<T0, T1>(arg0: &mut OpenVault<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        let v0 = RangeClosed{
            vault_id    : 0x2::object::id<OpenVault<T0, T1>>(arg0),
            position_id : 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::close_retired<T0, T1>(&mut arg0.id, &mut arg0.book, arg1, arg2, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::retired_index<T0, T1>(&arg0.book, arg3), arg4),
        };
        0x2::event::emit<RangeClosed>(v0);
    }

    public fun collect_reward<T0, T1, T2>(arg0: &mut OpenVault<T0, T1>, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::holds<T0, T1>(&arg0.book, arg4), 512);
        let v0 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::collect_reward<T0, T1, T2>(&mut arg0.id, &arg0.book, arg2, arg3, arg4, arg5);
        let v1 = 0x2::balance::value<T2>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T2>(v0);
            return
        };
        let v2 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::fee_recipient(arg1);
        let v3 = RewardCollected{
            vault_id    : 0x2::object::id<OpenVault<T0, T1>>(arg0),
            position_id : arg4,
            coin        : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T2>()),
            amount      : v1,
            to          : v2,
        };
        0x2::event::emit<RewardCollected>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg6), v2);
    }

    fun composition<T0, T1>(arg0: &OpenVault<T0, T1>, arg1: u128) : (u64, u64) {
        if (0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::venue<T0, T1>(&arg0.book) == 1) {
            let (v2, v3) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book_cetus::amounts<T0, T1>(&arg0.id, &arg0.book, arg1);
            (0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::limits::token_value(v2, arg1), v3)
        } else {
            0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::composition<T0, T1>(&arg0.id, &arg0.book, arg1)
        }
    }

    public fun finish<T0, T1>(arg0: 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Ticket, arg1: &mut OpenVault<T0, T1>) {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_ticket(&arg0, &arg1.id);
        let v0 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::finish<T0, T1>(arg0, &mut arg1.book);
        let (v1, v2, v3, v4, v5, v6) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::finished_fields(&v0);
        let v7 = Rebalanced{
            vault_id       : 0x2::object::id<OpenVault<T0, T1>>(arg1),
            ref_sqrt_price : v1,
            value          : v2,
            added_quote    : v3,
            turnover_24h   : v4,
            ranges         : v5,
            timestamp_ms   : v6,
        };
        0x2::event::emit<Rebalanced>(v7);
    }

    public fun idle<T0, T1>(arg0: &OpenVault<T0, T1>) : (u64, u64) {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::idle<T0, T1>(&arg0.book)
    }

    public fun last_rebalance_ms<T0, T1>(arg0: &OpenVault<T0, T1>) : u64 {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::last_rebalance_ms<T0, T1>(&arg0.book)
    }

    public fun limits<T0, T1>(arg0: &OpenVault<T0, T1>) : 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Limits {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::limits<T0, T1>(&arg0.book)
    }

    entry fun observe<T0, T1>(arg0: &mut OpenVault<T0, T1>, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::assert_version(arg1);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::assert_keeper(arg1, arg4);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_pool_id<T0, T1>(&arg0.book, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), 0);
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::coin_reserves<T0, T1>(arg2);
        observe_reserves<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg3), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg2), v0, v1);
    }

    public fun pool_id<T0, T1>(arg0: &OpenVault<T0, T1>) : 0x2::object::ID {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::pool_id<T0, T1>(&arg0.book)
    }

    public fun range_count<T0, T1>(arg0: &OpenVault<T0, T1>) : u64 {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::range_count<T0, T1>(&arg0.book)
    }

    public fun ranges<T0, T1>(arg0: &OpenVault<T0, T1>) : vector<0x2::object::ID> {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::ranges<T0, T1>(&arg0.book)
    }

    public fun rebalance_paused<T0, T1>(arg0: &OpenVault<T0, T1>) : bool {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::rebalance_paused<T0, T1>(&arg0.book)
    }

    public fun reclaim_crossed<T0, T1>(arg0: &mut OpenVault<T0, T1>, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::reclaim_crossed<T0, T1>(&mut arg0.id, &mut arg0.book, arg2, arg3, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::range_index<T0, T1>(&arg0.book, arg4), arg5);
        let v5 = v0;
        keep_removed<T0, T1>(arg0, arg1, &v5, v1, v2, v3, v4, arg6);
    }

    public fun remove<T0, T1>(arg0: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Ticket, arg1: &mut OpenVault<T0, T1>, arg2: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: 0x2::object::ID, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::remove<T0, T1>(arg0, &mut arg1.id, &mut arg1.book, arg3, arg4, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::range_index<T0, T1>(&arg1.book, arg5), arg6, arg7);
        let v5 = v0;
        keep_removed<T0, T1>(arg1, arg2, &v5, v1, v2, v3, v4, arg8);
    }

    public fun retired<T0, T1>(arg0: &OpenVault<T0, T1>) : vector<0x2::object::ID> {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::retired<T0, T1>(&arg0.book)
    }

    public fun set_rebalance_paused<T0, T1>(arg0: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::AdminCap, arg1: &mut OpenVault<T0, T1>, arg2: bool) {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::set_rebalance_paused<T0, T1>(&mut arg1.book, arg2);
        let v0 = RebalancePauseChanged{
            vault_id : 0x2::object::id<OpenVault<T0, T1>>(arg1),
            paused   : arg2,
        };
        0x2::event::emit<RebalancePauseChanged>(v0);
    }

    public fun turnover_24h<T0, T1>(arg0: &OpenVault<T0, T1>, arg1: u64) : u64 {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::turnover_24h<T0, T1>(&arg0.book, arg1)
    }

    public(friend) fun assert_can_deposit<T0, T1>(arg0: &OpenVault<T0, T1>, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config) {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::assert_version(arg1);
        assert!(!0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::paused(arg1), 503);
        let v0 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::open_params<T0, T1>(arg1);
        assert!(0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::open_enabled(&v0), 501);
        assert!(!0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::rebalance_paused<T0, T1>(&arg0.book), 503);
    }

    public(friend) fun book_ref<T0, T1>(arg0: &OpenVault<T0, T1>) : &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Book<T0, T1> {
        &arg0.book
    }

    public(friend) fun check_withdraw<T0, T1>(arg0: &OpenVault<T0, T1>, arg1: &Deposit<T0, T1>, arg2: u64) {
        assert!(arg1.vault_id == 0x2::object::id<OpenVault<T0, T1>>(arg0), 500);
        assert!(arg2 >= arg1.deposited_ms + arg0.min_hold_ms, 506);
    }

    public fun collect<T0, T1>(arg0: &mut OpenVault<T0, T1>, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_pool_id<T0, T1>(&arg0.book, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3), 0);
        collect_all<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    fun collect_all<T0, T1>(arg0: &mut OpenVault<T0, T1>, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::range_count<T0, T1>(&arg0.book);
        if (v0 == 0) {
            return
        };
        let v1 = 0x2::balance::zero<T0>();
        let v2 = 0x2::balance::zero<T1>();
        let v3 = 0;
        while (v3 < v0) {
            let (v4, v5) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::collect_range_fees<T0, T1>(&mut arg0.id, &arg0.book, arg2, arg3, v3, arg4);
            0x2::balance::join<T0>(&mut v1, v4);
            0x2::balance::join<T1>(&mut v2, v5);
            v3 = v3 + 1;
        };
        let (v6, v7) = take_fees<T0, T1>(arg0, v1, v2);
        pay_fees<T0, T1>(v6, v7, arg1, arg5);
    }

    public fun deposit<T0, T1>(arg0: &mut OpenVault<T0, T1>, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Deposit<T0, T1> {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_pool_id<T0, T1>(&arg0.book, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3), 0);
        assert_can_deposit<T0, T1>(arg0, arg1);
        collect_all<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6);
        deposit_at<T0, T1>(arg0, 0x2::coin::into_balance<T0>(arg4), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg3), 0x2::clock::timestamp_ms(arg5), arg6)
    }

    public(friend) fun deposit_at<T0, T1>(arg0: &mut OpenVault<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u128, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : Deposit<T0, T1> {
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 > 0, 504);
        let v1 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::reference<T0, T1>(&arg0.book, arg4);
        assert!(0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::limits::within_deviation(arg2, v1, arg0.max_deposit_dev_bps), 507);
        let v2 = if (arg2 < v1) {
            arg2
        } else {
            v1
        };
        let v3 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::limits::token_value(v0, v2);
        assert!(v3 > 0, 511);
        let (v4, v5) = composition<T0, T1>(arg0, v2);
        let v6 = (v4 as u128) + (v5 as u128);
        let v7 = if (v6 == 0) {
            0
        } else {
            (((v3 as u128) * (v5 as u128) / v6 * (arg3 as u128) / 1000000) as u64)
        };
        let v8 = if (arg0.total_shares == 0) {
            v3
        } else {
            assert!(v6 > 0, 511);
            ((((v3 - v7) as u128) * (arg0.total_shares as u128) / v6) as u64)
        };
        assert!(v8 > 0, 504);
        let v9 = max_size<T0, T1>(arg0, v2, arg4);
        assert!(v6 + (v3 as u128) <= v9, 508);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::limits::add_turnover(&mut arg0.deposits, arg4, v3);
        assert!((0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::limits::turnover(&arg0.deposits, arg4) as u256) * (10000 as u256) <= (v9 as u256) * (arg0.daily_deposit_bps as u256), 509);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::join_t<T0, T1>(&mut arg0.book, arg1);
        arg0.total_shares = arg0.total_shares + v8;
        arg0.total_deposited_t = arg0.total_deposited_t + v0;
        let v10 = Deposit<T0, T1>{
            id           : 0x2::object::new(arg5),
            vault_id     : 0x2::object::id<OpenVault<T0, T1>>(arg0),
            shares       : v8,
            deposited_ms : arg4,
        };
        let v11 = if (v6 > 18446744073709551615) {
            18446744073709551615
        } else {
            v6
        };
        let v12 = Deposited{
            vault_id     : 0x2::object::id<OpenVault<T0, T1>>(arg0),
            deposit_id   : 0x2::object::id<Deposit<T0, T1>>(&v10),
            owner        : 0x2::tx_context::sender(arg5),
            tokens       : v0,
            value        : v3,
            vault_value  : (v11 as u64),
            sqrt_price   : v2,
            shares       : v8,
            total_shares : arg0.total_shares,
        };
        0x2::event::emit<Deposited>(v12);
        v10
    }

    public fun deposit_shares<T0, T1>(arg0: &Deposit<T0, T1>) : u64 {
        arg0.shares
    }

    public fun deposit_vault_id<T0, T1>(arg0: &Deposit<T0, T1>) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun deposited_ms<T0, T1>(arg0: &Deposit<T0, T1>) : u64 {
        arg0.deposited_ms
    }

    public fun deposits_24h<T0, T1>(arg0: &OpenVault<T0, T1>, arg1: u64) : u64 {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::limits::turnover(&arg0.deposits, arg1)
    }

    public(friend) fun emit_added(arg0: 0x2::object::ID, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Added) {
        let (v0, v1, v2, v3, v4) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::added_fields(arg1);
        let v5 = RangeAdded{
            vault_id        : arg0,
            position_id     : v0,
            lower_tick_bits : v1,
            upper_tick_bits : v2,
            tokens          : v3,
            quote           : v4,
        };
        0x2::event::emit<RangeAdded>(v5);
    }

    public(friend) fun emit_closed<T0, T1>(arg0: &OpenVault<T0, T1>, arg1: 0x2::object::ID) {
        let v0 = RangeClosed{
            vault_id    : 0x2::object::id<OpenVault<T0, T1>>(arg0),
            position_id : arg1,
        };
        0x2::event::emit<RangeClosed>(v0);
    }

    public(friend) fun emit_removed(arg0: 0x2::object::ID, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Removed) {
        let (v0, v1, v2, v3, v4, v5, v6, v7) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::removed_fields(arg1);
        if (v7) {
            let v8 = RangeRetired{
                vault_id    : arg0,
                position_id : v0,
            };
            0x2::event::emit<RangeRetired>(v8);
        };
        let v9 = RangeRemoved{
            vault_id    : arg0,
            position_id : v0,
            liquidity   : v1,
            tokens      : v2,
            quote       : v3,
            fee_t       : v4,
            fee_q       : v5,
            closed      : v6,
        };
        0x2::event::emit<RangeRemoved>(v9);
    }

    public(friend) fun finish_withdraw<T0, T1>(arg0: &mut OpenVault<T0, T1>, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (arg2 == arg3) {
            let (v0, v1) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::idle<T0, T1>(&arg0.book);
            0x2::balance::join<T0>(&mut arg4, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::split_t<T0, T1>(&mut arg0.book, v0));
            0x2::balance::join<T1>(&mut arg5, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::split_q<T0, T1>(&mut arg0.book, v1));
        };
        arg0.total_shares = arg3 - arg2;
        let v2 = 0x2::balance::value<T0>(&arg4);
        let v3 = 0x2::balance::value<T1>(&arg5);
        arg0.total_withdrawn_t = arg0.total_withdrawn_t + v2;
        arg0.total_withdrawn_q = arg0.total_withdrawn_q + v3;
        let v4 = Withdrawn{
            vault_id     : 0x2::object::id<OpenVault<T0, T1>>(arg0),
            deposit_id   : arg1,
            owner        : 0x2::tx_context::sender(arg6),
            shares       : arg2,
            tokens       : v2,
            quote        : v3,
            total_shares : arg0.total_shares,
        };
        0x2::event::emit<Withdrawn>(v4);
        (0x2::coin::from_balance<T0>(arg4, arg6), 0x2::coin::from_balance<T1>(arg5, arg6))
    }

    public(friend) fun keep_removed<T0, T1>(arg0: &mut OpenVault<T0, T1>, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg2: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Removed, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: 0x2::balance::Balance<T0>, arg6: 0x2::balance::Balance<T1>, arg7: &mut 0x2::tx_context::TxContext) {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::join_t<T0, T1>(&mut arg0.book, arg3);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::join_q<T0, T1>(&mut arg0.book, arg4);
        emit_removed(0x2::object::id<OpenVault<T0, T1>>(arg0), arg2);
        let (v0, v1) = take_fees<T0, T1>(arg0, arg5, arg6);
        pay_fees<T0, T1>(v0, v1, arg1, arg7);
    }

    fun max_size<T0, T1>(arg0: &OpenVault<T0, T1>, arg1: u128, arg2: u64) : u128 {
        let v0 = (median_depth<T0, T1>(arg0, arg2) as u256) * (arg0.max_pool_share_bps as u256) / (10000 as u256);
        let v1 = 340282366920938463463374607431768211455;
        if (v0 > (v1 as u256)) {
            v1
        } else {
            (v0 as u128)
        }
    }

    public fun max_size_at<T0, T1>(arg0: &OpenVault<T0, T1>, arg1: u128, arg2: u64) : u128 {
        max_size<T0, T1>(arg0, arg1, arg2)
    }

    fun median_depth<T0, T1>(arg0: &OpenVault<T0, T1>, arg1: u64) : u128 {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<Depth>(&arg0.depth)) {
            let v2 = 0x1::vector::borrow<Depth>(&arg0.depth, v1);
            if (v2.ms + 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::limits::ref_window_ms() >= arg1 && v2.ms <= arg1) {
                0x1::vector::push_back<u128>(&mut v0, v2.liquidity);
                let v3 = 0x1::vector::length<u128>(&v0) - 1;
                while (v3 > 0 && *0x1::vector::borrow<u128>(&v0, v3 - 1) > v2.liquidity) {
                    0x1::vector::swap<u128>(&mut v0, v3 - 1, v3);
                    v3 = v3 - 1;
                };
            };
            v1 = v1 + 1;
        };
        let v4 = 0x1::vector::length<u128>(&v0);
        assert!(v4 >= 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::limits::min_observations(), 510);
        if (v4 % 2 == 1) {
            *0x1::vector::borrow<u128>(&v0, v4 / 2)
        } else {
            *0x1::vector::borrow<u128>(&v0, v4 / 2 - 1) / 2 + *0x1::vector::borrow<u128>(&v0, v4 / 2) / 2
        }
    }

    public fun merge<T0, T1>(arg0: &mut Deposit<T0, T1>, arg1: Deposit<T0, T1>) {
        let Deposit {
            id           : v0,
            vault_id     : v1,
            shares       : v2,
            deposited_ms : v3,
        } = arg1;
        let v4 = v0;
        assert!(v1 == arg0.vault_id, 500);
        arg0.shares = arg0.shares + v2;
        if (v3 > arg0.deposited_ms) {
            arg0.deposited_ms = v3;
        };
        let v5 = DepositsMerged{
            vault_id     : v1,
            into_id      : 0x2::object::id<Deposit<T0, T1>>(arg0),
            from_id      : 0x2::object::uid_to_inner(&v4),
            shares       : v2,
            deposited_ms : arg0.deposited_ms,
        };
        0x2::event::emit<DepositsMerged>(v5);
        0x2::object::delete(v4);
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    fun observe_at<T0, T1>(arg0: &mut OpenVault<T0, T1>, arg1: u64, arg2: u128, arg3: u128) {
        let v0 = Depth{
            ms        : arg1,
            liquidity : arg3,
        };
        if (0x1::vector::length<Depth>(&arg0.depth) < 32) {
            0x1::vector::push_back<Depth>(&mut arg0.depth, v0);
        } else {
            *0x1::vector::borrow_mut<Depth>(&mut arg0.depth, arg0.depth_next) = v0;
        };
        arg0.depth_next = (arg0.depth_next + 1) % 32;
        let v1 = Observed{
            vault_id     : 0x2::object::id<OpenVault<T0, T1>>(arg0),
            sqrt_price   : 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::observe<T0, T1>(&mut arg0.book, arg1, arg2),
            liquidity    : arg3,
            timestamp_ms : arg1,
        };
        0x2::event::emit<Observed>(v1);
    }

    public(friend) fun observe_reserves<T0, T1>(arg0: &mut OpenVault<T0, T1>, arg1: u64, arg2: u128, arg3: u64, arg4: u64) {
        observe_at<T0, T1>(arg0, arg1, arg2, (arg4 as u128) + (0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::limits::token_value(arg3, arg2) as u128));
    }

    public fun open<T0, T1>(arg0: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        open_on<T0, T1>(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1), 0, false, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg1), arg2, arg3);
    }

    public(friend) fun open_on<T0, T1>(arg0: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg1: 0x2::object::ID, arg2: u8, arg3: bool, arg4: u32, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::assert_version(arg0);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::assert_keeper(arg0, arg6);
        assert!(!0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::paused(arg0), 503);
        let v0 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::open_params<T0, T1>(arg0);
        assert!(0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::open_enabled(&v0), 501);
        assert!(arg1 == 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::open_pool_id(&v0), 502);
        let v1 = new<T0, T1>(&v0, arg2, arg3, arg4, 0x2::clock::timestamp_ms(arg5), arg6);
        let v2 = 0x2::object::id<OpenVault<T0, T1>>(&v1);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::register_open_vault<T0, T1>(arg0, v2);
        let v3 = OpenVaultCreated{
            vault_id           : v2,
            pool_id            : arg1,
            token              : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            quote              : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>()),
            tick_spacing       : arg4,
            perf_fee_bps       : v1.perf_fee_bps,
            max_pool_share_bps : v1.max_pool_share_bps,
            min_hold_ms        : v1.min_hold_ms,
            venue              : arg2,
        };
        0x2::event::emit<OpenVaultCreated>(v3);
        0x2::transfer::share_object<OpenVault<T0, T1>>(v1);
    }

    public fun opened_ms<T0, T1>(arg0: &OpenVault<T0, T1>) : u64 {
        arg0.opened_ms
    }

    public(friend) fun parts_mut<T0, T1>(arg0: &mut OpenVault<T0, T1>) : (&mut 0x2::object::UID, &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Book<T0, T1>) {
        (&mut arg0.id, &mut arg0.book)
    }

    public(friend) fun pay_fees<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T1>, arg2: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::fee_recipient(arg2);
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg3), v0);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
        if (0x2::balance::value<T1>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(arg1, arg3), v0);
        } else {
            0x2::balance::destroy_zero<T1>(arg1);
        };
    }

    public(friend) fun pay_reward<T0, T1, T2>(arg0: &OpenVault<T0, T1>, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg2: 0x2::object::ID, arg3: 0x2::balance::Balance<T2>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T2>(&arg3);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T2>(arg3);
            return
        };
        let v1 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::fee_recipient(arg1);
        let v2 = RewardCollected{
            vault_id    : 0x2::object::id<OpenVault<T0, T1>>(arg0),
            position_id : arg2,
            coin        : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T2>()),
            amount      : v0,
            to          : v1,
        };
        0x2::event::emit<RewardCollected>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(arg3, arg4), v1);
    }

    public(friend) fun take_fees<T0, T1>(arg0: &mut OpenVault<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = 0x2::balance::value<T1>(&arg2);
        let (v2, v3) = if (arg0.total_shares == 0) {
            (v0, v1)
        } else {
            (mul_div(v0, arg0.perf_fee_bps, 10000), mul_div(v1, arg0.perf_fee_bps, 10000))
        };
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::join_t<T0, T1>(&mut arg0.book, arg1);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::join_q<T0, T1>(&mut arg0.book, arg2);
        arg0.total_fees_t = arg0.total_fees_t + v0;
        arg0.total_fees_q = arg0.total_fees_q + v1;
        arg0.total_perf_t = arg0.total_perf_t + v2;
        arg0.total_perf_q = arg0.total_perf_q + v3;
        if (v0 > 0 || v1 > 0) {
            let v4 = FeesCollected{
                vault_id : 0x2::object::id<OpenVault<T0, T1>>(arg0),
                fee_t    : v0,
                fee_q    : v1,
                perf_t   : v2,
                perf_q   : v3,
            };
            0x2::event::emit<FeesCollected>(v4);
        };
        (0x2::balance::split<T0>(&mut arg1, v2), 0x2::balance::split<T1>(&mut arg2, v3))
    }

    public(friend) fun take_idle<T0, T1>(arg0: &mut OpenVault<T0, T1>, arg1: Deposit<T0, T1>) : (0x2::object::ID, u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let Deposit {
            id           : v0,
            vault_id     : _,
            shares       : v2,
            deposited_ms : _,
        } = arg1;
        let v4 = v0;
        0x2::object::delete(v4);
        let v5 = arg0.total_shares;
        assert!(v2 > 0 && v2 <= v5, 505);
        let (v6, v7) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::idle<T0, T1>(&arg0.book);
        (0x2::object::uid_to_inner(&v4), v2, v5, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::split_t<T0, T1>(&mut arg0.book, mul_div(v6, v2, v5)), 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::split_q<T0, T1>(&mut arg0.book, mul_div(v7, v2, v5)))
    }

    fun take_ranges<T0, T1>(arg0: &mut OpenVault<T0, T1>, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: u64, arg5: u64, arg6: &mut 0x2::balance::Balance<T0>, arg7: &mut 0x2::balance::Balance<T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::range_count<T0, T1>(&arg0.book);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = (((0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::range_liquidity<T0, T1>(&arg0.id, &arg0.book, v0) as u256) * (arg4 as u256) / (arg5 as u256)) as u128);
            if (v1 > 0 || arg4 == arg5) {
                let (v2, v3, v4, v5, v6) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::take_range<T0, T1>(&mut arg0.id, &mut arg0.book, arg2, arg3, v0, v1, arg8);
                let v7 = v2;
                0x2::balance::join<T0>(arg6, v3);
                0x2::balance::join<T1>(arg7, v4);
                emit_removed(0x2::object::id<OpenVault<T0, T1>>(arg0), &v7);
                let (v8, v9) = take_fees<T0, T1>(arg0, v5, v6);
                pay_fees<T0, T1>(v8, v9, arg1, arg9);
            };
        };
    }

    public fun terms<T0, T1>(arg0: &OpenVault<T0, T1>) : (u64, u64, u64, u64, u64) {
        (arg0.perf_fee_bps, arg0.max_pool_share_bps, arg0.max_deposit_dev_bps, arg0.daily_deposit_bps, arg0.min_hold_ms)
    }

    public fun total_shares<T0, T1>(arg0: &OpenVault<T0, T1>) : u64 {
        arg0.total_shares
    }

    public fun totals<T0, T1>(arg0: &OpenVault<T0, T1>) : (u64, u64, u64, u64, u64, u64, u64) {
        (arg0.total_deposited_t, arg0.total_withdrawn_t, arg0.total_withdrawn_q, arg0.total_fees_t, arg0.total_fees_q, arg0.total_perf_t, arg0.total_perf_q)
    }

    public fun withdraw<T0, T1>(arg0: &mut OpenVault<T0, T1>, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: Deposit<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_pool<T0, T1>(&arg0.book, arg3);
        check_withdraw<T0, T1>(arg0, &arg4, 0x2::clock::timestamp_ms(arg5));
        collect_all<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6);
        let (v0, v1, v2, v3, v4) = take_idle<T0, T1>(arg0, arg4);
        let v5 = v4;
        let v6 = v3;
        let v7 = &mut v6;
        let v8 = &mut v5;
        take_ranges<T0, T1>(arg0, arg1, arg2, arg3, v1, v2, v7, v8, arg5, arg6);
        finish_withdraw<T0, T1>(arg0, v0, v1, v2, v6, v5, arg6)
    }

    // decompiled from Move bytecode v7
}

