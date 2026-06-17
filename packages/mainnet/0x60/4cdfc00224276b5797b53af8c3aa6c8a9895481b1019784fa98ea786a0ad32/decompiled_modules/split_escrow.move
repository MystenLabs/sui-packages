module 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::split_escrow {
    struct SplitEscrow<phantom T0> has key {
        id: 0x2::object::UID,
        market_core_id: 0x2::object::ID,
        adapter_auth_type: 0x1::type_name::TypeName,
        backing: 0x2::balance::Balance<T0>,
        carved_yield: 0x2::balance::Balance<T0>,
        initial_index: u128,
        yield_debt: u128,
        notional: u64,
        maturity_ms: u64,
        max_yield_extractable_sy: u64,
        total_yield_extracted_sy: u64,
        claim_fee_bps: u16,
        redeem_fee_bps: u16,
        combine_fee_bps: u16,
        hard_cap_breached: bool,
        paused: bool,
        pt_consumed: bool,
        yt_consumed: bool,
    }

    struct YieldOut<phantom T0> {
        sy: 0x2::balance::Balance<T0>,
        theoretical_sy: u64,
        actual_sy: u64,
        hit_hard_cap: bool,
    }

    public fun id<T0>(arg0: &SplitEscrow<T0>) : 0x2::object::ID {
        0x2::object::id<SplitEscrow<T0>>(arg0)
    }

    public fun new<T0, T1: drop>(arg0: &0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::MarketCore<T0>, arg1: &T1, arg2: 0x2::balance::Balance<T0>, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) : SplitEscrow<T0> {
        0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::auth::assert_auth<T1>(0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::adapter_auth_type_ref<T0>(arg0));
        let v0 = 0x2::balance::value<T0>(&arg2);
        assert!(v0 >= 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::constants::min_split_amount(), 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_amount_too_small());
        SplitEscrow<T0>{
            id                       : 0x2::object::new(arg4),
            market_core_id           : 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::id<T0>(arg0),
            adapter_auth_type        : 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::adapter_auth_type<T0>(arg0),
            backing                  : arg2,
            carved_yield             : 0x2::balance::zero<T0>(),
            initial_index            : arg3,
            yield_debt               : arg3,
            notional                 : v0,
            maturity_ms              : 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::maturity_ms<T0>(arg0),
            max_yield_extractable_sy : 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::math_ext::mul_div_down_u64(v0, (0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::yt_extract_ratio_bps<T0>(arg0) as u64), (0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::constants::bps_denominator() as u64)),
            total_yield_extracted_sy : 0,
            claim_fee_bps            : 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::claim_fee_bps<T0>(arg0),
            redeem_fee_bps           : 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::redeem_fee_bps<T0>(arg0),
            combine_fee_bps          : 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::combine_fee_bps<T0>(arg0),
            hard_cap_breached        : false,
            paused                   : false,
            pt_consumed              : false,
            yt_consumed              : false,
        }
    }

    public fun adapter_auth_type_ref<T0>(arg0: &SplitEscrow<T0>) : &0x1::type_name::TypeName {
        &arg0.adapter_auth_type
    }

    public fun claim_fee_bps<T0>(arg0: &SplitEscrow<T0>) : u16 {
        arg0.claim_fee_bps
    }

    public fun combine_fee_bps<T0>(arg0: &SplitEscrow<T0>) : u16 {
        arg0.combine_fee_bps
    }

    public fun maturity_ms<T0>(arg0: &SplitEscrow<T0>) : u64 {
        arg0.maturity_ms
    }

    public fun redeem_fee_bps<T0>(arg0: &SplitEscrow<T0>) : u16 {
        arg0.redeem_fee_bps
    }

    public fun backing_value<T0>(arg0: &SplitEscrow<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.backing)
    }

    fun carve_current_yield<T0>(arg0: &mut SplitEscrow<T0>, arg1: u128) : 0x2::balance::Balance<T0> {
        let v0 = compute_yield_pending<T0>(arg0, arg1);
        if (arg1 > arg0.yield_debt) {
            arg0.yield_debt = arg1;
        };
        if (v0 == 0) {
            0x2::balance::zero<T0>()
        } else {
            0x2::balance::split<T0>(&mut arg0.backing, v0)
        }
    }

    public fun carved_yield_value<T0>(arg0: &SplitEscrow<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.carved_yield)
    }

    public fun close_pt_side<T0, T1: drop>(arg0: &mut SplitEscrow<T0>, arg1: &mut 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::MarketCore<T0>, arg2: &T1, arg3: &0x2::clock::Clock, arg4: u128) : 0x2::balance::Balance<T0> {
        0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::auth::assert_auth<T1>(&arg0.adapter_auth_type);
        assert!(arg0.market_core_id == 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::id<T0>(arg1), 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_wrong_market_core());
        assert!(!arg0.pt_consumed, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_already_consumed());
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.maturity_ms, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_not_matured());
        assert!(!arg0.paused, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_escrow_paused());
        if (!arg0.yt_consumed) {
            move_current_yield_to_carved<T0>(arg0, arg1, arg4, arg3);
        };
        arg0.pt_consumed = true;
        arg0.notional = 0;
        0x2::balance::withdraw_all<T0>(&mut arg0.backing)
    }

    fun compute_yield_pending<T0>(arg0: &SplitEscrow<T0>, arg1: u128) : u64 {
        if (arg1 <= arg0.yield_debt) {
            return 0
        };
        let v0 = 0x2::balance::value<T0>(&arg0.backing);
        if (v0 == 0) {
            return 0
        };
        let v1 = 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::math_ext::mul_div_down_u128((v0 as u128), arg1 - arg0.yield_debt, arg1);
        assert!(v1 <= 18446744073709551615, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_overflow());
        (v1 as u64)
    }

    public fun consume_for_combine<T0, T1: drop>(arg0: &mut SplitEscrow<T0>, arg1: &mut 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::MarketCore<T0>, arg2: &T1, arg3: u128, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>) {
        0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::auth::assert_auth<T1>(&arg0.adapter_auth_type);
        assert!(arg0.market_core_id == 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::id<T0>(arg1), 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_wrong_market_core());
        assert!(!arg0.paused, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_escrow_paused());
        assert!(!arg0.pt_consumed, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_already_consumed());
        assert!(!arg0.yt_consumed, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_already_consumed());
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg0.carved_yield);
        let v1 = carve_current_yield<T0>(arg0, arg3);
        let v2 = 0x2::balance::value<T0>(&v1);
        let v3 = 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::math_ext::min_u64(v2, arg0.max_yield_extractable_sy - arg0.total_yield_extracted_sy);
        if (v3 < v2) {
            0x2::balance::join<T0>(&mut arg0.backing, 0x2::balance::split<T0>(&mut v1, v2 - v3));
        };
        arg0.total_yield_extracted_sy = arg0.total_yield_extracted_sy + v3;
        if (arg0.total_yield_extracted_sy >= arg0.max_yield_extractable_sy && !arg0.hard_cap_breached) {
            arg0.hard_cap_breached = true;
            0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::hard_cap_pause_entry<T0>(arg1, 0x2::object::id<SplitEscrow<T0>>(arg0), arg0.total_yield_extracted_sy, arg0.max_yield_extractable_sy, 0x2::clock::timestamp_ms(arg4));
        };
        0x2::balance::join<T0>(&mut v0, v1);
        arg0.notional = 0;
        arg0.pt_consumed = true;
        arg0.yt_consumed = true;
        (0x2::balance::withdraw_all<T0>(&mut arg0.backing), v0)
    }

    public fun destroy_settled<T0>(arg0: SplitEscrow<T0>) {
        let SplitEscrow {
            id                       : v0,
            market_core_id           : _,
            adapter_auth_type        : _,
            backing                  : v3,
            carved_yield             : v4,
            initial_index            : _,
            yield_debt               : _,
            notional                 : _,
            maturity_ms              : _,
            max_yield_extractable_sy : _,
            total_yield_extracted_sy : _,
            claim_fee_bps            : _,
            redeem_fee_bps           : _,
            combine_fee_bps          : _,
            hard_cap_breached        : _,
            paused                   : _,
            pt_consumed              : v16,
            yt_consumed              : v17,
        } = arg0;
        let v18 = v4;
        let v19 = v3;
        assert!(v16 && v17, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_escrow_not_settled());
        assert!(0x2::balance::value<T0>(&v19) == 0, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_escrow_not_settled());
        assert!(0x2::balance::value<T0>(&v18) == 0, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_escrow_not_settled());
        0x2::balance::destroy_zero<T0>(v19);
        0x2::balance::destroy_zero<T0>(v18);
        0x2::object::delete(v0);
    }

    public fun drain_yt_after_pt_closed<T0, T1: drop>(arg0: &mut SplitEscrow<T0>, arg1: &0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::MarketCore<T0>, arg2: &T1) : 0x2::balance::Balance<T0> {
        0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::auth::assert_auth<T1>(&arg0.adapter_auth_type);
        assert!(arg0.market_core_id == 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::id<T0>(arg1), 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_wrong_market_core());
        assert!(arg0.pt_consumed, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_pt_not_consumed());
        assert!(!arg0.yt_consumed, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_already_consumed());
        assert!(!arg0.paused, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_escrow_paused());
        arg0.yt_consumed = true;
        0x2::balance::withdraw_all<T0>(&mut arg0.carved_yield)
    }

    public(friend) fun force_finalize_paused_yt<T0>(arg0: &mut SplitEscrow<T0>) : 0x2::balance::Balance<T0> {
        assert!(arg0.paused, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_not_paused());
        assert!(!arg0.yt_consumed, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_already_consumed());
        arg0.yt_consumed = true;
        if (arg0.pt_consumed) {
            0x2::balance::withdraw_all<T0>(&mut arg0.carved_yield)
        } else {
            0x2::balance::zero<T0>()
        }
    }

    public fun hard_cap_breached<T0>(arg0: &SplitEscrow<T0>) : bool {
        arg0.hard_cap_breached
    }

    public fun initial_index<T0>(arg0: &SplitEscrow<T0>) : u128 {
        arg0.initial_index
    }

    public fun is_paused<T0>(arg0: &SplitEscrow<T0>) : bool {
        arg0.paused
    }

    public fun is_pt_consumed<T0>(arg0: &SplitEscrow<T0>) : bool {
        arg0.pt_consumed
    }

    public fun is_yt_consumed<T0>(arg0: &SplitEscrow<T0>) : bool {
        arg0.yt_consumed
    }

    public(friend) fun mark_yt_consumed<T0>(arg0: &mut SplitEscrow<T0>) {
        assert!(!arg0.yt_consumed, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_already_consumed());
        arg0.yt_consumed = true;
    }

    public fun market_core_id<T0>(arg0: &SplitEscrow<T0>) : 0x2::object::ID {
        arg0.market_core_id
    }

    public fun max_yield_extractable_sy<T0>(arg0: &SplitEscrow<T0>) : u64 {
        arg0.max_yield_extractable_sy
    }

    fun move_current_yield_to_carved<T0>(arg0: &mut SplitEscrow<T0>, arg1: &mut 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::MarketCore<T0>, arg2: u128, arg3: &0x2::clock::Clock) {
        let v0 = carve_current_yield<T0>(arg0, arg2);
        let v1 = 0x2::balance::value<T0>(&v0);
        let v2 = 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::math_ext::min_u64(v1, arg0.max_yield_extractable_sy - arg0.total_yield_extracted_sy);
        if (v2 < v1) {
            0x2::balance::join<T0>(&mut arg0.backing, 0x2::balance::split<T0>(&mut v0, v1 - v2));
        };
        arg0.total_yield_extracted_sy = arg0.total_yield_extracted_sy + v2;
        if (arg0.total_yield_extracted_sy >= arg0.max_yield_extractable_sy && !arg0.hard_cap_breached) {
            arg0.hard_cap_breached = true;
            0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::hard_cap_pause_entry<T0>(arg1, 0x2::object::id<SplitEscrow<T0>>(arg0), arg0.total_yield_extracted_sy, arg0.max_yield_extractable_sy, 0x2::clock::timestamp_ms(arg3));
        };
        0x2::balance::join<T0>(&mut arg0.carved_yield, v0);
    }

    public fun notional<T0>(arg0: &SplitEscrow<T0>) : u64 {
        arg0.notional
    }

    public fun pause_with_cap<T0>(arg0: &mut SplitEscrow<T0>, arg1: &0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::caps::PauseCap, arg2: vector<u8>) {
        let v0 = arg0.pt_consumed && arg0.yt_consumed;
        assert!(!v0, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_escrow_not_settled());
        arg0.paused = true;
        0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::events::emit_paused(2, 0x2::object::id<SplitEscrow<T0>>(arg0), 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::pause_state::lock_global(), 0, arg2);
    }

    public fun pt_floor_sy<T0>(arg0: &SplitEscrow<T0>) : u64 {
        if (arg0.notional == 0) {
            return 0
        };
        if (arg0.max_yield_extractable_sy >= arg0.notional) {
            return 0
        };
        arg0.notional - arg0.max_yield_extractable_sy
    }

    public fun realize_yield_capped<T0, T1: drop>(arg0: &mut SplitEscrow<T0>, arg1: &mut 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::MarketCore<T0>, arg2: &T1, arg3: u128, arg4: &0x2::clock::Clock) : YieldOut<T0> {
        0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::auth::assert_auth<T1>(&arg0.adapter_auth_type);
        assert!(arg0.market_core_id == 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::id<T0>(arg1), 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_wrong_market_core());
        assert!(!arg0.paused, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_escrow_paused());
        assert!(!arg0.pt_consumed, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_pt_already_consumed_use_drain());
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg0.carved_yield);
        let v1 = 0x2::balance::value<T0>(&v0);
        let v2 = carve_current_yield<T0>(arg0, arg3);
        let v3 = 0x2::balance::value<T0>(&v2);
        let v4 = 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::math_ext::min_u64(v3, arg0.max_yield_extractable_sy - arg0.total_yield_extracted_sy);
        if (v4 < v3) {
            0x2::balance::join<T0>(&mut arg0.backing, 0x2::balance::split<T0>(&mut v2, v3 - v4));
        };
        arg0.total_yield_extracted_sy = arg0.total_yield_extracted_sy + v4;
        let v5 = arg0.total_yield_extracted_sy >= arg0.max_yield_extractable_sy;
        if (v5 && !arg0.hard_cap_breached) {
            arg0.hard_cap_breached = true;
            0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::hard_cap_pause_entry<T0>(arg1, 0x2::object::id<SplitEscrow<T0>>(arg0), arg0.total_yield_extracted_sy, arg0.max_yield_extractable_sy, 0x2::clock::timestamp_ms(arg4));
        };
        0x2::balance::join<T0>(&mut v0, v2);
        let v6 = (v1 as u128) + (v3 as u128);
        let v7 = (v1 as u128) + (v4 as u128);
        assert!(v6 <= 18446744073709551615, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_overflow());
        assert!(v7 <= 18446744073709551615, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_overflow());
        YieldOut<T0>{
            sy             : v0,
            theoretical_sy : (v6 as u64),
            actual_sy      : (v7 as u64),
            hit_hard_cap   : v5,
        }
    }

    public fun remaining_extractable_sy<T0>(arg0: &SplitEscrow<T0>) : u64 {
        arg0.max_yield_extractable_sy - arg0.total_yield_extracted_sy
    }

    public fun scope_escrow() : u8 {
        2
    }

    public fun share<T0>(arg0: SplitEscrow<T0>) {
        0x2::transfer::share_object<SplitEscrow<T0>>(arg0);
    }

    public fun take_partial_pt<T0, T1: drop>(arg0: &mut SplitEscrow<T0>, arg1: &mut 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::MarketCore<T0>, arg2: &T1, arg3: &0x2::clock::Clock, arg4: u128, arg5: u64, arg6: u64) : 0x2::balance::Balance<T0> {
        0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::auth::assert_auth<T1>(&arg0.adapter_auth_type);
        assert!(arg0.market_core_id == 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::id<T0>(arg1), 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_wrong_market_core());
        assert!(!arg0.pt_consumed, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_already_consumed());
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.maturity_ms, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_not_matured());
        assert!(!arg0.paused, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_escrow_paused());
        assert!(arg6 > 0, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_zero_amount());
        assert!(arg5 > 0, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_zero_amount());
        assert!(arg5 == arg0.notional, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_wrong_escrow());
        assert!(arg6 < arg5, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_use_close_pt_side());
        if (!arg0.yt_consumed) {
            move_current_yield_to_carved<T0>(arg0, arg1, arg4, arg3);
        };
        let v0 = 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::math_ext::mul_div_down_u128((arg6 as u128), (0x2::balance::value<T0>(&arg0.backing) as u128), (arg5 as u128));
        assert!(v0 <= 18446744073709551615, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_overflow());
        let v1 = (v0 as u64);
        assert!(v1 > 0, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_use_close_pt_side());
        arg0.notional = arg0.notional - arg6;
        let v2 = 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::math_ext::mul_div_down_u128((arg0.max_yield_extractable_sy as u128), (arg0.notional as u128), (arg5 as u128));
        assert!(v2 <= 18446744073709551615, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_overflow());
        let v3 = (v2 as u64);
        let v4 = if (v3 < arg0.total_yield_extracted_sy) {
            arg0.total_yield_extracted_sy
        } else {
            v3
        };
        arg0.max_yield_extractable_sy = v4;
        if (arg0.total_yield_extracted_sy >= arg0.max_yield_extractable_sy && !arg0.hard_cap_breached) {
            arg0.hard_cap_breached = true;
            0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::hard_cap_pause_entry<T0>(arg1, 0x2::object::id<SplitEscrow<T0>>(arg0), arg0.total_yield_extracted_sy, arg0.max_yield_extractable_sy, 0x2::clock::timestamp_ms(arg3));
        };
        0x2::balance::split<T0>(&mut arg0.backing, v1)
    }

    public fun total_yield_extracted_sy<T0>(arg0: &SplitEscrow<T0>) : u64 {
        arg0.total_yield_extracted_sy
    }

    public fun unpause_with_admin<T0>(arg0: &mut SplitEscrow<T0>, arg1: &0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::caps::MarketAdminCap, arg2: 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::timelock::TimelockReceipt, arg3: &0x2::clock::Clock) {
        0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::timelock::consume_receipt(arg2, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::timelock::action_unpause_escrow(), 0x2::object::id<SplitEscrow<T0>>(arg0), arg3);
        arg0.paused = false;
        0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::events::emit_unpaused(2, 0x2::object::id<SplitEscrow<T0>>(arg0));
    }

    public fun yield_debt<T0>(arg0: &SplitEscrow<T0>) : u128 {
        arg0.yield_debt
    }

    public fun yield_out_actual<T0>(arg0: &YieldOut<T0>) : u64 {
        arg0.actual_sy
    }

    public fun yield_out_amount<T0>(arg0: &YieldOut<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.sy)
    }

    public fun yield_out_hit_hard_cap<T0>(arg0: &YieldOut<T0>) : bool {
        arg0.hit_hard_cap
    }

    public fun yield_out_into_balance<T0>(arg0: YieldOut<T0>) : (0x2::balance::Balance<T0>, u64, u64, bool) {
        let YieldOut {
            sy             : v0,
            theoretical_sy : v1,
            actual_sy      : v2,
            hit_hard_cap   : v3,
        } = arg0;
        (v0, v1, v2, v3)
    }

    public fun yield_out_theoretical<T0>(arg0: &YieldOut<T0>) : u64 {
        arg0.theoretical_sy
    }

    // decompiled from Move bytecode v7
}

