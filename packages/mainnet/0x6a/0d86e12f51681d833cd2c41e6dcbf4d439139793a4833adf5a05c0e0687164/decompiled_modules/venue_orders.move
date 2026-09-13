module 0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders {
    struct VenueRegistry has key {
        id: 0x2::object::UID,
        approved: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct VenueOrder<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        venue: 0x1::type_name::TypeName,
        venue_id: 0x2::object::ID,
        curve_id: 0x2::object::ID,
        is_buy: bool,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        tokens: 0x2::balance::Balance<T0>,
        trigger_price: u128,
        above: bool,
        min_out: u64,
        referrer: 0x1::option::Option<address>,
        expires_at_ms: u64,
        created_at_ms: u64,
        decimals: u8,
    }

    struct FillTicket<phantom T0> {
        order_id: 0x2::object::ID,
        venue: 0x1::type_name::TypeName,
        venue_id: 0x2::object::ID,
        curve_id: 0x2::object::ID,
        owner: address,
        cranker: address,
        is_buy: bool,
        min_out: u64,
        referrer: 0x1::option::Option<address>,
        price_scaled: u128,
        at_ms: u64,
    }

    struct VenueApproved has copy, drop {
        venue: 0x1::type_name::TypeName,
        approved: bool,
    }

    struct VenueOrderPlaced has copy, drop {
        order_id: 0x2::object::ID,
        venue: 0x1::type_name::TypeName,
        venue_id: 0x2::object::ID,
        curve_id: 0x2::object::ID,
        owner: address,
        is_buy: bool,
        escrowed: u64,
        trigger_price: u128,
        above: bool,
        min_out: u64,
        expires_at_ms: u64,
        decimals: u8,
        at_ms: u64,
    }

    struct VenueOrderFilled has copy, drop {
        order_id: 0x2::object::ID,
        venue: 0x1::type_name::TypeName,
        venue_id: 0x2::object::ID,
        curve_id: 0x2::object::ID,
        owner: address,
        cranker: address,
        is_buy: bool,
        received: u64,
        price_scaled: u128,
        at_ms: u64,
    }

    struct VenueOrderClosed has copy, drop {
        order_id: 0x2::object::ID,
        venue_id: 0x2::object::ID,
        owner: address,
        expired: bool,
        at_ms: u64,
    }

    public fun above<T0>(arg0: &VenueOrder<T0>) : bool {
        arg0.above
    }

    public fun approve_venue<T0: drop>(arg0: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::AdminCap, arg1: &mut VenueRegistry) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.approved, &v0), 10);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.approved, v0);
        let v1 = VenueApproved{
            venue    : v0,
            approved : true,
        };
        0x2::event::emit<VenueApproved>(v1);
    }

    public fun approved_count(arg0: &VenueRegistry) : u64 {
        0x2::vec_set::length<0x1::type_name::TypeName>(&arg0.approved)
    }

    public fun begin_fill<T0, T1: drop>(arg0: VenueOrder<T0>, arg1: &VenueRegistry, arg2: T1, arg3: 0x2::object::ID, arg4: u128, arg5: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::Config, arg6: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::fees::FeeVault, arg7: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::referral::ReferralRegistry, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<T0>, FillTicket<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.approved, &v0), 7);
        assert!(arg0.venue == v0, 0);
        assert!(arg0.venue_id == arg3, 0);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        assert!(arg0.expires_at_ms == 0 || v1 < arg0.expires_at_ms, 4);
        assert!(is_ready_at<T0>(&arg0, arg4), 2);
        let VenueOrder {
            id            : v2,
            owner         : v3,
            venue         : _,
            venue_id      : v5,
            curve_id      : v6,
            is_buy        : v7,
            sui           : v8,
            tokens        : v9,
            trigger_price : _,
            above         : _,
            min_out       : v12,
            referrer      : v13,
            expires_at_ms : _,
            created_at_ms : _,
            decimals      : _,
        } = arg0;
        let v17 = v8;
        let v18 = v2;
        0x2::object::delete(v18);
        let v19 = if (0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::referral::has_referrer(arg7, v3)) {
            0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::referral::referrer_of(arg7, v3)
        } else {
            v13
        };
        if (v7) {
            let v20 = &mut v17;
            take_fee(arg5, arg6, v6, v20, v19);
        };
        let v21 = FillTicket<T0>{
            order_id     : 0x2::object::uid_to_inner(&v18),
            venue        : v0,
            venue_id     : v5,
            curve_id     : v6,
            owner        : v3,
            cranker      : 0x2::tx_context::sender(arg9),
            is_buy       : v7,
            min_out      : v12,
            referrer     : v19,
            price_scaled : arg4,
            at_ms        : v1,
        };
        (v17, v9, v21)
    }

    public fun cancel<T0>(arg0: VenueOrder<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        refund<T0>(arg0, false, arg1, arg2);
    }

    public fun curve_id<T0>(arg0: &VenueOrder<T0>) : 0x2::object::ID {
        arg0.curve_id
    }

    public fun decimals<T0>(arg0: &VenueOrder<T0>) : u8 {
        arg0.decimals
    }

    public fun escrowed<T0>(arg0: &VenueOrder<T0>) : u64 {
        if (arg0.is_buy) {
            0x2::balance::value<0x2::sui::SUI>(&arg0.sui)
        } else {
            0x2::balance::value<T0>(&arg0.tokens)
        }
    }

    public fun expires_at_ms<T0>(arg0: &VenueOrder<T0>) : u64 {
        arg0.expires_at_ms
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VenueRegistry{
            id       : 0x2::object::new(arg0),
            approved : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0x2::transfer::share_object<VenueRegistry>(v0);
    }

    public fun is_approved<T0: drop>(arg0: &VenueRegistry) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.approved, &v0)
    }

    public fun is_buy<T0>(arg0: &VenueOrder<T0>) : bool {
        arg0.is_buy
    }

    public fun is_ready<T0>(arg0: &VenueOrder<T0>, arg1: u128) : bool {
        is_ready_at<T0>(arg0, arg1)
    }

    fun is_ready_at<T0>(arg0: &VenueOrder<T0>, arg1: u128) : bool {
        arg0.above && arg1 >= arg0.trigger_price || arg1 <= arg0.trigger_price
    }

    public fun min_out<T0>(arg0: &VenueOrder<T0>) : u64 {
        arg0.min_out
    }

    fun new_order<T0, T1: drop>(arg0: &VenueRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: bool, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: 0x2::balance::Balance<T0>, arg6: u128, arg7: bool, arg8: u64, arg9: 0x1::option::Option<address>, arg10: u64, arg11: u8, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : VenueOrder<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.approved, &v0), 7);
        let v1 = if (arg3) {
            0x2::balance::value<0x2::sui::SUI>(&arg4)
        } else {
            0x2::balance::value<T0>(&arg5)
        };
        assert!(v1 > 0, 3);
        assert!(arg6 > 0, 5);
        let v2 = 0x2::clock::timestamp_ms(arg12);
        assert!(arg10 == 0 || arg10 > v2, 4);
        let v3 = 0x2::object::new(arg13);
        let v4 = VenueOrderPlaced{
            order_id      : 0x2::object::uid_to_inner(&v3),
            venue         : v0,
            venue_id      : arg1,
            curve_id      : arg2,
            owner         : 0x2::tx_context::sender(arg13),
            is_buy        : arg3,
            escrowed      : v1,
            trigger_price : arg6,
            above         : arg7,
            min_out       : arg8,
            expires_at_ms : arg10,
            decimals      : arg11,
            at_ms         : v2,
        };
        0x2::event::emit<VenueOrderPlaced>(v4);
        VenueOrder<T0>{
            id            : v3,
            owner         : 0x2::tx_context::sender(arg13),
            venue         : v0,
            venue_id      : arg1,
            curve_id      : arg2,
            is_buy        : arg3,
            sui           : arg4,
            tokens        : arg5,
            trigger_price : arg6,
            above         : arg7,
            min_out       : arg8,
            referrer      : arg9,
            expires_at_ms : arg10,
            created_at_ms : v2,
            decimals      : arg11,
        }
    }

    public fun owner<T0>(arg0: &VenueOrder<T0>) : address {
        arg0.owner
    }

    fun pay<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun place_buy<T0, T1: drop>(arg0: T1, arg1: &VenueRegistry, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &0x2::coin::CoinMetadata<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u128, arg7: bool, arg8: u64, arg9: 0x1::option::Option<address>, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<VenueOrder<T0>>(new_order<T0, T1>(arg1, arg2, arg3, true, 0x2::coin::into_balance<0x2::sui::SUI>(arg5), 0x2::balance::zero<T0>(), arg6, arg7, arg8, arg9, arg10, 0x2::coin::get_decimals<T0>(arg4), arg11, arg12));
    }

    public fun place_sell<T0, T1: drop>(arg0: T1, arg1: &VenueRegistry, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &0x2::coin::CoinMetadata<T0>, arg5: 0x2::coin::Coin<T0>, arg6: u128, arg7: bool, arg8: u64, arg9: 0x1::option::Option<address>, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<VenueOrder<T0>>(new_order<T0, T1>(arg1, arg2, arg3, false, 0x2::balance::zero<0x2::sui::SUI>(), 0x2::coin::into_balance<T0>(arg5), arg6, arg7, arg8, arg9, arg10, 0x2::coin::get_decimals<T0>(arg4), arg11, arg12));
    }

    public fun reclaim_expired<T0>(arg0: VenueOrder<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.expires_at_ms != 0 && 0x2::clock::timestamp_ms(arg1) >= arg0.expires_at_ms, 6);
        refund<T0>(arg0, true, arg1, arg2);
    }

    fun refund<T0>(arg0: VenueOrder<T0>, arg1: bool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let VenueOrder {
            id            : v0,
            owner         : v1,
            venue         : _,
            venue_id      : v3,
            curve_id      : _,
            is_buy        : _,
            sui           : v6,
            tokens        : v7,
            trigger_price : _,
            above         : _,
            min_out       : _,
            referrer      : _,
            expires_at_ms : _,
            created_at_ms : _,
            decimals      : _,
        } = arg0;
        let v15 = v0;
        0x2::object::delete(v15);
        pay<0x2::sui::SUI>(v6, v1, arg3);
        pay<T0>(v7, v1, arg3);
        let v16 = VenueOrderClosed{
            order_id : 0x2::object::uid_to_inner(&v15),
            venue_id : v3,
            owner    : v1,
            expired  : arg1,
            at_ms    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<VenueOrderClosed>(v16);
    }

    public fun revoke_venue<T0: drop>(arg0: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::AdminCap, arg1: &mut VenueRegistry) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.approved, &v0), 10);
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg1.approved, &v0);
        let v1 = VenueApproved{
            venue    : v0,
            approved : false,
        };
        0x2::event::emit<VenueApproved>(v1);
    }

    public fun settle_fill<T0>(arg0: FillTicket<T0>, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::Config, arg4: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::fees::FeeVault, arg5: &mut 0x2::tx_context::TxContext) {
        let FillTicket {
            order_id     : v0,
            venue        : v1,
            venue_id     : v2,
            curve_id     : v3,
            owner        : v4,
            cranker      : v5,
            is_buy       : v6,
            min_out      : v7,
            referrer     : v8,
            price_scaled : v9,
            at_ms        : v10,
        } = arg0;
        let v11 = if (v6) {
            let v12 = 0x2::balance::value<T0>(&arg2);
            assert!(v12 > 0, 9);
            v12
        } else {
            let v13 = &mut arg1;
            take_fee(arg3, arg4, v3, v13, v8);
            let v14 = 0x2::balance::value<0x2::sui::SUI>(&arg1);
            assert!(v14 > 0, 9);
            v14
        };
        assert!(v11 >= v7, 8);
        pay<0x2::sui::SUI>(arg1, v4, arg5);
        pay<T0>(arg2, v4, arg5);
        let v15 = VenueOrderFilled{
            order_id     : v0,
            venue        : v1,
            venue_id     : v2,
            curve_id     : v3,
            owner        : v4,
            cranker      : v5,
            is_buy       : v6,
            received     : v11,
            price_scaled : v9,
            at_ms        : v10,
        };
        0x2::event::emit<VenueOrderFilled>(v15);
    }

    fun take_fee(arg0: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::Config, arg1: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::fees::FeeVault, arg2: 0x2::object::ID, arg3: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg4: 0x1::option::Option<address>) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(arg3);
        assert!(v0 > 0, 3);
        let v1 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::math::mul_bps(v0, 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::fee_bps(arg0));
        if (v1 == 0) {
            return
        };
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::fees::deposit_external(arg1, arg2, 0x2::balance::split<0x2::sui::SUI>(arg3, v1), arg4);
    }

    public fun trigger_price<T0>(arg0: &VenueOrder<T0>) : u128 {
        arg0.trigger_price
    }

    public fun venue<T0>(arg0: &VenueOrder<T0>) : 0x1::type_name::TypeName {
        arg0.venue
    }

    public fun venue_id<T0>(arg0: &VenueOrder<T0>) : 0x2::object::ID {
        arg0.venue_id
    }

    public fun venue_price(arg0: u64, arg1: u64, arg2: u8) : u128 {
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::math::spot_price_scaled(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

