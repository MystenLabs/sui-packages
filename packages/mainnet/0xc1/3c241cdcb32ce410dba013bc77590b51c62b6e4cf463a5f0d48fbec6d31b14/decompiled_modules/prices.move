module 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices {
    struct AcceptedPrice has copy, drop, store {
        price: u64,
        publish_time_ms: u64,
        accepted_at_ms: u64,
        round: u64,
        source: u8,
        quote: u8,
    }

    struct FeedBinding has store {
        pair_index: u32,
        token_decimals: u8,
        quote: u8,
        breaker_tripped: bool,
        accepted: vector<AcceptedPrice>,
    }

    struct PendingBinding has drop, store {
        pair_index: u32,
        token_decimals: u8,
        quote: u8,
        reference_price: u64,
        reference_band_bps: u64,
        effective_ms: u64,
    }

    struct FirstBound has drop, store {
        reference_price: u64,
        band_bps: u64,
    }

    struct AcceptedPrices has store {
        bound: 0x2::table::Table<0x1::type_name::TypeName, FeedBinding>,
        pending: 0x2::table::Table<0x1::type_name::TypeName, PendingBinding>,
        first_bound: 0x2::table::Table<0x1::type_name::TypeName, FirstBound>,
    }

    struct BindingProposed has copy, drop {
        token: 0x1::type_name::TypeName,
        pair_index: u32,
        quote: u8,
        reference_price: u64,
        effective_ms: u64,
    }

    struct BindingCancelled has copy, drop {
        token: 0x1::type_name::TypeName,
        pair_index: u32,
        timestamp_ms: u64,
    }

    struct BindingExecuted has copy, drop {
        token: 0x1::type_name::TypeName,
        pair_index: u32,
        token_decimals: u8,
        quote: u8,
    }

    struct RebindProposed has copy, drop {
        token: 0x1::type_name::TypeName,
        old_pair_index: u32,
        new_pair_index: u32,
        quote: u8,
        reference_price: u64,
        effective_ms: u64,
    }

    struct RebindExecuted has copy, drop {
        token: 0x1::type_name::TypeName,
        old_pair_index: u32,
        new_pair_index: u32,
        token_decimals: u8,
        quote: u8,
    }

    struct RebindCancelled has copy, drop {
        token: 0x1::type_name::TypeName,
        pair_index: u32,
        timestamp_ms: u64,
    }

    struct PriceCommitted has copy, drop {
        token: 0x1::type_name::TypeName,
        price: u64,
        publish_time_ms: u64,
        round: u64,
    }

    struct BreakerTripped has copy, drop {
        token: 0x1::type_name::TypeName,
        baseline: u64,
        rejected: u64,
        deviation_bps: u64,
        timestamp_ms: u64,
    }

    struct BreakerReset has copy, drop {
        token: 0x1::type_name::TypeName,
        discarded_baseline: u64,
        reference_price: u64,
        band_bps: u64,
        timestamp_ms: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : AcceptedPrices {
        AcceptedPrices{
            bound       : 0x2::table::new<0x1::type_name::TypeName, FeedBinding>(arg0),
            pending     : 0x2::table::new<0x1::type_name::TypeName, PendingBinding>(arg0),
            first_bound : 0x2::table::new<0x1::type_name::TypeName, FirstBound>(arg0),
        }
    }

    public(friend) fun assert_migration_valid(arg0: &AcceptedPrices, arg1: &vector<0x1::type_name::TypeName>, arg2: u8) {
        assert!(0x2::table::length<0x1::type_name::TypeName, PendingBinding>(&arg0.pending) == 0, 302);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(arg1)) {
            let v1 = *0x1::vector::borrow<0x1::type_name::TypeName>(arg1, v0);
            assert!(0x2::table::contains<0x1::type_name::TypeName, FeedBinding>(&arg0.bound, v1), 300);
            let v2 = 0x2::table::borrow<0x1::type_name::TypeName, FeedBinding>(&arg0.bound, v1);
            assert!(v2.quote == arg2, 305);
            assert!(0x1::vector::length<AcceptedPrice>(&v2.accepted) == 1, 313);
            let v3 = 0x1::vector::borrow<AcceptedPrice>(&v2.accepted, 0);
            assert!(v3.price > 0, 313);
            assert!(v3.quote == arg2, 305);
            assert!(v3.source == 0xcf4714f33270d3bc3ecbb1a5217c73bfd7af5401765d291fbae6080f28aabd10::observation::source_supra(), 316);
            v0 = v0 + 1;
        };
    }

    public(friend) fun cancel_binding<T0>(arg0: &mut AcceptedPrices, arg1: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, PendingBinding>(&arg0.pending, v0), 310);
        let v1 = 0x2::table::remove<0x1::type_name::TypeName, PendingBinding>(&mut arg0.pending, v0);
        if (0x2::table::contains<0x1::type_name::TypeName, FeedBinding>(&arg0.bound, v0)) {
            let v2 = RebindCancelled{
                token        : v0,
                pair_index   : v1.pair_index,
                timestamp_ms : 0x2::clock::timestamp_ms(arg1),
            };
            0x2::event::emit<RebindCancelled>(v2);
        } else {
            let v3 = BindingCancelled{
                token        : v0,
                pair_index   : v1.pair_index,
                timestamp_ms : 0x2::clock::timestamp_ms(arg1),
            };
            0x2::event::emit<BindingCancelled>(v3);
        };
    }

    public(friend) fun commit<T0>(arg0: &mut AcceptedPrices, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::Policy, arg2: 0xcf4714f33270d3bc3ecbb1a5217c73bfd7af5401765d291fbae6080f28aabd10::observation::Observation, arg3: &0x2::clock::Clock) : u8 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedBinding>(&arg0.bound, v0), 300);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::numeraire(arg1);
        let v3 = 0x2::table::borrow_mut<0x1::type_name::TypeName, FeedBinding>(&mut arg0.bound, v0);
        assert!(!v3.breaker_tripped, 307);
        assert!(0xcf4714f33270d3bc3ecbb1a5217c73bfd7af5401765d291fbae6080f28aabd10::observation::holder(&arg2) == 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::supra_holder(arg1), 314);
        assert!(0xcf4714f33270d3bc3ecbb1a5217c73bfd7af5401765d291fbae6080f28aabd10::observation::pair_index(&arg2) == v3.pair_index, 304);
        assert!(0xcf4714f33270d3bc3ecbb1a5217c73bfd7af5401765d291fbae6080f28aabd10::observation::quote(&arg2) == v2, 305);
        assert!(v3.quote == v2, 305);
        let v4 = 0xcf4714f33270d3bc3ecbb1a5217c73bfd7af5401765d291fbae6080f28aabd10::observation::price(&arg2);
        assert!(normalise(0xcf4714f33270d3bc3ecbb1a5217c73bfd7af5401765d291fbae6080f28aabd10::observation::raw_value(&arg2), 0xcf4714f33270d3bc3ecbb1a5217c73bfd7af5401765d291fbae6080f28aabd10::observation::raw_decimal(&arg2)) == v4, 315);
        assert!(0xcf4714f33270d3bc3ecbb1a5217c73bfd7af5401765d291fbae6080f28aabd10::observation::source(&arg2) == 0xcf4714f33270d3bc3ecbb1a5217c73bfd7af5401765d291fbae6080f28aabd10::observation::source_supra(), 316);
        let v5 = 0xcf4714f33270d3bc3ecbb1a5217c73bfd7af5401765d291fbae6080f28aabd10::observation::publish_time_ms(&arg2);
        let v6 = 0xcf4714f33270d3bc3ecbb1a5217c73bfd7af5401765d291fbae6080f28aabd10::observation::round(&arg2);
        assert!(v5 + 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::max_price_age_ms(arg1) >= v1, 306);
        if (0x1::vector::is_empty<AcceptedPrice>(&v3.accepted)) {
            if (0x2::table::contains<0x1::type_name::TypeName, FirstBound>(&arg0.first_bound, v0)) {
                let v7 = 0x2::table::borrow<0x1::type_name::TypeName, FirstBound>(&arg0.first_bound, v0);
                let v8 = if (v4 > v7.reference_price) {
                    v4 - v7.reference_price
                } else {
                    v7.reference_price - v4
                };
                assert!((((v8 as u128) * (10000 as u128) / (v7.reference_price as u128)) as u64) <= v7.band_bps, 309);
            };
            let v9 = AcceptedPrice{
                price           : v4,
                publish_time_ms : v5,
                accepted_at_ms  : v1,
                round           : v6,
                source          : 0xcf4714f33270d3bc3ecbb1a5217c73bfd7af5401765d291fbae6080f28aabd10::observation::source(&arg2),
                quote           : 0xcf4714f33270d3bc3ecbb1a5217c73bfd7af5401765d291fbae6080f28aabd10::observation::quote(&arg2),
            };
            0x1::vector::push_back<AcceptedPrice>(&mut v3.accepted, v9);
            if (0x2::table::contains<0x1::type_name::TypeName, FirstBound>(&arg0.first_bound, v0)) {
                0x2::table::remove<0x1::type_name::TypeName, FirstBound>(&mut arg0.first_bound, v0);
            };
            let v10 = PriceCommitted{
                token           : v0,
                price           : v4,
                publish_time_ms : v5,
                round           : v6,
            };
            0x2::event::emit<PriceCommitted>(v10);
            return 0
        };
        let v11 = *0x1::vector::borrow<AcceptedPrice>(&v3.accepted, 0);
        assert!(0xcf4714f33270d3bc3ecbb1a5217c73bfd7af5401765d291fbae6080f28aabd10::observation::source(&arg2) == v11.source, 316);
        if (v6 == v11.round) {
            return 2
        };
        assert!(v6 > v11.round, 311);
        let v12 = if (v4 > v11.price) {
            v4 - v11.price
        } else {
            v11.price - v4
        };
        let v13 = (((v12 as u128) * (10000 as u128) / (v11.price as u128)) as u64);
        if (v13 > 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::max_deviation_bps(arg1)) {
            v3.breaker_tripped = true;
            let v14 = BreakerTripped{
                token         : v0,
                baseline      : v11.price,
                rejected      : v4,
                deviation_bps : v13,
                timestamp_ms  : v1,
            };
            0x2::event::emit<BreakerTripped>(v14);
            return 1
        };
        let v15 = AcceptedPrice{
            price           : v4,
            publish_time_ms : v5,
            accepted_at_ms  : v1,
            round           : v6,
            source          : 0xcf4714f33270d3bc3ecbb1a5217c73bfd7af5401765d291fbae6080f28aabd10::observation::source(&arg2),
            quote           : 0xcf4714f33270d3bc3ecbb1a5217c73bfd7af5401765d291fbae6080f28aabd10::observation::quote(&arg2),
        };
        *0x1::vector::borrow_mut<AcceptedPrice>(&mut v3.accepted, 0) = v15;
        let v16 = PriceCommitted{
            token           : v0,
            price           : v4,
            publish_time_ms : v5,
            round           : v6,
        };
        0x2::event::emit<PriceCommitted>(v16);
        0
    }

    public(friend) fun decimals_of(arg0: &AcceptedPrices, arg1: 0x1::type_name::TypeName) : u8 {
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedBinding>(&arg0.bound, arg1), 300);
        0x2::table::borrow<0x1::type_name::TypeName, FeedBinding>(&arg0.bound, arg1).token_decimals
    }

    public(friend) fun execute_binding<T0>(arg0: &mut AcceptedPrices, arg1: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, PendingBinding>(&arg0.pending, v0), 310);
        assert!(!0x2::table::contains<0x1::type_name::TypeName, FeedBinding>(&arg0.bound, v0), 301);
        let v1 = 0x2::table::remove<0x1::type_name::TypeName, PendingBinding>(&mut arg0.pending, v0);
        assert!(0x2::clock::timestamp_ms(arg1) >= v1.effective_ms, 303);
        let v2 = FeedBinding{
            pair_index      : v1.pair_index,
            token_decimals  : v1.token_decimals,
            quote           : v1.quote,
            breaker_tripped : false,
            accepted        : 0x1::vector::empty<AcceptedPrice>(),
        };
        0x2::table::add<0x1::type_name::TypeName, FeedBinding>(&mut arg0.bound, v0, v2);
        let v3 = FirstBound{
            reference_price : v1.reference_price,
            band_bps        : v1.reference_band_bps,
        };
        0x2::table::add<0x1::type_name::TypeName, FirstBound>(&mut arg0.first_bound, v0, v3);
        let v4 = BindingExecuted{
            token          : v0,
            pair_index     : v1.pair_index,
            token_decimals : v1.token_decimals,
            quote          : v1.quote,
        };
        0x2::event::emit<BindingExecuted>(v4);
    }

    public(friend) fun execute_rebind<T0>(arg0: &mut AcceptedPrices, arg1: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, PendingBinding>(&arg0.pending, v0), 310);
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedBinding>(&arg0.bound, v0), 300);
        let v1 = 0x2::table::remove<0x1::type_name::TypeName, PendingBinding>(&mut arg0.pending, v0);
        assert!(0x2::clock::timestamp_ms(arg1) >= v1.effective_ms, 303);
        let FeedBinding {
            pair_index      : v2,
            token_decimals  : _,
            quote           : _,
            breaker_tripped : _,
            accepted        : _,
        } = 0x2::table::remove<0x1::type_name::TypeName, FeedBinding>(&mut arg0.bound, v0);
        let v7 = FeedBinding{
            pair_index      : v1.pair_index,
            token_decimals  : v1.token_decimals,
            quote           : v1.quote,
            breaker_tripped : false,
            accepted        : 0x1::vector::empty<AcceptedPrice>(),
        };
        0x2::table::add<0x1::type_name::TypeName, FeedBinding>(&mut arg0.bound, v0, v7);
        if (0x2::table::contains<0x1::type_name::TypeName, FirstBound>(&arg0.first_bound, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, FirstBound>(&mut arg0.first_bound, v0);
        };
        let v8 = FirstBound{
            reference_price : v1.reference_price,
            band_bps        : v1.reference_band_bps,
        };
        0x2::table::add<0x1::type_name::TypeName, FirstBound>(&mut arg0.first_bound, v0, v8);
        let v9 = RebindExecuted{
            token          : v0,
            old_pair_index : v2,
            new_pair_index : v1.pair_index,
            token_decimals : v1.token_decimals,
            quote          : v1.quote,
        };
        0x2::event::emit<RebindExecuted>(v9);
    }

    public(friend) fun get(arg0: &AcceptedPrices, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::Policy, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock) : u64 {
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedBinding>(&arg0.bound, arg2), 300);
        let v0 = 0x2::table::borrow<0x1::type_name::TypeName, FeedBinding>(&arg0.bound, arg2);
        assert!(!v0.breaker_tripped, 307);
        assert!(!0x1::vector::is_empty<AcceptedPrice>(&v0.accepted), 308);
        let v1 = 0x1::vector::borrow<AcceptedPrice>(&v0.accepted, 0);
        assert!(v1.publish_time_ms + 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::max_price_age_ms(arg1) >= 0x2::clock::timestamp_ms(arg3), 306);
        v1.price
    }

    public fun has_accepted(arg0: &AcceptedPrices, arg1: 0x1::type_name::TypeName) : bool {
        if (!0x2::table::contains<0x1::type_name::TypeName, FeedBinding>(&arg0.bound, arg1)) {
            return false
        };
        !0x1::vector::is_empty<AcceptedPrice>(&0x2::table::borrow<0x1::type_name::TypeName, FeedBinding>(&arg0.bound, arg1).accepted)
    }

    public fun is_bound(arg0: &AcceptedPrices, arg1: 0x1::type_name::TypeName) : bool {
        0x2::table::contains<0x1::type_name::TypeName, FeedBinding>(&arg0.bound, arg1)
    }

    public fun is_pending(arg0: &AcceptedPrices, arg1: 0x1::type_name::TypeName) : bool {
        0x2::table::contains<0x1::type_name::TypeName, PendingBinding>(&arg0.pending, arg1)
    }

    public fun is_tripped(arg0: &AcceptedPrices, arg1: 0x1::type_name::TypeName) : bool {
        if (!0x2::table::contains<0x1::type_name::TypeName, FeedBinding>(&arg0.bound, arg1)) {
            return false
        };
        0x2::table::borrow<0x1::type_name::TypeName, FeedBinding>(&arg0.bound, arg1).breaker_tripped
    }

    fun normalise(arg0: u128, arg1: u16) : u64 {
        assert!(arg1 <= 18, 317);
        let v0 = (arg1 as u128);
        if (v0 == 6) {
            (arg0 as u64)
        } else if (v0 > 6) {
            ((arg0 / pow10(((v0 - 6) as u64))) as u64)
        } else {
            ((arg0 * pow10(((6 - v0) as u64))) as u64)
        }
    }

    public fun outcome_accepted() : u8 {
        0
    }

    public fun outcome_breaker_tripped() : u8 {
        1
    }

    public fun outcome_unchanged() : u8 {
        2
    }

    public fun pair_index_of(arg0: &AcceptedPrices, arg1: 0x1::type_name::TypeName) : u32 {
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedBinding>(&arg0.bound, arg1), 300);
        0x2::table::borrow<0x1::type_name::TypeName, FeedBinding>(&arg0.bound, arg1).pair_index
    }

    public fun pending_count(arg0: &AcceptedPrices) : u64 {
        0x2::table::length<0x1::type_name::TypeName, PendingBinding>(&arg0.pending)
    }

    fun pow10(arg0: u64) : u128 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun propose_binding<T0>(arg0: &mut AcceptedPrices, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::Policy, arg2: u32, arg3: u8, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, FeedBinding>(&arg0.bound, v0), 301);
        assert!(!0x2::table::contains<0x1::type_name::TypeName, PendingBinding>(&arg0.pending, v0), 302);
        assert!(arg4 > 0, 312);
        assert!(arg5 > 0, 312);
        let v1 = 0x2::clock::timestamp_ms(arg6) + 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::feed_timelock_ms(arg1);
        let v2 = PendingBinding{
            pair_index         : arg2,
            token_decimals     : arg3,
            quote              : 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::numeraire(arg1),
            reference_price    : arg4,
            reference_band_bps : arg5,
            effective_ms       : v1,
        };
        0x2::table::add<0x1::type_name::TypeName, PendingBinding>(&mut arg0.pending, v0, v2);
        let v3 = BindingProposed{
            token           : v0,
            pair_index      : arg2,
            quote           : 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::numeraire(arg1),
            reference_price : arg4,
            effective_ms    : v1,
        };
        0x2::event::emit<BindingProposed>(v3);
    }

    public(friend) fun propose_rebind<T0>(arg0: &mut AcceptedPrices, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::Policy, arg2: u32, arg3: u8, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedBinding>(&arg0.bound, v0), 300);
        assert!(!0x2::table::contains<0x1::type_name::TypeName, PendingBinding>(&arg0.pending, v0), 302);
        assert!(arg4 > 0, 312);
        assert!(arg5 > 0, 312);
        let v1 = 0x2::clock::timestamp_ms(arg6) + 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::feed_timelock_ms(arg1);
        let v2 = PendingBinding{
            pair_index         : arg2,
            token_decimals     : arg3,
            quote              : 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::numeraire(arg1),
            reference_price    : arg4,
            reference_band_bps : arg5,
            effective_ms       : v1,
        };
        0x2::table::add<0x1::type_name::TypeName, PendingBinding>(&mut arg0.pending, v0, v2);
        let v3 = RebindProposed{
            token           : v0,
            old_pair_index  : 0x2::table::borrow<0x1::type_name::TypeName, FeedBinding>(&arg0.bound, v0).pair_index,
            new_pair_index  : arg2,
            quote           : 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::numeraire(arg1),
            reference_price : arg4,
            effective_ms    : v1,
        };
        0x2::event::emit<RebindProposed>(v3);
    }

    public(friend) fun reset_breaker<T0>(arg0: &mut AcceptedPrices, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedBinding>(&arg0.bound, v0), 300);
        assert!(arg1 > 0, 312);
        assert!(arg2 > 0, 312);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, FeedBinding>(&mut arg0.bound, v0);
        v1.breaker_tripped = false;
        let v2 = if (!0x1::vector::is_empty<AcceptedPrice>(&v1.accepted)) {
            let AcceptedPrice {
                price           : v3,
                publish_time_ms : _,
                accepted_at_ms  : _,
                round           : _,
                source          : _,
                quote           : _,
            } = 0x1::vector::pop_back<AcceptedPrice>(&mut v1.accepted);
            v3
        } else {
            0
        };
        if (0x2::table::contains<0x1::type_name::TypeName, FirstBound>(&arg0.first_bound, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, FirstBound>(&mut arg0.first_bound, v0);
        };
        let v9 = FirstBound{
            reference_price : arg1,
            band_bps        : arg2,
        };
        0x2::table::add<0x1::type_name::TypeName, FirstBound>(&mut arg0.first_bound, v0, v9);
        let v10 = BreakerReset{
            token              : v0,
            discarded_baseline : v2,
            reference_price    : arg1,
            band_bps           : arg2,
            timestamp_ms       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<BreakerReset>(v10);
    }

    // decompiled from Move bytecode v7
}

