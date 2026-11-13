module 0xf0a0d80f80946c349f885080347dba43a3323309ef952273c20a7a2852971a19::ladder {
    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        ladders: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
    }

    struct BuyLadder<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        bundle_id: 0x2::object::ID,
        owner: address,
        pool_id: 0x2::object::ID,
        venue: u8,
        quote_first: bool,
        tick_spacing: u32,
        limits: 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Limits,
        idle_t: 0x2::balance::Balance<T0>,
        idle_q: 0x2::balance::Balance<T1>,
        ranges: vector<0x2::object::ID>,
        retired: vector<0x2::object::ID>,
        observations: 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::Observations,
        turnover: 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::Turnover,
        last_rebalance_ms: u64,
        rebalance_paused: bool,
        state: u8,
        notice_ms: u64,
        opened_ms: u64,
        funded_q: u64,
        withdrawn_q: u64,
        released_t: u64,
        released_q: u64,
    }

    struct RangeKey has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct RetiredKey has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct Ticket {
        version: u64,
        ladder_id: 0x2::object::ID,
        ref_sqrt: u128,
        value: u64,
        added: u64,
        now: u64,
    }

    struct LadderOpened has copy, drop {
        ladder_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        bundle_id: 0x2::object::ID,
        owner: address,
        pool_id: 0x2::object::ID,
        venue: u8,
        quote_first: bool,
        amount: u64,
        timestamp_ms: u64,
    }

    struct LadderFunded has copy, drop {
        ladder_id: 0x2::object::ID,
        amount: u64,
        funded_q: u64,
    }

    struct LadderNotice has copy, drop {
        ladder_id: 0x2::object::ID,
        given: bool,
        notice_ms: u64,
        withdraw_from_ms: u64,
    }

    struct LadderRangeAdded has copy, drop {
        ladder_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        lower_tick_bits: u32,
        upper_tick_bits: u32,
        quote: u64,
    }

    struct LadderRangeRemoved has copy, drop {
        ladder_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        liquidity: u128,
        tokens: u64,
        quote: u64,
        fee_t: u64,
        fee_q: u64,
        closed: bool,
        retired: bool,
    }

    struct LadderRebalanced has copy, drop {
        ladder_id: 0x2::object::ID,
        ref_sqrt_price: u128,
        value: u64,
        added_q: u64,
        turnover_24h: u64,
        ranges: u64,
        timestamp_ms: u64,
    }

    struct LadderWithdrawn has copy, drop {
        ladder_id: 0x2::object::ID,
        owner: address,
        quote: u64,
    }

    struct LadderReleased has copy, drop {
        ladder_id: 0x2::object::ID,
        owner: address,
        tokens: u64,
        quote: u64,
    }

    struct LadderPauseChanged has copy, drop {
        ladder_id: 0x2::object::ID,
        paused: bool,
    }

    struct LadderRewardCollected has copy, drop {
        ladder_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        coin: 0x1::ascii::String,
        amount: u64,
        to: address,
    }

    struct LadderRangeClosed has copy, drop {
        ladder_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
    }

    struct RegistryMigrated has copy, drop {
        from: u64,
        to: u64,
    }

    public fun limits<T0, T1>(arg0: &BuyLadder<T0, T1>) : 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Limits {
        arg0.limits
    }

    public fun bundle_id<T0, T1>(arg0: &BuyLadder<T0, T1>) : 0x2::object::ID {
        arg0.bundle_id
    }

    public fun pool_id<T0, T1>(arg0: &BuyLadder<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun venue<T0, T1>(arg0: &BuyLadder<T0, T1>) : (u8, bool) {
        (arg0.venue, arg0.quote_first)
    }

    public(friend) fun assert_bidding<T0, T1>(arg0: &BuyLadder<T0, T1>, arg1: u64) {
        assert!(arg0.state == 0 || arg0.state == 1 && arg1 < arg0.notice_ms + 600000, 703);
    }

    public(friend) fun assert_can_unwind<T0, T1, T2>(arg0: &BuyLadder<T0, T2>, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg2: u64) {
        assert!(0x2::object::id<0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>>(arg1) == arg0.vault_id, 701);
        let v0 = if (arg0.state == 1 && arg2 >= arg0.notice_ms + 600000) {
            true
        } else if (arg0.state == 2) {
            true
        } else {
            0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::is_sunset<T0, T1, T2>(arg1)
        };
        assert!(v0, 711);
    }

    public(friend) fun assert_pool<T0, T1>(arg0: &BuyLadder<T0, T1>, arg1: 0x2::object::ID, arg2: u8) {
        assert!(arg0.venue == arg2 && arg1 == arg0.pool_id, 707);
    }

    public(friend) fun assert_ticket<T0, T1>(arg0: &Ticket, arg1: &BuyLadder<T0, T1>) {
        assert!(arg0.ladder_id == 0x2::object::id<BuyLadder<T0, T1>>(arg1), 721);
        assert!(arg0.version == 1, 712);
    }

    public(friend) fun assert_version(arg0: &Registry) {
        assert!(arg0.version == 1, 712);
    }

    public(friend) fun borrow_any_mut<T0, T1, T2: store + key>(arg0: &mut BuyLadder<T0, T1>, arg1: 0x2::object::ID) : &mut T2 {
        if (0x1::vector::contains<0x2::object::ID>(&arg0.ranges, &arg1)) {
            let v1 = RangeKey{id: arg1};
            0x2::dynamic_object_field::borrow_mut<RangeKey, T2>(&mut arg0.id, v1)
        } else {
            assert!(0x1::vector::contains<0x2::object::ID>(&arg0.retired, &arg1), 722);
            let v2 = RetiredKey{id: arg1};
            0x2::dynamic_object_field::borrow_mut<RetiredKey, T2>(&mut arg0.id, v2)
        }
    }

    public(friend) fun borrow_range<T0, T1, T2: store + key>(arg0: &BuyLadder<T0, T1>, arg1: 0x2::object::ID) : &T2 {
        assert!(0x1::vector::contains<0x2::object::ID>(&arg0.ranges, &arg1), 719);
        let v0 = RangeKey{id: arg1};
        0x2::dynamic_object_field::borrow<RangeKey, T2>(&arg0.id, v0)
    }

    public(friend) fun borrow_range_mut<T0, T1, T2: store + key>(arg0: &mut BuyLadder<T0, T1>, arg1: 0x2::object::ID) : &mut T2 {
        assert!(0x1::vector::contains<0x2::object::ID>(&arg0.ranges, &arg1), 719);
        let v0 = RangeKey{id: arg1};
        0x2::dynamic_object_field::borrow_mut<RangeKey, T2>(&mut arg0.id, v0)
    }

    public fun cancel_notice<T0, T1>(arg0: &mut BuyLadder<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 700);
        assert!(arg0.state == 1, 704);
        arg0.state = 0;
        arg0.notice_ms = 0;
        let v0 = LadderNotice{
            ladder_id        : 0x2::object::id<BuyLadder<T0, T1>>(arg0),
            given            : false,
            notice_ms        : 0,
            withdraw_from_ms : 0,
        };
        0x2::event::emit<LadderNotice>(v0);
    }

    public(friend) fun check_bid<T0, T1>(arg0: &Ticket, arg1: &BuyLadder<T0, T1>, arg2: u128, arg3: u128, arg4: u128, arg5: bool, arg6: u64) {
        assert_ticket<T0, T1>(arg0, arg1);
        assert_bidding<T0, T1>(arg1, arg0.now);
        assert!(0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::within_deviation(arg2, arg0.ref_sqrt, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::max_dev_bps(&arg1.limits)), 714);
        assert!(0x1::vector::length<0x2::object::ID>(&arg1.ranges) < 8, 715);
        assert!(arg6 > 0, 720);
        assert!(arg3 < arg4, 719);
        assert!(0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::within_band(arg3, arg4, arg0.ref_sqrt, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::band_low_bps(&arg1.limits), 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::band_high_bps(&arg1.limits)), 716);
        assert!(arg4 <= arg0.ref_sqrt, 708);
        assert!(!arg5, 717);
    }

    public(friend) fun emit_closed<T0, T1>(arg0: &BuyLadder<T0, T1>, arg1: 0x2::object::ID) {
        let v0 = LadderRangeClosed{
            ladder_id   : 0x2::object::id<BuyLadder<T0, T1>>(arg0),
            position_id : arg1,
        };
        0x2::event::emit<LadderRangeClosed>(v0);
    }

    public fun finish<T0, T1>(arg0: Ticket, arg1: &mut BuyLadder<T0, T1>) {
        assert_ticket<T0, T1>(&arg0, arg1);
        let Ticket {
            version   : _,
            ladder_id : v1,
            ref_sqrt  : v2,
            value     : v3,
            added     : v4,
            now       : v5,
        } = arg0;
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::add_turnover(&mut arg1.turnover, v5, v4);
        let v6 = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::turnover(&arg1.turnover, v5);
        assert!(0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::turnover_ok(v6, v3, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::max_turnover_bps(&arg1.limits)), 718);
        let v7 = LadderRebalanced{
            ladder_id      : v1,
            ref_sqrt_price : v2,
            value          : v3,
            added_q        : v4,
            turnover_24h   : v6,
            ranges         : 0x1::vector::length<0x2::object::ID>(&arg1.ranges),
            timestamp_ms   : v5,
        };
        0x2::event::emit<LadderRebalanced>(v7);
    }

    public fun fund<T0, T1>(arg0: &mut BuyLadder<T0, T1>, arg1: &Registry, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 700);
        assert!(arg0.state == 0, 703);
        let v0 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 >= 10000, 709);
        0x2::balance::join<T1>(&mut arg0.idle_q, 0x2::coin::into_balance<T1>(arg2));
        arg0.funded_q = arg0.funded_q + v0;
        let v1 = LadderFunded{
            ladder_id : 0x2::object::id<BuyLadder<T0, T1>>(arg0),
            amount    : v0,
            funded_q  : arg0.funded_q,
        };
        0x2::event::emit<LadderFunded>(v1);
    }

    public fun give_notice<T0, T1>(arg0: &mut BuyLadder<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 700);
        assert!(arg0.state == 0, 703);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        arg0.state = 1;
        arg0.notice_ms = v0;
        let v1 = LadderNotice{
            ladder_id        : 0x2::object::id<BuyLadder<T0, T1>>(arg0),
            given            : true,
            notice_ms        : v0,
            withdraw_from_ms : v0 + 600000,
        };
        0x2::event::emit<LadderNotice>(v1);
    }

    public fun idle<T0, T1>(arg0: &BuyLadder<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.idle_t), 0x2::balance::value<T1>(&arg0.idle_q))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id      : 0x2::object::new(arg0),
            version : 1,
            ladders : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public(friend) fun keep_removed<T0, T1>(arg0: &mut BuyLadder<T0, T1>, arg1: 0x2::object::ID, arg2: u128, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: 0x2::balance::Balance<T0>, arg6: 0x2::balance::Balance<T1>, arg7: bool, arg8: bool) {
        0x2::balance::join<T0>(&mut arg0.idle_t, arg3);
        0x2::balance::join<T1>(&mut arg0.idle_q, arg4);
        0x2::balance::join<T0>(&mut arg0.idle_t, arg5);
        0x2::balance::join<T1>(&mut arg0.idle_q, arg6);
        let v0 = LadderRangeRemoved{
            ladder_id   : 0x2::object::id<BuyLadder<T0, T1>>(arg0),
            position_id : arg1,
            liquidity   : arg2,
            tokens      : 0x2::balance::value<T0>(&arg3),
            quote       : 0x2::balance::value<T1>(&arg4),
            fee_t       : 0x2::balance::value<T0>(&arg5),
            fee_q       : 0x2::balance::value<T1>(&arg6),
            closed      : arg7,
            retired     : arg8,
        };
        0x2::event::emit<LadderRangeRemoved>(v0);
    }

    public fun ladder_limits(arg0: 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Limits) : 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Limits {
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::new_limits(0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::max_turnover_bps(&arg0), 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::max_dev_bps(&arg0), 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::band_low_bps(&arg0), 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::band_high_bps(&arg0), 10000, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::min_interval_ms(&arg0), 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::min_ask_premium_bps(&arg0))
    }

    public fun ladder_of(arg0: &Registry, arg1: 0x2::object::ID) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.ladders, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.ladders, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun last_rebalance_ms<T0, T1>(arg0: &BuyLadder<T0, T1>) : u64 {
        arg0.last_rebalance_ms
    }

    public(friend) fun make_ticket<T0, T1>(arg0: &BuyLadder<T0, T1>, arg1: u128, arg2: u64, arg3: u64, arg4: u64) : Ticket {
        Ticket{
            version   : 1,
            ladder_id : 0x2::object::id<BuyLadder<T0, T1>>(arg0),
            ref_sqrt  : arg1,
            value     : 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::token_value(arg2, arg1) + arg3,
            added     : 0,
            now       : arg4,
        }
    }

    public fun max_ranges() : u64 {
        8
    }

    public fun migrate(arg0: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::AdminCap, arg1: &mut Registry) {
        assert!(arg1.version < 1, 723);
        let v0 = RegistryMigrated{
            from : arg1.version,
            to   : 1,
        };
        0x2::event::emit<RegistryMigrated>(v0);
        arg1.version = 1;
    }

    public fun min_fund() : u64 {
        10000
    }

    public(friend) fun new_for_bundle<T0, T1, T2>(arg0: &mut Registry, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg2: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::bundle::Bundle<T0, T2>, arg3: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg4: 0x2::coin::Coin<T2>, arg5: u32, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : BuyLadder<T0, T2> {
        assert!(0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::bundle_id<T0, T1, T2>(arg1) == 0x2::object::id<0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::bundle::Bundle<T0, T2>>(arg2), 701);
        assert!(0x2::tx_context::sender(arg7) == 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::bundle::creator<T0, T2>(arg2), 700);
        let v0 = 0x2::tx_context::sender(arg7);
        new_ladder<T0, T1, T2>(arg0, arg1, arg3, 0x2::object::id<0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::bundle::Bundle<T0, T2>>(arg2), v0, 0x2::coin::into_balance<T2>(arg4), arg5, arg6, arg7)
    }

    public(friend) fun new_for_curve<T0, T1, T2>(arg0: &mut Registry, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg2: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::curve_bundle::CurveBundle<T0>, arg3: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg4: 0x2::coin::Coin<T2>, arg5: u32, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : BuyLadder<T0, T2> {
        assert!(0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::bundle_id<T0, T1, T2>(arg1) == 0x2::object::id<0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::curve_bundle::CurveBundle<T0>>(arg2), 701);
        assert!(0x2::tx_context::sender(arg7) == 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::curve_bundle::creator<T0>(arg2), 700);
        let v0 = 0x2::tx_context::sender(arg7);
        new_ladder<T0, T1, T2>(arg0, arg1, arg3, 0x2::object::id<0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::curve_bundle::CurveBundle<T0>>(arg2), v0, 0x2::coin::into_balance<T2>(arg4), arg5, arg6, arg7)
    }

    fun new_ladder<T0, T1, T2>(arg0: &mut Registry, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg2: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg3: 0x2::object::ID, arg4: address, arg5: 0x2::balance::Balance<T2>, arg6: u32, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : BuyLadder<T0, T2> {
        assert_version(arg0);
        assert!(!0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::paused(arg2), 710);
        assert!(!0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::is_sunset<T0, T1, T2>(arg1), 706);
        let v0 = 0x2::balance::value<T2>(&arg5);
        assert!(v0 >= 10000, 709);
        let v1 = 0x2::object::id<0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>>(arg1);
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.ladders, v1), 702);
        let (v2, v3) = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::venue<T0, T1, T2>(arg1);
        let v4 = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::pool_id<T0, T1, T2>(arg1);
        let v5 = BuyLadder<T0, T2>{
            id                : 0x2::object::new(arg8),
            vault_id          : v1,
            bundle_id         : arg3,
            owner             : arg4,
            pool_id           : v4,
            venue             : v2,
            quote_first       : v3,
            tick_spacing      : arg6,
            limits            : ladder_limits(0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::limits<T0, T1, T2>(arg1)),
            idle_t            : 0x2::balance::zero<T0>(),
            idle_q            : arg5,
            ranges            : 0x1::vector::empty<0x2::object::ID>(),
            retired           : 0x1::vector::empty<0x2::object::ID>(),
            observations      : 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::new_observations(),
            turnover          : 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::new_turnover(),
            last_rebalance_ms : 0,
            rebalance_paused  : false,
            state             : 0,
            notice_ms         : 0,
            opened_ms         : arg7,
            funded_q          : v0,
            withdrawn_q       : 0,
            released_t        : 0,
            released_q        : 0,
        };
        let v6 = 0x2::object::id<BuyLadder<T0, T2>>(&v5);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.ladders, v1, v6);
        let v7 = LadderOpened{
            ladder_id    : v6,
            vault_id     : v1,
            bundle_id    : arg3,
            owner        : arg4,
            pool_id      : v4,
            venue        : v2,
            quote_first  : v3,
            amount       : v0,
            timestamp_ms : arg7,
        };
        0x2::event::emit<LadderOpened>(v7);
        v5
    }

    public fun notice_ms<T0, T1>(arg0: &BuyLadder<T0, T1>) : u64 {
        arg0.notice_ms
    }

    public fun notice_period_ms() : u64 {
        600000
    }

    public fun observations<T0, T1>(arg0: &BuyLadder<T0, T1>) : &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::Observations {
        &arg0.observations
    }

    public fun opened_ms<T0, T1>(arg0: &BuyLadder<T0, T1>) : u64 {
        arg0.opened_ms
    }

    public fun owner<T0, T1>(arg0: &BuyLadder<T0, T1>) : address {
        arg0.owner
    }

    public(friend) fun pay_reward<T0, T1, T2>(arg0: &BuyLadder<T0, T1>, arg1: 0x2::object::ID, arg2: 0x2::balance::Balance<T2>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T2>(&arg2);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T2>(arg2);
            return
        };
        let v1 = arg0.owner;
        let v2 = LadderRewardCollected{
            ladder_id   : 0x2::object::id<BuyLadder<T0, T1>>(arg0),
            position_id : arg1,
            coin        : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T2>()),
            amount      : v0,
            to          : v1,
        };
        0x2::event::emit<LadderRewardCollected>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(arg2, arg3), v1);
    }

    public(friend) fun pop_range<T0, T1, T2: store + key>(arg0: &mut BuyLadder<T0, T1>, arg1: 0x2::object::ID) : T2 {
        0x1::vector::swap_remove<0x2::object::ID>(&mut arg0.ranges, range_index<T0, T1>(arg0, arg1));
        let v0 = RangeKey{id: arg1};
        0x2::dynamic_object_field::remove<RangeKey, T2>(&mut arg0.id, v0)
    }

    public(friend) fun pop_retired<T0, T1, T2: store + key>(arg0: &mut BuyLadder<T0, T1>, arg1: 0x2::object::ID) : T2 {
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg0.retired, &arg1);
        assert!(v0, 719);
        0x1::vector::swap_remove<0x2::object::ID>(&mut arg0.retired, v1);
        let v2 = RetiredKey{id: arg1};
        0x2::dynamic_object_field::remove<RetiredKey, T2>(&mut arg0.id, v2)
    }

    public fun quote_first<T0, T1>(arg0: &BuyLadder<T0, T1>) : bool {
        arg0.quote_first
    }

    public(friend) fun range_index<T0, T1>(arg0: &BuyLadder<T0, T1>, arg1: 0x2::object::ID) : u64 {
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg0.ranges, &arg1);
        assert!(v0, 719);
        v1
    }

    public fun ranges<T0, T1>(arg0: &BuyLadder<T0, T1>) : vector<0x2::object::ID> {
        arg0.ranges
    }

    public fun rebalance_paused<T0, T1>(arg0: &BuyLadder<T0, T1>) : bool {
        arg0.rebalance_paused
    }

    public(friend) fun record_bid<T0, T1, T2: store + key>(arg0: &mut Ticket, arg1: &mut BuyLadder<T0, T1>, arg2: T2, arg3: u32, arg4: u32, arg5: u64, arg6: u64, arg7: 0x2::balance::Balance<T1>) {
        assert_ticket<T0, T1>(arg0, arg1);
        assert!(arg5 == 0, 717);
        0x2::balance::join<T1>(&mut arg1.idle_q, arg7);
        arg0.added = arg0.added + arg6;
        let v0 = 0x2::object::id<T2>(&arg2);
        let v1 = RangeKey{id: v0};
        0x2::dynamic_object_field::add<RangeKey, T2>(&mut arg1.id, v1, arg2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.ranges, v0);
        let v2 = LadderRangeAdded{
            ladder_id       : 0x2::object::id<BuyLadder<T0, T1>>(arg1),
            position_id     : v0,
            lower_tick_bits : arg3,
            upper_tick_bits : arg4,
            quote           : arg6,
        };
        0x2::event::emit<LadderRangeAdded>(v2);
    }

    public(friend) fun record_price<T0, T1>(arg0: &mut BuyLadder<T0, T1>, arg1: u64, arg2: u128) {
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::observe(&mut arg0.observations, arg1, arg2);
    }

    public fun release<T0, T1, T2>(arg0: &mut BuyLadder<T0, T2>, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>>(arg1) == arg0.vault_id, 701);
        assert!(0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::is_sunset<T0, T1, T2>(arg1), 706);
        arg0.state = 2;
        let v0 = 0x2::balance::value<T0>(&arg0.idle_t);
        let v1 = 0x2::balance::value<T2>(&arg0.idle_q);
        if (v0 == 0 && v1 == 0) {
            return
        };
        arg0.released_t = arg0.released_t + v0;
        arg0.released_q = arg0.released_q + v1;
        let v2 = arg0.owner;
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.idle_t, v0), arg2), v2);
        } else {
            0x2::balance::destroy_zero<T0>(0x2::balance::split<T0>(&mut arg0.idle_t, v0));
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.idle_q, v1), arg2), v2);
        } else {
            0x2::balance::destroy_zero<T2>(0x2::balance::split<T2>(&mut arg0.idle_q, v1));
        };
        let v3 = LadderReleased{
            ladder_id : 0x2::object::id<BuyLadder<T0, T2>>(arg0),
            owner     : v2,
            tokens    : v0,
            quote     : v1,
        };
        0x2::event::emit<LadderReleased>(v3);
    }

    public(friend) fun retire<T0, T1, T2: store + key>(arg0: &mut BuyLadder<T0, T1>, arg1: T2) {
        let v0 = 0x2::object::id<T2>(&arg1);
        let v1 = RetiredKey{id: v0};
        0x2::dynamic_object_field::add<RetiredKey, T2>(&mut arg0.id, v1, arg1);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.retired, v0);
    }

    public fun retired<T0, T1>(arg0: &BuyLadder<T0, T1>) : vector<0x2::object::ID> {
        arg0.retired
    }

    public fun set_rebalance_paused<T0, T1>(arg0: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::AdminCap, arg1: &mut BuyLadder<T0, T1>, arg2: bool) {
        arg1.rebalance_paused = arg2;
        let v0 = LadderPauseChanged{
            ladder_id : 0x2::object::id<BuyLadder<T0, T1>>(arg1),
            paused    : arg2,
        };
        0x2::event::emit<LadderPauseChanged>(v0);
    }

    public(friend) fun share<T0, T1>(arg0: BuyLadder<T0, T1>) {
        0x2::transfer::share_object<BuyLadder<T0, T1>>(arg0);
    }

    public(friend) fun start_ticket<T0, T1, T2>(arg0: &mut BuyLadder<T0, T2>, arg1: &Registry, arg2: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg3: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg4: 0x2::object::ID, arg5: u64, arg6: &0x2::tx_context::TxContext) : u128 {
        assert_version(arg1);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::assert_keeper(arg3, arg6);
        assert!(0x2::object::id<0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>>(arg2) == arg0.vault_id, 701);
        assert!(!0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::is_sunset<T0, T1, T2>(arg2), 706);
        assert!(!0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::ladder_pending<T0, T1, T2>(arg2), 711);
        assert!(arg4 == arg0.pool_id, 707);
        assert_bidding<T0, T2>(arg0, arg5);
        assert!(!arg0.rebalance_paused, 724);
        assert!(arg0.last_rebalance_ms == 0 || arg5 >= arg0.last_rebalance_ms + 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::min_interval_ms(&arg0.limits), 713);
        arg0.last_rebalance_ms = arg5;
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::reference(&arg0.observations, arg5)
    }

    public fun state<T0, T1>(arg0: &BuyLadder<T0, T1>) : u8 {
        arg0.state
    }

    public fun state_active() : u8 {
        0
    }

    public fun state_closed() : u8 {
        2
    }

    public fun state_notice() : u8 {
        1
    }

    public(friend) fun take_idle_q<T0, T1>(arg0: &mut BuyLadder<T0, T1>) : 0x2::balance::Balance<T1> {
        0x2::balance::withdraw_all<T1>(&mut arg0.idle_q)
    }

    public fun tick_spacing<T0, T1>(arg0: &BuyLadder<T0, T1>) : u32 {
        arg0.tick_spacing
    }

    public fun ticket_ref(arg0: &Ticket) : u128 {
        arg0.ref_sqrt
    }

    public fun totals<T0, T1>(arg0: &BuyLadder<T0, T1>) : (u64, u64, u64, u64) {
        (arg0.funded_q, arg0.withdrawn_q, arg0.released_t, arg0.released_q)
    }

    public fun turnover_24h<T0, T1>(arg0: &BuyLadder<T0, T1>, arg1: u64) : u64 {
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::limits::turnover(&arg0.turnover, arg1)
    }

    public fun vault_id<T0, T1>(arg0: &BuyLadder<T0, T1>) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun version(arg0: &Registry) : u64 {
        arg0.version
    }

    public fun withdraw_from_ms<T0, T1>(arg0: &BuyLadder<T0, T1>) : u64 {
        if (arg0.state == 1) {
            arg0.notice_ms + 600000
        } else {
            0
        }
    }

    public fun withdraw_quote<T0, T1>(arg0: &mut BuyLadder<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 700);
        if (arg0.state == 1) {
            assert!(0x2::clock::timestamp_ms(arg1) >= arg0.notice_ms + 600000, 705);
        } else {
            assert!(arg0.state == 2, 704);
        };
        let v0 = 0x2::balance::value<T1>(&arg0.idle_q);
        arg0.state = 2;
        arg0.withdrawn_q = arg0.withdrawn_q + v0;
        let v1 = LadderWithdrawn{
            ladder_id : 0x2::object::id<BuyLadder<T0, T1>>(arg0),
            owner     : arg0.owner,
            quote     : v0,
        };
        0x2::event::emit<LadderWithdrawn>(v1);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.idle_q, v0), arg2)
    }

    // decompiled from Move bytecode v7
}

