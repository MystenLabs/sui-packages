module 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::vault {
    struct Stream has store {
        queued: u64,
        streaming: u64,
        tranches: vector<Tranche>,
    }

    struct Tranche has copy, drop, store {
        total: u64,
        released: u64,
        start_ms: u64,
        end_ms: u64,
    }

    struct Vault<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        bundle_id: 0x2::object::ID,
        launch_position_id: 0x2::object::ID,
        book: 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::Book<T0, T2>,
        platform_bps: u64,
        sunset_bps: u64,
        bundle_amount: u64,
        rewards_q: 0x2::balance::Balance<T2>,
        stream: Stream,
        total_staked: u64,
        acc: u256,
        share_supply: u64,
        state: u8,
        launched_ms: u64,
        window_start_ms: u64,
        window_fees: u64,
        window_volume: u64,
        proto_a: u64,
        proto_b: u64,
        sunset_votes: u64,
        sunset_ms: u64,
        last_collect_ms: u64,
        ladder_pending: bool,
        launch_sqrt: u128,
        total_fees_q: u64,
        total_fees_t: u64,
        total_platform_q: u64,
        total_backers_q: u64,
    }

    struct LaunchKey has copy, drop, store {
        dummy_field: bool,
    }

    struct NoLaunch has store, key {
        id: 0x2::object::UID,
    }

    struct Stake<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        shares: 0x2::balance::Balance<T0>,
        debt: u256,
        voted: bool,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        bundle_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        launch_position_id: 0x2::object::ID,
        tokens: u64,
        quote: u64,
        share_supply: u64,
    }

    struct FeesCollected has copy, drop {
        vault_id: 0x2::object::ID,
        fee_q: u64,
        fee_t: u64,
        platform_q: u64,
        backers_q: u64,
        to_idle_q: u64,
    }

    struct Observed has copy, drop {
        vault_id: 0x2::object::ID,
        sqrt_price: u128,
        timestamp_ms: u64,
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

    struct SunsetChecked has copy, drop {
        vault_id: 0x2::object::ID,
        window_volume: u64,
        threshold: u64,
        sunset: bool,
        timestamp_ms: u64,
    }

    struct SunsetVoted has copy, drop {
        vault_id: 0x2::object::ID,
        stake_id: 0x2::object::ID,
        yes: bool,
        amount: u64,
        votes: u64,
        share_supply: u64,
        sunset: bool,
    }

    struct Staked has copy, drop {
        vault_id: 0x2::object::ID,
        stake_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        total_staked: u64,
    }

    struct Unstaked has copy, drop {
        vault_id: 0x2::object::ID,
        stake_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        total_staked: u64,
    }

    struct RewardsClaimed has copy, drop {
        vault_id: 0x2::object::ID,
        stake_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct RewardsReleased has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        to_idle: bool,
        streaming_left: u64,
        tranches: u64,
    }

    struct Redeemed has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        shares: u64,
        quote: u64,
        tokens: u64,
        share_supply: u64,
    }

    struct CurvePlatformKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CurvePlatform<phantom T0, phantom T1> has store {
        t: 0x2::balance::Balance<T0>,
        q: 0x2::balance::Balance<T1>,
    }

    struct CurvePlatformPaid has copy, drop {
        vault_id: 0x2::object::ID,
        tokens: u64,
        quote: u64,
        to: address,
    }

    public fun add<T0, T1, T2>(arg0: &mut 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::Ticket, arg1: &mut Vault<T0, T1, T2>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg4: u32, arg5: u32, arg6: u64, arg7: bool, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::assert_ticket(arg0, &arg1.id);
        assert!(arg1.state == 0, 402);
        let v0 = 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::add<T0, T2>(arg0, &mut arg1.id, &mut arg1.book, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        emit_added(0x2::object::id<Vault<T0, T1, T2>>(arg1), &v0);
    }

    public(friend) fun new<T0, T1, T2>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg3: 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::config::Limits, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0x2::balance::Balance<T0>, arg9: 0x2::balance::Balance<T2>, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : Vault<T0, T1, T2> {
        new_on<T0, T1, T2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::new<T0, T2>(arg1, arg3, 200, arg8, arg9), arg0, arg2, arg4, arg5, arg6, arg7, false, 0, arg10, arg11)
    }

    public fun collect_reward<T0, T1, T2, T3>(arg0: &mut Vault<T0, T1, T2>, arg1: &0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::config::Config, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>>(arg3) == 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::pool_id<T0, T2>(&arg0.book), 400);
        let v0 = if (arg4 == arg0.launch_position_id) {
            let v1 = LaunchKey{dummy_field: false};
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T2, T3>(arg5, arg2, arg3, 0x2::dynamic_object_field::borrow_mut<LaunchKey, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, v1))
        } else {
            assert!(0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::holds<T0, T2>(&arg0.book, arg4), 422);
            0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::collect_reward<T0, T2, T3>(&mut arg0.id, &arg0.book, arg2, arg3, arg4, arg5)
        };
        pay_reward<T0, T1, T2, T3>(arg0, arg1, arg4, v0, arg6);
    }

    public fun begin<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::config::Config, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::Ticket {
        assert_can_begin<T0, T1, T2>(arg0, arg1, arg4);
        0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::begin<T0, T2>(&arg0.id, &mut arg0.book, arg2, 0x2::clock::timestamp_ms(arg3))
    }

    public fun close_retired<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        let v0 = RangeClosed{
            vault_id    : 0x2::object::id<Vault<T0, T1, T2>>(arg0),
            position_id : 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::close_retired<T0, T2>(&mut arg0.id, &mut arg0.book, arg1, arg2, 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::retired_index<T0, T2>(&arg0.book, arg3), arg4),
        };
        0x2::event::emit<RangeClosed>(v0);
    }

    public fun finish<T0, T1, T2>(arg0: 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::Ticket, arg1: &mut Vault<T0, T1, T2>) {
        0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::assert_ticket(&arg0, &arg1.id);
        assert!(arg1.state == 0, 402);
        let v0 = 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::finish<T0, T2>(arg0, &mut arg1.book);
        let (v1, v2, v3, v4, v5, v6) = 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::finished_fields(&v0);
        let v7 = Rebalanced{
            vault_id       : 0x2::object::id<Vault<T0, T1, T2>>(arg1),
            ref_sqrt_price : v1,
            value          : v2,
            added_quote    : v3,
            turnover_24h   : v4,
            ranges         : v5,
            timestamp_ms   : v6,
        };
        0x2::event::emit<Rebalanced>(v7);
    }

    public fun idle<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : (u64, u64) {
        0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::idle<T0, T2>(&arg0.book)
    }

    public fun last_rebalance_ms<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::last_rebalance_ms<T0, T2>(&arg0.book)
    }

    public fun limits<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::config::Limits {
        0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::limits<T0, T2>(&arg0.book)
    }

    public fun max_ranges() : u64 {
        0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::max_ranges()
    }

    entry fun observe<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::config::Config, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::config::assert_version(arg1);
        0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::config::assert_keeper(arg1, arg4);
        0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::assert_pool_id<T0, T2>(&arg0.book, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>>(arg2), 0);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::observe<T0, T2>(&mut arg0.book, v0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T2>(arg2));
        track_volume<T0, T1, T2>(arg0, arg2);
        let v2 = Observed{
            vault_id     : 0x2::object::id<Vault<T0, T1, T2>>(arg0),
            sqrt_price   : v1,
            timestamp_ms : v0,
        };
        0x2::event::emit<Observed>(v2);
    }

    public(friend) fun place_launch_ladder<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::place_launch_ladder<T0, T2>(&mut arg0.id, &mut arg0.book, arg1, arg2, arg3, arg4);
        0x1::vector::reverse<0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::Added>(&mut v0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::Added>(&v0)) {
            let v2 = 0x1::vector::pop_back<0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::Added>(&mut v0);
            emit_added(0x2::object::id<Vault<T0, T1, T2>>(arg0), &v2);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::Added>(v0);
    }

    public fun pool_id<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : 0x2::object::ID {
        0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::pool_id<T0, T2>(&arg0.book)
    }

    public fun ranges<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : vector<0x2::object::ID> {
        0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::ranges<T0, T2>(&arg0.book)
    }

    public fun rebalance_paused<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : bool {
        0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::rebalance_paused<T0, T2>(&arg0.book)
    }

    public fun reclaim_crossed<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        let (v0, v1, v2, v3, v4) = 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::reclaim_crossed<T0, T2>(&mut arg0.id, &mut arg0.book, arg1, arg2, 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::range_index<T0, T2>(&arg0.book, arg3), arg4);
        let v5 = v0;
        keep_removed<T0, T1, T2>(arg0, &v5, v1, v2, v3, v4);
    }

    public fun remove<T0, T1, T2>(arg0: &mut 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::Ticket, arg1: &mut Vault<T0, T1, T2>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg4: 0x2::object::ID, arg5: u128, arg6: &0x2::clock::Clock) {
        let (v0, v1, v2, v3, v4) = 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::remove<T0, T2>(arg0, &mut arg1.id, &mut arg1.book, arg2, arg3, 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::range_index<T0, T2>(&arg1.book, arg4), arg5, arg6);
        let v5 = v0;
        keep_removed<T0, T1, T2>(arg1, &v5, v1, v2, v3, v4);
    }

    public fun retired<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : vector<0x2::object::ID> {
        0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::retired<T0, T2>(&arg0.book)
    }

    public fun set_rebalance_paused<T0, T1, T2>(arg0: &0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::config::AdminCap, arg1: &mut Vault<T0, T1, T2>, arg2: bool) {
        0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::set_rebalance_paused<T0, T2>(&mut arg1.book, arg2);
        let v0 = RebalancePauseChanged{
            vault_id : 0x2::object::id<Vault<T0, T1, T2>>(arg1),
            paused   : arg2,
        };
        0x2::event::emit<RebalancePauseChanged>(v0);
    }

    public fun turnover_24h<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: u64) : u64 {
        0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::turnover_24h<T0, T2>(&arg0.book, arg1)
    }

    public fun venue<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : (u8, bool) {
        (0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::venue<T0, T2>(&arg0.book), 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::quote_first<T0, T2>(&arg0.book))
    }

    public fun add_stake<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &mut Stake<T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0, 415);
        assert!(arg0.state == 0, 402);
        let v1 = claim_rewards<T0, T1, T2>(arg0, arg1, arg3, arg4);
        arg0.total_staked = arg0.total_staked + v0;
        0x2::balance::join<T1>(&mut arg1.shares, 0x2::coin::into_balance<T1>(arg2));
        arg1.debt = (0x2::balance::value<T1>(&arg1.shares) as u256) * arg0.acc;
        if (arg1.voted) {
            arg0.sunset_votes = arg0.sunset_votes + v0;
            if (0x2::clock::timestamp_ms(arg3) >= arg0.launched_ms + 21600000 && (arg0.sunset_votes as u128) * 2 > (arg0.share_supply as u128)) {
                arg0.state = 1;
                arg0.sunset_ms = 0x2::clock::timestamp_ms(arg3);
            };
        };
        let v2 = Staked{
            vault_id     : 0x2::object::id<Vault<T0, T1, T2>>(arg0),
            stake_id     : 0x2::object::id<Stake<T1>>(arg1),
            owner        : 0x2::tx_context::sender(arg4),
            amount       : v0,
            total_staked : arg0.total_staked,
        };
        0x2::event::emit<Staked>(v2);
        v1
    }

    public(friend) fun add_volume<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64, arg2: u64, arg3: bool, arg4: u128, arg5: u128, arg6: u128) {
        let v0 = if (arg1 >= arg0.proto_a) {
            arg1 - arg0.proto_a
        } else {
            arg1
        };
        let v1 = if (arg2 >= arg0.proto_b) {
            arg2 - arg0.proto_b
        } else {
            arg2
        };
        arg0.proto_a = arg1;
        arg0.proto_b = arg2;
        if (arg6 == 0) {
            return
        };
        let (v2, v3) = if (arg3) {
            (v1, v0)
        } else {
            (v0, v1)
        };
        let v4 = (arg0.window_volume as u256) + (((v3 as u128) + (0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::limits::token_value(v2, arg4) as u128)) as u256) * (arg5 as u256) / (arg6 as u256);
        let v5 = if (v4 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v4 as u64)
        };
        arg0.window_volume = v5;
    }

    fun advance(arg0: &mut Stream, arg1: u64) : (u64, u64, u64) {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Tranche>(&arg0.tranches)) {
            let v2 = 0x1::vector::borrow_mut<Tranche>(&mut arg0.tranches, v1);
            let v3 = if (arg1 >= v2.end_ms) {
                v2.total
            } else if (arg1 <= v2.start_ms) {
                0
            } else {
                mul_div(v2.total, arg1 - v2.start_ms, v2.end_ms - v2.start_ms)
            };
            let v4 = if (v3 > v2.released) {
                v3 - v2.released
            } else {
                0
            };
            v2.released = v2.released + v4;
            v0 = v0 + v4;
            if (v2.released == v2.total) {
                0x1::vector::swap_remove<Tranche>(&mut arg0.tranches, v1);
                continue
            };
            v1 = v1 + 1;
        };
        arg0.streaming = arg0.streaming - v0;
        if (arg0.queued > 0) {
            let v5 = arg0.queued;
            arg0.queued = 0;
            arg0.streaming = arg0.streaming + v5;
            let v6 = false;
            let v7 = 0;
            while (v7 < 0x1::vector::length<Tranche>(&arg0.tranches)) {
                let v8 = 0x1::vector::borrow_mut<Tranche>(&mut arg0.tranches, v7);
                if (!v6 && v8.start_ms + 3600000 > arg1) {
                    v8.total = v8.total + v5;
                    v6 = true;
                };
                v7 = v7 + 1;
            };
            if (!v6) {
                let v9 = Tranche{
                    total    : v5,
                    released : 0,
                    start_ms : arg1,
                    end_ms   : arg1 + 259200000,
                };
                0x1::vector::push_back<Tranche>(&mut arg0.tranches, v9);
            };
        };
        (v0, arg0.streaming, 0x1::vector::length<Tranche>(&arg0.tranches))
    }

    public(friend) fun assert_active<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) {
        assert!(arg0.state == 0, 402);
    }

    public(friend) fun assert_can_begin<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::config::Config, arg2: &0x2::tx_context::TxContext) {
        0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::config::assert_version(arg1);
        0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::config::assert_keeper(arg1, arg2);
        assert!(arg0.state == 0, 402);
        assert!(!arg0.ladder_pending, 426);
    }

    public(friend) fun assert_can_redeem<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) {
        assert!(arg0.state == 1, 413);
        assert!(0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::range_count<T0, T2>(&arg0.book) == 0, 414);
    }

    public(friend) fun assert_can_unwind<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::config::Config, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.state == 1, 413);
        assert!(0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::config::is_keeper(arg1, 0x2::tx_context::sender(arg3)) || arg2 >= arg0.sunset_ms + 300000, 417);
    }

    public(friend) fun book_mut<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>) : &mut 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::Book<T0, T2> {
        &mut arg0.book
    }

    public(friend) fun book_ref<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : &0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::Book<T0, T2> {
        &arg0.book
    }

    public fun bundle_id<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : 0x2::object::ID {
        arg0.bundle_id
    }

    public fun check_sunset<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::config::Config, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 402);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 >= arg0.window_start_ms + 21600000, 416);
        collect<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
        close_window<T0, T1, T2>(arg0, v0);
    }

    fun claim_internal<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &mut Stake<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = (0x2::balance::value<T1>(&arg1.shares) as u256) * arg0.acc;
        arg1.debt = v0;
        let v1 = 0x1::u64::min((((v0 - arg1.debt) / 1000000000000000000) as u64), 0x2::balance::value<T2>(&arg0.rewards_q) - arg0.stream.queued - arg0.stream.streaming);
        if (v1 > 0) {
            let v2 = RewardsClaimed{
                vault_id : 0x2::object::id<Vault<T0, T1, T2>>(arg0),
                stake_id : 0x2::object::id<Stake<T1>>(arg1),
                owner    : 0x2::tx_context::sender(arg2),
                amount   : v1,
            };
            0x2::event::emit<RewardsClaimed>(v2);
        };
        0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.rewards_q, v1), arg2)
    }

    public fun claim_rewards<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &mut Stake<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1, T2>>(arg0), 401);
        release<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg2));
        claim_internal<T0, T1, T2>(arg0, arg1, arg3)
    }

    fun close_window<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64) {
        let v0 = (((arg0.bundle_amount as u128) * (arg0.sunset_bps as u128) * ((arg1 - arg0.window_start_ms) as u128) / (10000 as u128) * (21600000 as u128)) as u64);
        let v1 = arg0.window_volume < v0;
        let v2 = SunsetChecked{
            vault_id      : 0x2::object::id<Vault<T0, T1, T2>>(arg0),
            window_volume : arg0.window_volume,
            threshold     : v0,
            sunset        : v1,
            timestamp_ms  : arg1,
        };
        0x2::event::emit<SunsetChecked>(v2);
        if (v1) {
            arg0.state = 1;
            arg0.sunset_ms = arg1;
        } else {
            arg0.window_start_ms = arg1;
            arg0.window_fees = 0;
            arg0.window_volume = 0;
        };
    }

    public(friend) fun close_window_due<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64) {
        assert!(arg0.state == 0, 402);
        assert!(arg1 >= arg0.window_start_ms + 21600000, 416);
        close_window<T0, T1, T2>(arg0, arg1);
    }

    public fun collect<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::config::Config, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::assert_pool_id<T0, T2>(&arg0.book, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>>(arg3), 0);
        let v0 = LaunchKey{dummy_field: false};
        let (_, _, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T2>(arg4, arg2, arg3, 0x2::dynamic_object_field::borrow_mut<LaunchKey, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, v0));
        track_volume<T0, T1, T2>(arg0, arg3);
        take_launch_fees<T0, T1, T2>(arg0, arg1, v3, v4, 0x2::clock::timestamp_ms(arg4), arg5);
    }

    public fun curve_platform_due<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : (u64, u64) {
        let v0 = CurvePlatformKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<CurvePlatformKey, CurvePlatform<T0, T2>>(&arg0.id, v0)) {
            return (0, 0)
        };
        let v1 = CurvePlatformKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<CurvePlatformKey, CurvePlatform<T0, T2>>(&arg0.id, v1);
        (0x2::balance::value<T0>(&v2.t), 0x2::balance::value<T2>(&v2.q))
    }

    fun drain(arg0: &mut Stream) : (u64, u64, u64) {
        arg0.queued = 0;
        arg0.streaming = 0;
        arg0.tranches = 0x1::vector::empty<Tranche>();
        (arg0.queued + arg0.streaming, 0, 0)
    }

    public(friend) fun emit_added(arg0: 0x2::object::ID, arg1: &0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::Added) {
        let (v0, v1, v2, v3, v4) = 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::added_fields(arg1);
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

    public(friend) fun emit_closed<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: 0x2::object::ID) {
        let v0 = RangeClosed{
            vault_id    : 0x2::object::id<Vault<T0, T1, T2>>(arg0),
            position_id : arg1,
        };
        0x2::event::emit<RangeClosed>(v0);
    }

    public fun fee_totals<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : (u64, u64, u64, u64) {
        (arg0.total_fees_q, arg0.total_fees_t, arg0.total_platform_q, arg0.total_backers_q)
    }

    public fun has_no_launch<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : bool {
        let v0 = LaunchKey{dummy_field: false};
        0x2::dynamic_object_field::exists_with_type<LaunchKey, NoLaunch>(&arg0.id, v0)
    }

    fun idle_q<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        let (_, v1) = 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::idle<T0, T2>(&arg0.book);
        v1
    }

    fun idle_t<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        let (v0, _) = 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::idle<T0, T2>(&arg0.book);
        v0
    }

    public fun is_sunset<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : bool {
        arg0.state == 1
    }

    public(friend) fun keep_removed<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::Removed, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T2>, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T2>) {
        let v0 = &mut arg4;
        let v1 = &mut arg5;
        take_curve_platform<T0, T1, T2>(arg0, v0, v1);
        0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::join_t<T0, T2>(&mut arg0.book, arg4);
        0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::join_q<T0, T2>(&mut arg0.book, arg5);
        0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::join_t<T0, T2>(&mut arg0.book, arg2);
        0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::join_q<T0, T2>(&mut arg0.book, arg3);
        let (v2, v3, v4, v5, v6, v7, v8, v9) = 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::removed_fields(arg1);
        let v10 = 0x2::object::id<Vault<T0, T1, T2>>(arg0);
        if (v9) {
            let v11 = RangeRetired{
                vault_id    : v10,
                position_id : v2,
            };
            0x2::event::emit<RangeRetired>(v11);
        };
        let v12 = RangeRemoved{
            vault_id    : v10,
            position_id : v2,
            liquidity   : v3,
            tokens      : v4,
            quote       : v5,
            fee_t       : v6,
            fee_q       : v7,
            closed      : v8,
        };
        0x2::event::emit<RangeRemoved>(v12);
    }

    public fun ladder_pending<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : bool {
        arg0.ladder_pending
    }

    public fun launch_position_id<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : 0x2::object::ID {
        arg0.launch_position_id
    }

    public(friend) fun launch_position_mut<T0, T1, T2, T3: store + key>(arg0: &mut Vault<T0, T1, T2>) : &mut T3 {
        let v0 = LaunchKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<LaunchKey, T3>(&mut arg0.id, v0)
    }

    public fun launch_sqrt<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u128 {
        arg0.launch_sqrt
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public(friend) fun new_no_launch(arg0: &mut 0x2::tx_context::TxContext) : NoLaunch {
        NoLaunch{id: 0x2::object::new(arg0)}
    }

    public(friend) fun new_on<T0, T1, T2, T3: store + key>(arg0: 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::Book<T0, T2>, arg1: 0x2::object::ID, arg2: T3, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: u128, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : Vault<T0, T1, T2> {
        let v0 = 0x2::object::id<T3>(&arg2);
        let v1 = Stream{
            queued    : 0,
            streaming : 0,
            tranches  : 0x1::vector::empty<Tranche>(),
        };
        let v2 = Vault<T0, T1, T2>{
            id                 : 0x2::object::new(arg10),
            bundle_id          : arg1,
            launch_position_id : v0,
            book               : arg0,
            platform_bps       : arg3,
            sunset_bps         : arg4,
            bundle_amount      : arg5,
            rewards_q          : 0x2::balance::zero<T2>(),
            stream             : v1,
            total_staked       : 0,
            acc                : 0,
            share_supply       : arg6,
            state              : 0,
            launched_ms        : arg9,
            window_start_ms    : arg9,
            window_fees        : 0,
            window_volume      : 0,
            proto_a            : 0,
            proto_b            : 0,
            sunset_votes       : 0,
            sunset_ms          : 0,
            last_collect_ms    : arg9,
            ladder_pending     : arg7,
            launch_sqrt        : arg8,
            total_fees_q       : 0,
            total_fees_t       : 0,
            total_platform_q   : 0,
            total_backers_q    : 0,
        };
        let v3 = LaunchKey{dummy_field: false};
        0x2::dynamic_object_field::add<LaunchKey, T3>(&mut v2.id, v3, arg2);
        let v4 = VaultCreated{
            vault_id           : 0x2::object::id<Vault<T0, T1, T2>>(&v2),
            bundle_id          : arg1,
            pool_id            : 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::pool_id<T0, T2>(&arg0),
            launch_position_id : v0,
            tokens             : idle_t<T0, T1, T2>(&v2),
            quote              : idle_q<T0, T1, T2>(&v2),
            share_supply       : arg6,
        };
        0x2::event::emit<VaultCreated>(v4);
        v2
    }

    public(friend) fun observe_at<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64, arg2: u128) {
        let v0 = Observed{
            vault_id     : 0x2::object::id<Vault<T0, T1, T2>>(arg0),
            sqrt_price   : 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::observe<T0, T2>(&mut arg0.book, arg1, arg2),
            timestamp_ms : arg1,
        };
        0x2::event::emit<Observed>(v0);
    }

    public(friend) fun parts<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : (&0x2::object::UID, &0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::Book<T0, T2>) {
        (&arg0.id, &arg0.book)
    }

    public(friend) fun parts_mut<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>) : (&mut 0x2::object::UID, &mut 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::Book<T0, T2>) {
        (&mut arg0.id, &mut arg0.book)
    }

    public fun pay_curve_platform<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::config::Config, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CurvePlatformKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<CurvePlatformKey, CurvePlatform<T0, T2>>(&arg0.id, v0)) {
            return
        };
        let v1 = CurvePlatformKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<CurvePlatformKey, CurvePlatform<T0, T2>>(&mut arg0.id, v1);
        let v3 = 0x2::balance::withdraw_all<T0>(&mut v2.t);
        let v4 = 0x2::balance::withdraw_all<T2>(&mut v2.q);
        let v5 = 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::config::fee_recipient(arg1);
        let v6 = CurvePlatformPaid{
            vault_id : 0x2::object::id<Vault<T0, T1, T2>>(arg0),
            tokens   : 0x2::balance::value<T0>(&v3),
            quote    : 0x2::balance::value<T2>(&v4),
            to       : v5,
        };
        0x2::event::emit<CurvePlatformPaid>(v6);
        if (0x2::balance::value<T0>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg2), v5);
        } else {
            0x2::balance::destroy_zero<T0>(v3);
        };
        if (0x2::balance::value<T2>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v4, arg2), v5);
        } else {
            0x2::balance::destroy_zero<T2>(v4);
        };
    }

    public(friend) fun pay_reward<T0, T1, T2, T3>(arg0: &Vault<T0, T1, T2>, arg1: &0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::config::Config, arg2: 0x2::object::ID, arg3: 0x2::balance::Balance<T3>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T3>(&arg3);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T3>(arg3);
            return
        };
        let v1 = 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::config::fee_recipient(arg1);
        let v2 = RewardCollected{
            vault_id    : 0x2::object::id<Vault<T0, T1, T2>>(arg0),
            position_id : arg2,
            coin        : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T3>()),
            amount      : v0,
            to          : v1,
        };
        0x2::event::emit<RewardCollected>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(arg3, arg4), v1);
    }

    public fun pending_rewards<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &Stake<T1>) : u64 {
        ((((0x2::balance::value<T1>(&arg1.shares) as u256) * arg0.acc - arg1.debt) / 1000000000000000000) as u64)
    }

    public fun redeem<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::config::Config, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg4: &mut 0x2::coin_registry::Currency<T1>, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T0>) {
        assert_can_redeem<T0, T1, T2>(arg0);
        collect<T0, T1, T2>(arg0, arg1, arg2, arg3, arg6, arg7);
        redeem_now<T0, T1, T2>(arg0, arg4, arg5, arg7)
    }

    fun redeem_internal<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T0>) {
        assert!(arg1 > 0, 415);
        assert!(arg1 <= arg0.share_supply, 418);
        arg0.share_supply = arg0.share_supply - arg1;
        (0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::split_q<T0, T2>(&mut arg0.book, mul_div(idle_q<T0, T1, T2>(arg0), arg1, arg0.share_supply)), 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::split_t<T0, T2>(&mut arg0.book, mul_div(idle_t<T0, T1, T2>(arg0), arg1, arg0.share_supply)))
    }

    public(friend) fun redeem_now<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &mut 0x2::coin_registry::Currency<T1>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T1>(&arg2);
        let (v1, v2) = redeem_internal<T0, T1, T2>(arg0, v0);
        let v3 = v2;
        let v4 = v1;
        0x2::coin_registry::burn<T1>(arg1, arg2);
        let v5 = Redeemed{
            vault_id     : 0x2::object::id<Vault<T0, T1, T2>>(arg0),
            owner        : 0x2::tx_context::sender(arg3),
            shares       : v0,
            quote        : 0x2::balance::value<T2>(&v4),
            tokens       : 0x2::balance::value<T0>(&v3),
            share_supply : arg0.share_supply,
        };
        0x2::event::emit<Redeemed>(v5);
        (0x2::coin::from_balance<T2>(v4, arg3), 0x2::coin::from_balance<T0>(v3, arg3))
    }

    public fun redeem_stalled<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &mut 0x2::coin_registry::Currency<T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T0>) {
        assert!(arg0.state == 1, 413);
        assert!(0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::range_count<T0, T2>(&arg0.book) == 0, 414);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.last_collect_ms + 172800000, 416);
        release<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg3));
        let v0 = 0x2::coin::value<T1>(&arg2);
        let (v1, v2) = redeem_internal<T0, T1, T2>(arg0, v0);
        let v3 = v2;
        let v4 = v1;
        0x2::coin_registry::burn<T1>(arg1, arg2);
        let v5 = Redeemed{
            vault_id     : 0x2::object::id<Vault<T0, T1, T2>>(arg0),
            owner        : 0x2::tx_context::sender(arg4),
            shares       : v0,
            quote        : 0x2::balance::value<T2>(&v4),
            tokens       : 0x2::balance::value<T0>(&v3),
            share_supply : arg0.share_supply,
        };
        0x2::event::emit<Redeemed>(v5);
        (0x2::coin::from_balance<T2>(v4, arg4), 0x2::coin::from_balance<T0>(v3, arg4))
    }

    fun release<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64) {
        let (v0, v1, v2) = if (arg0.state == 1) {
            let v3 = &mut arg0.stream;
            drain(v3)
        } else {
            let v4 = &mut arg0.stream;
            advance(v4, arg1)
        };
        if (v0 == 0) {
            return
        };
        let v5 = arg0.total_staked == 0;
        if (v5) {
            0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::join_q<T0, T2>(&mut arg0.book, 0x2::balance::split<T2>(&mut arg0.rewards_q, v0));
        } else {
            arg0.acc = arg0.acc + (v0 as u256) * 1000000000000000000 / (arg0.total_staked as u256);
        };
        let v6 = RewardsReleased{
            vault_id       : 0x2::object::id<Vault<T0, T1, T2>>(arg0),
            amount         : v0,
            to_idle        : v5,
            streaming_left : v1,
            tranches       : v2,
        };
        0x2::event::emit<RewardsReleased>(v6);
    }

    public fun release_rewards<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &0x2::clock::Clock) {
        release<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg1));
    }

    public fun reward_stream_ms() : u64 {
        259200000
    }

    public fun rewards_balance<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        0x2::balance::value<T2>(&arg0.rewards_q)
    }

    public(friend) fun set_volume_baseline<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>) {
        set_volume_baseline_raw<T0, T1, T2>(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_protocol_fee_for_coin_a<T0, T2>(arg1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_protocol_fee_for_coin_b<T0, T2>(arg1));
    }

    public(friend) fun set_volume_baseline_raw<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64, arg2: u64) {
        arg0.proto_a = arg1;
        arg0.proto_b = arg2;
    }

    public(friend) fun share<T0, T1, T2>(arg0: Vault<T0, T1, T2>) {
        0x2::transfer::share_object<Vault<T0, T1, T2>>(arg0);
    }

    public fun share_supply<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        arg0.share_supply
    }

    fun split_fees<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T2>) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T2>(&arg2);
        let v1 = 0x2::balance::value<T0>(&arg1);
        arg0.total_fees_q = arg0.total_fees_q + v0;
        arg0.total_fees_t = arg0.total_fees_t + v1;
        let v2 = if (arg0.share_supply == 0) {
            0x2::balance::withdraw_all<T0>(&mut arg1)
        } else {
            0x2::balance::zero<T0>()
        };
        0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::join_t<T0, T2>(&mut arg0.book, arg1);
        let v3 = if (arg0.share_supply == 0) {
            v0
        } else {
            mul_div(v0, arg0.platform_bps, 10000)
        };
        let v4 = 0x2::balance::value<T2>(&arg2);
        let v5 = 0;
        if (v4 > 0) {
            if (arg0.total_staked > 0 && arg0.state == 0) {
                arg0.stream.queued = arg0.stream.queued + v4;
                0x2::balance::join<T2>(&mut arg0.rewards_q, arg2);
            } else {
                v5 = v4;
                0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::join_q<T0, T2>(&mut arg0.book, arg2);
            };
        } else {
            0x2::balance::destroy_zero<T2>(arg2);
        };
        arg0.total_platform_q = arg0.total_platform_q + v3;
        arg0.total_backers_q = arg0.total_backers_q + v4;
        arg0.window_fees = arg0.window_fees + v4;
        let v6 = FeesCollected{
            vault_id   : 0x2::object::id<Vault<T0, T1, T2>>(arg0),
            fee_q      : v0,
            fee_t      : v1,
            platform_q : v3,
            backers_q  : v4,
            to_idle_q  : v5,
        };
        0x2::event::emit<FeesCollected>(v6);
        (0x2::balance::split<T2>(&mut arg2, v3), v2)
    }

    public fun stake<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : Stake<T1> {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 415);
        assert!(arg0.state == 0, 402);
        release<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg2));
        arg0.total_staked = arg0.total_staked + v0;
        let v1 = Stake<T1>{
            id       : 0x2::object::new(arg3),
            vault_id : 0x2::object::id<Vault<T0, T1, T2>>(arg0),
            shares   : 0x2::coin::into_balance<T1>(arg1),
            debt     : (v0 as u256) * arg0.acc,
            voted    : false,
        };
        let v2 = Staked{
            vault_id     : 0x2::object::id<Vault<T0, T1, T2>>(arg0),
            stake_id     : 0x2::object::id<Stake<T1>>(&v1),
            owner        : 0x2::tx_context::sender(arg3),
            amount       : v0,
            total_staked : arg0.total_staked,
        };
        0x2::event::emit<Staked>(v2);
        v1
    }

    public fun stake_amount<T0>(arg0: &Stake<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.shares)
    }

    public fun stake_vault_id<T0>(arg0: &Stake<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun stake_voted<T0>(arg0: &Stake<T0>) : bool {
        arg0.voted
    }

    public fun sunset_stats<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : (u64, u64, u64, u64, u64, u64) {
        (arg0.window_start_ms, arg0.window_volume, mul_div(arg0.bundle_amount, arg0.sunset_bps, 10000), arg0.sunset_ms, arg0.window_fees, arg0.sunset_votes)
    }

    public fun sunset_window_ms() : u64 {
        21600000
    }

    fun take_all<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: u64, arg4: &0x2::clock::Clock) {
        let (v0, v1, v2, v3, v4) = 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::take_range<T0, T2>(&mut arg0.id, &mut arg0.book, arg1, arg2, arg3, 340282366920938463463374607431768211455, arg4);
        let v5 = v0;
        keep_removed<T0, T1, T2>(arg0, &v5, v1, v2, v3, v4);
    }

    fun take_curve_platform<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &mut 0x2::balance::Balance<T0>, arg2: &mut 0x2::balance::Balance<T2>) {
        if (!has_no_launch<T0, T1, T2>(arg0)) {
            return
        };
        let v0 = mul_div(0x2::balance::value<T2>(arg2), arg0.platform_bps, 10000);
        let v1 = CurvePlatformKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<CurvePlatformKey, CurvePlatform<T0, T2>>(&arg0.id, v1)) {
            let v2 = CurvePlatformKey{dummy_field: false};
            let v3 = CurvePlatform<T0, T2>{
                t : 0x2::balance::zero<T0>(),
                q : 0x2::balance::zero<T2>(),
            };
            0x2::dynamic_field::add<CurvePlatformKey, CurvePlatform<T0, T2>>(&mut arg0.id, v2, v3);
        };
        let v4 = CurvePlatformKey{dummy_field: false};
        let v5 = 0x2::dynamic_field::borrow_mut<CurvePlatformKey, CurvePlatform<T0, T2>>(&mut arg0.id, v4);
        0x2::balance::join<T0>(&mut v5.t, 0x2::balance::split<T0>(arg1, mul_div(0x2::balance::value<T0>(arg1), arg0.platform_bps, 10000)));
        0x2::balance::join<T2>(&mut v5.q, 0x2::balance::split<T2>(arg2, v0));
        arg0.total_platform_q = arg0.total_platform_q + v0;
    }

    public(friend) fun take_ladder_pending<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>) : u128 {
        assert!(arg0.ladder_pending, 427);
        arg0.ladder_pending = false;
        arg0.launch_sqrt
    }

    public(friend) fun take_launch_fees<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::config::Config, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T2>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        arg0.last_collect_ms = arg4;
        release<T0, T1, T2>(arg0, arg4);
        let (v0, v1) = split_fees<T0, T1, T2>(arg0, arg2, arg3);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::config::fee_recipient(arg1);
        if (0x2::balance::value<T2>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v3, arg5), v4);
        } else {
            0x2::balance::destroy_zero<T2>(v3);
        };
        if (0x2::balance::value<T0>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg5), v4);
        } else {
            0x2::balance::destroy_zero<T0>(v2);
        };
    }

    public fun total_staked<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        arg0.total_staked
    }

    fun track_volume<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>) {
        add_volume<T0, T1, T2>(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_protocol_fee_for_coin_a<T0, T2>(arg1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_protocol_fee_for_coin_b<T0, T2>(arg1), false, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T2>(arg1), 1000000 * 1000000, (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::protocol_fee_share<T0, T2>(arg1) as u128) * (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T2>(arg1) as u128));
    }

    public fun unstake<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: Stake<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1, T2>>(arg0), 401);
        release<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg2));
        let v0 = &mut arg1;
        let v1 = claim_internal<T0, T1, T2>(arg0, v0, arg3);
        let Stake {
            id       : v2,
            vault_id : _,
            shares   : v4,
            debt     : _,
            voted    : v6,
        } = arg1;
        let v7 = v4;
        let v8 = v2;
        let v9 = 0x2::balance::value<T1>(&v7);
        arg0.total_staked = arg0.total_staked - v9;
        if (v6) {
            arg0.sunset_votes = arg0.sunset_votes - v9;
        };
        let v10 = Unstaked{
            vault_id     : 0x2::object::id<Vault<T0, T1, T2>>(arg0),
            stake_id     : 0x2::object::uid_to_inner(&v8),
            owner        : 0x2::tx_context::sender(arg3),
            amount       : v9,
            total_staked : arg0.total_staked,
        };
        0x2::event::emit<Unstaked>(v10);
        0x2::object::delete(v8);
        (0x2::coin::from_balance<T1>(v7, arg3), v1)
    }

    public fun unwind<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::config::Config, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        let v0 = 0xbd50493ca9307936772081acdb7e8250884b88312cb23b4707f6a0139faf06af::book::range_index<T0, T2>(&arg0.book, arg4);
        assert_can_unwind<T0, T1, T2>(arg0, arg1, 0x2::clock::timestamp_ms(arg5), arg6);
        take_all<T0, T1, T2>(arg0, arg2, arg3, v0, arg5);
    }

    public fun vote_sunset<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &mut Stake<T1>, arg2: bool, arg3: &0x2::clock::Clock) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1, T2>>(arg0), 401);
        assert!(arg0.state == 0, 402);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.launched_ms + 21600000, 416);
        let v0 = 0x2::balance::value<T1>(&arg1.shares);
        if (arg2 && !arg1.voted) {
            arg0.sunset_votes = arg0.sunset_votes + v0;
            arg1.voted = true;
        } else if (!arg2 && arg1.voted) {
            arg0.sunset_votes = arg0.sunset_votes - v0;
            arg1.voted = false;
        };
        let v1 = (arg0.sunset_votes as u128) * 2 > (arg0.share_supply as u128);
        let v2 = SunsetVoted{
            vault_id     : 0x2::object::id<Vault<T0, T1, T2>>(arg0),
            stake_id     : 0x2::object::id<Stake<T1>>(arg1),
            yes          : arg2,
            amount       : v0,
            votes        : arg0.sunset_votes,
            share_supply : arg0.share_supply,
            sunset       : v1,
        };
        0x2::event::emit<SunsetVoted>(v2);
        if (v1) {
            arg0.state = 1;
            arg0.sunset_ms = 0x2::clock::timestamp_ms(arg3);
        };
    }

    // decompiled from Move bytecode v7
}

