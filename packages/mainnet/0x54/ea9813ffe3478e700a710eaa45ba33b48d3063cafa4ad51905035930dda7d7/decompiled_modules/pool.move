module 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool {
    struct MetadataCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct TimeTrancheKey has copy, drop, store {
        dummy_field: bool,
    }

    struct TvlTrancheKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FactoryReceipt<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<T0>,
        metadata_cap: 0x2::coin_registry::MetadataCap<T0>,
    }

    struct ProjectInfo has copy, drop, store {
        description: 0x1::string::String,
        twitter: 0x1::string::String,
        telegram: 0x1::string::String,
        website: 0x1::string::String,
    }

    struct TimeTranche<phantom T0> has store {
        locked: 0x2::balance::Balance<T0>,
        unlock_ts_ms: u64,
    }

    struct TvlTranche<phantom T0> has store {
        locked: 0x2::balance::Balance<T0>,
        total_locked: u64,
        tvl_target: u64,
        gate_opened_at_ms: u64,
        gate_open: bool,
        withdrawn: u64,
    }

    struct TimeTrancheRequest {
        quote_in: u64,
        unlock_ts_ms: u64,
    }

    struct TvlTrancheRequest {
        quote_in: u64,
        tvl_target: u64,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        creator: address,
        pending_creator: 0x1::option::Option<address>,
        phase: u8,
        virtual_base: u64,
        virtual_quote: u64,
        virtual_base_floor: u64,
        threshold: u64,
        base_reserve: 0x2::balance::Balance<T0>,
        lp_base_reserve: 0x2::balance::Balance<T0>,
        quote_reserve: 0x2::balance::Balance<T1>,
        curve_fee_bps: u64,
        curve_fee_platform_bps: u64,
        referral_bps: u64,
        lp_fee_platform_bps: u64,
        migration_fee_bps: u64,
        tick_spacing: u32,
        min_buy_amount: u64,
        tvl_vesting_duration_ms: u64,
        project: ProjectInfo,
        pool_creation_cap: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap,
        completed_at_ms: u64,
        cetus_pool_id: 0x1::option::Option<0x2::object::ID>,
        base_is_coin_a: 0x1::option::Option<bool>,
        burn_proof: 0x1::option::Option<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>,
    }

    struct PoolCreatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        base: 0x1::type_name::TypeName,
        quote: 0x1::type_name::TypeName,
        creator: address,
        threshold: u64,
        virtual_base: u64,
        virtual_quote: u64,
        curve_fee_bps: u64,
        tick_spacing: u32,
        project: ProjectInfo,
    }

    struct ProjectInfoUpdatedEvent<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        project: ProjectInfo,
    }

    struct TimeTrancheLockedEvent<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        unlock_ts_ms: u64,
        quote_in: u64,
        base_locked: u64,
    }

    struct TvlTrancheLockedEvent<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        tvl_target: u64,
        quote_in: u64,
        base_locked: u64,
    }

    struct TradedEvent<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        trader: address,
        is_buy: bool,
        quote_amount: u64,
        base_amount: u64,
        fee: u64,
        virtual_base: u64,
        virtual_quote: u64,
    }

    struct ReferralPaidEvent<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        referrer: address,
        amount: u64,
    }

    struct CurveCompletedEvent<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        quote_raised: u64,
    }

    struct CurveFeesPaidEvent<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        platform_amount: u64,
        creator_amount: u64,
        referral_amount: u64,
    }

    struct TimeTrancheUnlockedEvent<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        creator: address,
    }

    struct TvlTrancheReleasedEvent<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        creator: address,
    }

    struct CreatorNominatedEvent<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        creator: address,
        nominee: address,
    }

    struct CreatorNominationCancelledEvent<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        creator: address,
        nominee: address,
    }

    struct CreatorTransferredEvent<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    public(friend) fun send_funds<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::balance::send_funds<T0>(0x2::coin::into_balance<T0>(arg0), arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun lp_fee_platform_bps<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.lp_fee_platform_bps
    }

    public fun migration_fee_bps<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.migration_fee_bps
    }

    public fun referral_bps<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.referral_bps
    }

    public fun tick_spacing<T0, T1>(arg0: &Pool<T0, T1>) : u32 {
        arg0.tick_spacing
    }

    public fun tvl_vesting_duration_ms<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.tvl_vesting_duration_ms
    }

    public fun accept_creator<T0, T1>(arg0: &0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::LaunchpadConfig, arg1: &mut Pool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::assert_version(arg0);
        assert!(arg1.pending_creator == 0x1::option::some<address>(0x2::tx_context::sender(arg2)), 26);
        arg1.pending_creator = 0x1::option::none<address>();
        let v0 = CreatorTransferredEvent<T0, T1>{
            pool_id : 0x2::object::uid_to_inner(&arg1.id),
            from    : arg1.creator,
            to      : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<CreatorTransferredEvent<T0, T1>>(v0);
        arg1.creator = 0x2::tx_context::sender(arg2);
    }

    fun accrue_fee<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: 0x1::option::Option<address>, arg3: address) {
        let v0 = 0x2::balance::value<T1>(&arg1);
        let v1 = if (0x1::option::is_some<address>(&arg2)) {
            mul_div_bps(v0, arg0.referral_bps)
        } else {
            0
        };
        let v2 = mul_div_bps(v0, arg0.curve_fee_platform_bps) - v1;
        if (v2 > 0) {
            0x2::balance::send_funds<T1>(0x2::balance::split<T1>(&mut arg1, v2), arg3);
        };
        if (v1 > 0) {
            let v3 = *0x1::option::borrow<address>(&arg2);
            0x2::balance::send_funds<T1>(0x2::balance::split<T1>(&mut arg1, v1), v3);
            let v4 = ReferralPaidEvent<T0, T1>{
                pool_id  : 0x2::object::uid_to_inner(&arg0.id),
                referrer : v3,
                amount   : v1,
            };
            0x2::event::emit<ReferralPaidEvent<T0, T1>>(v4);
        };
        let v5 = 0x2::balance::value<T1>(&arg1);
        if (v5 > 0) {
            0x2::balance::send_funds<T1>(arg1, arg0.creator);
        } else {
            0x2::balance::destroy_zero<T1>(arg1);
        };
        let v6 = CurveFeesPaidEvent<T0, T1>{
            pool_id         : 0x2::object::uid_to_inner(&arg0.id),
            platform_amount : v2,
            creator_amount  : v5,
            referral_amount : v1,
        };
        0x2::event::emit<CurveFeesPaidEvent<T0, T1>>(v6);
    }

    public(friend) fun assert_burn_only_currency<T0>(arg0: &0x2::coin_registry::Currency<T0>) {
        assert!(0x2::coin_registry::is_supply_burn_only<T0>(arg0), 19);
    }

    public(friend) fun assert_migrated<T0, T1>(arg0: &Pool<T0, T1>) {
        assert!(arg0.phase == 2, 20);
    }

    fun assert_not_self_referral(arg0: &0x1::option::Option<address>, arg1: address) {
        assert!(0x1::option::is_none<address>(arg0) || *0x1::option::borrow<address>(arg0) != arg1, 28);
    }

    public fun base_is_coin_a<T0, T1>(arg0: &Pool<T0, T1>) : 0x1::option::Option<bool> {
        arg0.base_is_coin_a
    }

    public(friend) fun borrow_burn_proof_mut<T0, T1>(arg0: &mut Pool<T0, T1>) : &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof {
        0x1::option::borrow_mut<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&mut arg0.burn_proof)
    }

    public(friend) fun borrow_creation_cap<T0, T1>(arg0: &Pool<T0, T1>) : &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap {
        &arg0.pool_creation_cap
    }

    public fun buy<T0, T1>(arg0: &0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::LaunchpadConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: 0x1::option::Option<address>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::assert_version(arg0);
        0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::assert_not_paused(arg0);
        assert!(0x2::coin::value<T1>(&arg2) >= arg1.min_buy_amount, 12);
        assert_not_self_referral(&arg4, 0x2::tx_context::sender(arg6));
        let (v0, v1) = buy_internal<T0, T1>(arg1, 0x2::coin::into_balance<T1>(arg2), 0x2::tx_context::sender(arg6), 18446744073709551615, arg4, 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::treasury(arg0), arg5);
        let v2 = v0;
        assert!(0x2::balance::value<T0>(&v2) >= arg3, 11);
        (0x2::coin::from_balance<T0>(v2, arg6), 0x2::coin::from_balance<T1>(v1, arg6))
    }

    entry fun buy_entry<T0, T1>(arg0: &0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::LaunchpadConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: 0x1::option::Option<address>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = buy<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        send_funds<T0>(v0, 0x2::tx_context::sender(arg6));
        send_funds<T1>(v1, 0x2::tx_context::sender(arg6));
    }

    fun buy_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: address, arg3: u64, arg4: 0x1::option::Option<address>, arg5: address, arg6: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(arg0.phase == 0, 2);
        let v0 = 0x2::balance::value<T1>(&arg1);
        let v1 = 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::curve::fee_amount(v0, arg0.curve_fee_bps);
        let v2 = v0 - v1;
        let v3 = arg0.virtual_base - arg0.virtual_base_floor;
        let v4 = if (v3 < arg3) {
            v3
        } else {
            arg3
        };
        let (v5, v6, v7) = 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::curve::buy_out(arg0.virtual_base, arg0.virtual_quote, v2);
        assert!(v5 > 0, 13);
        let (v8, v9, v10, v11, v12) = if (v5 >= v4) {
            let (v13, v14, v15) = 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::curve::buy_cost_exact_out(arg0.virtual_base, arg0.virtual_quote, v4);
            (v4, v13, 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::curve::fee_amount(v13, arg0.curve_fee_bps), v14, v15)
        } else {
            (v5, v2, v1, v6, v7)
        };
        arg0.virtual_base = v11;
        arg0.virtual_quote = v12;
        0x2::balance::join<T1>(&mut arg0.quote_reserve, 0x2::balance::split<T1>(&mut arg1, v9));
        accrue_fee<T0, T1>(arg0, 0x2::balance::split<T1>(&mut arg1, v10), arg4, arg5);
        let v16 = TradedEvent<T0, T1>{
            pool_id       : 0x2::object::uid_to_inner(&arg0.id),
            trader        : arg2,
            is_buy        : true,
            quote_amount  : v9,
            base_amount   : v8,
            fee           : v10,
            virtual_base  : v11,
            virtual_quote : v12,
        };
        0x2::event::emit<TradedEvent<T0, T1>>(v16);
        if (arg0.virtual_base == arg0.virtual_base_floor) {
            arg0.phase = 1;
            arg0.completed_at_ms = 0x2::clock::timestamp_ms(arg6);
            let v17 = CurveCompletedEvent<T0, T1>{
                pool_id      : 0x2::object::uid_to_inner(&arg0.id),
                quote_raised : 0x2::balance::value<T1>(&arg0.quote_reserve),
            };
            0x2::event::emit<CurveCompletedEvent<T0, T1>>(v17);
        };
        (0x2::balance::split<T0>(&mut arg0.base_reserve, v8), arg1)
    }

    public fun cancel_creator_nomination<T0, T1>(arg0: &0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::LaunchpadConfig, arg1: &mut Pool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::assert_version(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg1.creator, 24);
        assert!(0x1::option::is_some<address>(&arg1.pending_creator), 27);
        let v0 = CreatorNominationCancelledEvent<T0, T1>{
            pool_id : 0x2::object::uid_to_inner(&arg1.id),
            creator : arg1.creator,
            nominee : 0x1::option::extract<address>(&mut arg1.pending_creator),
        };
        0x2::event::emit<CreatorNominationCancelledEvent<T0, T1>>(v0);
    }

    public fun cetus_pool_id<T0, T1>(arg0: &Pool<T0, T1>) : 0x1::option::Option<0x2::object::ID> {
        arg0.cetus_pool_id
    }

    public(friend) fun claim_tvl_tranche<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: bool, arg2: u64) : (0x2::balance::Balance<T0>, address, bool, u64) {
        let v0 = arg0.creator;
        assert!(tvl_tranche_exists<T0, T1>(arg0), 16);
        let v1 = TvlTrancheKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<TvlTrancheKey, TvlTranche<T0>>(&mut arg0.id, v1);
        if (!v2.gate_open && arg1) {
            v2.gate_open = true;
            v2.gate_opened_at_ms = arg2;
        };
        let v3 = if (v2.gate_open) {
            let v4 = 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::curve::vested_amount(v2.total_locked, arg2 - v2.gate_opened_at_ms, arg0.tvl_vesting_duration_ms);
            v2.withdrawn = v4;
            v4 - v2.withdrawn
        } else {
            0
        };
        if (v3 > 0) {
            let v5 = TvlTrancheReleasedEvent<T0, T1>{
                pool_id : 0x2::object::uid_to_inner(&arg0.id),
                amount  : v3,
                creator : v0,
            };
            0x2::event::emit<TvlTrancheReleasedEvent<T0, T1>>(v5);
        };
        (0x2::balance::split<T0>(&mut v2.locked, v3), v0, v2.gate_open, v2.gate_opened_at_ms)
    }

    public fun completed_at_ms<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.completed_at_ms
    }

    public fun create_token<T0, T1>(arg0: &mut 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::LaunchpadConfig, arg1: &mut 0x2::coin_registry::Currency<T0>, arg2: FactoryReceipt<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x1::option::Option<u64>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::option::Option<TimeTrancheRequest>, arg10: 0x1::option::Option<TvlTrancheRequest>, arg11: 0x2::coin::Coin<T1>, arg12: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg13: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::assert_version(arg0);
        0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::assert_not_paused(arg0);
        let v0 = 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::enabled_quote_params(arg0, 0x1::type_name::with_defining_ids<T1>());
        let v1 = 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::resolve_threshold(&v0, arg4);
        assert!(0x2::coin::value<T1>(&arg3) == 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::quote_creation_fee(&v0), 14);
        send_funds<T1>(arg3, 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::treasury(arg0));
        let FactoryReceipt {
            id           : v2,
            treasury     : v3,
            metadata_cap : v4,
        } = arg2;
        let v5 = v3;
        0x2::object::delete(v2);
        assert!(0x2::coin::total_supply<T0>(&v5) == 0, 4);
        assert!(0x2::coin_registry::decimals<T0>(arg1) == 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::base_decimals(arg0), 5);
        assert!(!0x2::coin_registry::is_regulated<T0>(arg1), 23);
        let v6 = 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::initial_virtual_base(arg0);
        let v7 = 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::remain_base(arg0);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::mint_pool_creation_cap<T0>(arg12, arg13, &mut v5, arg15);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::register_permission_pair<T0, T1>(arg12, arg13, 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::tick_spacing(arg0), &v8, arg15);
        0x2::coin_registry::make_supply_burn_only<T0>(arg1, v5);
        let (v9, v10, v11) = 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::curve::derive_virtual_reserves(v6, v7, v1);
        let v12 = Pool<T0, T1>{
            id                      : 0x2::object::new(arg15),
            creator                 : 0x2::tx_context::sender(arg15),
            pending_creator         : 0x1::option::none<address>(),
            phase                   : 0,
            virtual_base            : v9,
            virtual_quote           : v10,
            virtual_base_floor      : v11,
            threshold               : v1,
            base_reserve            : 0x2::coin::mint_balance<T0>(&mut v5, v6),
            lp_base_reserve         : 0x2::coin::mint_balance<T0>(&mut v5, v7),
            quote_reserve           : 0x2::balance::zero<T1>(),
            curve_fee_bps           : 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::curve_fee_bps(arg0),
            curve_fee_platform_bps  : 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::curve_fee_platform_bps(arg0),
            referral_bps            : 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::referral_bps(arg0),
            lp_fee_platform_bps     : 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::lp_fee_platform_bps(arg0),
            migration_fee_bps       : 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::migration_fee_bps(arg0),
            tick_spacing            : 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::tick_spacing(arg0),
            min_buy_amount          : 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::quote_min_buy_amount(&v0),
            tvl_vesting_duration_ms : 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::tvl_vesting_duration_ms(arg0),
            project                 : new_project_info(arg5, arg6, arg7, arg8),
            pool_creation_cap       : v8,
            completed_at_ms         : 0,
            cetus_pool_id           : 0x1::option::none<0x2::object::ID>(),
            base_is_coin_a          : 0x1::option::none<bool>(),
            burn_proof              : 0x1::option::none<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(),
        };
        let v13 = 0x2::object::uid_to_inner(&v12.id);
        let v14 = MetadataCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<MetadataCapKey, 0x2::coin_registry::MetadataCap<T0>>(&mut v12.id, v14, v4);
        let v15 = PoolCreatedEvent{
            pool_id       : v13,
            base          : 0x1::type_name::with_defining_ids<T0>(),
            quote         : 0x1::type_name::with_defining_ids<T1>(),
            creator       : v12.creator,
            threshold     : v1,
            virtual_base  : v9,
            virtual_quote : v10,
            curve_fee_bps : v12.curve_fee_bps,
            tick_spacing  : v12.tick_spacing,
            project       : v12.project,
        };
        0x2::event::emit<PoolCreatedEvent>(v15);
        let v16 = ((v6 + v7) as u128);
        if (0x1::option::is_some<TimeTrancheRequest>(&arg9)) {
            let TimeTrancheRequest {
                quote_in     : v17,
                unlock_ts_ms : v18,
            } = 0x1::option::destroy_some<TimeTrancheRequest>(arg9);
            let v19 = &mut v12;
            let v20 = &mut arg11;
            lock_time_tranche<T0, T1>(v19, v17, v18, v20, 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::min_lock_duration_ms(arg0), ((v16 * (0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::first_buy_time_cap_bps(arg0) as u128) / 10000) as u64), 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::treasury(arg0), arg14);
        } else {
            0x1::option::destroy_none<TimeTrancheRequest>(arg9);
        };
        if (0x1::option::is_some<TvlTrancheRequest>(&arg10)) {
            let TvlTrancheRequest {
                quote_in   : v21,
                tvl_target : v22,
            } = 0x1::option::destroy_some<TvlTrancheRequest>(arg10);
            let v23 = &mut v12;
            let v24 = &mut arg11;
            lock_tvl_tranche<T0, T1>(v23, v21, v22, v24, 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::quote_min_tvl_target(&v0), (0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::tvl_target_multiplier(arg0) as u128) * ((v6 + v7) as u128) * (v1 as u128) / (v7 as u128), ((v16 * (0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::first_buy_tvl_cap_bps(arg0) as u128) / 10000) as u64), 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::treasury(arg0), arg14);
        } else {
            0x1::option::destroy_none<TvlTrancheRequest>(arg10);
        };
        0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::register_pool(arg0, 0x1::type_name::with_defining_ids<T0>(), v13);
        0x2::transfer::share_object<Pool<T0, T1>>(v12);
        arg11
    }

    entry fun create_token_entry<T0, T1>(arg0: &mut 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::LaunchpadConfig, arg1: &mut 0x2::coin_registry::Currency<T0>, arg2: FactoryReceipt<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x1::option::Option<u64>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::option::Option<u64>, arg10: 0x1::option::Option<u64>, arg11: 0x1::option::Option<u64>, arg12: 0x1::option::Option<u64>, arg13: 0x2::coin::Coin<T1>, arg14: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg15: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new_tranche_requests(arg9, arg10, arg11, arg12);
        let v2 = create_token<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, v0, v1, arg13, arg14, arg15, arg16, arg17);
        send_funds<T1>(v2, 0x2::tx_context::sender(arg17));
    }

    public fun creator<T0, T1>(arg0: &Pool<T0, T1>) : address {
        arg0.creator
    }

    fun lock_time_tranche<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: address, arg7: &0x2::clock::Clock) {
        assert!(!time_tranche_exists<T0, T1>(arg0), 8);
        assert!(arg2 >= 0x2::clock::timestamp_ms(arg7) + arg4, 10);
        let (v0, v1) = tranche_buy<T0, T1>(arg0, arg1, arg3, arg5, arg6, arg7);
        let v2 = v0;
        let v3 = TimeTrancheKey{dummy_field: false};
        let v4 = TimeTranche<T0>{
            locked       : v2,
            unlock_ts_ms : arg2,
        };
        0x2::dynamic_field::add<TimeTrancheKey, TimeTranche<T0>>(&mut arg0.id, v3, v4);
        let v5 = TimeTrancheLockedEvent<T0, T1>{
            pool_id      : 0x2::object::uid_to_inner(&arg0.id),
            unlock_ts_ms : arg2,
            quote_in     : v1,
            base_locked  : 0x2::balance::value<T0>(&v2),
        };
        0x2::event::emit<TimeTrancheLockedEvent<T0, T1>>(v5);
    }

    fun lock_tvl_tranche<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: u128, arg6: u64, arg7: address, arg8: &0x2::clock::Clock) {
        assert!(!tvl_tranche_exists<T0, T1>(arg0), 8);
        assert!(arg2 >= arg4 && arg2 > 0, 10);
        assert!((arg2 as u128) >= arg5, 10);
        let (v0, v1) = tranche_buy<T0, T1>(arg0, arg1, arg3, arg6, arg7, arg8);
        let v2 = v0;
        let v3 = 0x2::balance::value<T0>(&v2);
        let v4 = TvlTrancheKey{dummy_field: false};
        let v5 = TvlTranche<T0>{
            locked            : v2,
            total_locked      : v3,
            tvl_target        : arg2,
            gate_opened_at_ms : 0,
            gate_open         : false,
            withdrawn         : 0,
        };
        0x2::dynamic_field::add<TvlTrancheKey, TvlTranche<T0>>(&mut arg0.id, v4, v5);
        let v6 = TvlTrancheLockedEvent<T0, T1>{
            pool_id     : 0x2::object::uid_to_inner(&arg0.id),
            tvl_target  : arg2,
            quote_in    : v1,
            base_locked : v3,
        };
        0x2::event::emit<TvlTrancheLockedEvent<T0, T1>>(v6);
    }

    fun mul_div_bps(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::bps_denominator() as u128)) as u64)
    }

    fun new_project_info(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) : ProjectInfo {
        assert!(0x1::string::length(&arg0) <= 1000, 25);
        assert!(0x1::string::length(&arg1) <= 500, 25);
        assert!(0x1::string::length(&arg2) <= 500, 25);
        assert!(0x1::string::length(&arg3) <= 500, 25);
        ProjectInfo{
            description : arg0,
            twitter     : arg1,
            telegram    : arg2,
            website     : arg3,
        }
    }

    public fun new_time_tranche_request(arg0: u64, arg1: u64) : TimeTrancheRequest {
        TimeTrancheRequest{
            quote_in     : arg0,
            unlock_ts_ms : arg1,
        }
    }

    public(friend) fun new_tranche_requests(arg0: 0x1::option::Option<u64>, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>) : (0x1::option::Option<TimeTrancheRequest>, 0x1::option::Option<TvlTrancheRequest>) {
        assert!(0x1::option::is_some<u64>(&arg0) == 0x1::option::is_some<u64>(&arg1), 29);
        assert!(0x1::option::is_some<u64>(&arg2) == 0x1::option::is_some<u64>(&arg3), 29);
        let v0 = if (0x1::option::is_some<u64>(&arg0)) {
            0x1::option::some<TimeTrancheRequest>(new_time_tranche_request(0x1::option::destroy_some<u64>(arg0), 0x1::option::destroy_some<u64>(arg1)))
        } else {
            0x1::option::destroy_none<u64>(arg0);
            0x1::option::destroy_none<u64>(arg1);
            0x1::option::none<TimeTrancheRequest>()
        };
        let v1 = if (0x1::option::is_some<u64>(&arg2)) {
            0x1::option::some<TvlTrancheRequest>(new_tvl_tranche_request(0x1::option::destroy_some<u64>(arg2), 0x1::option::destroy_some<u64>(arg3)))
        } else {
            0x1::option::destroy_none<u64>(arg2);
            0x1::option::destroy_none<u64>(arg3);
            0x1::option::none<TvlTrancheRequest>()
        };
        (v0, v1)
    }

    public fun new_tvl_tranche_request(arg0: u64, arg1: u64) : TvlTrancheRequest {
        TvlTrancheRequest{
            quote_in   : arg0,
            tvl_target : arg1,
        }
    }

    public fun nominate_creator<T0, T1>(arg0: &0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::LaunchpadConfig, arg1: &mut Pool<T0, T1>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::assert_version(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg1.creator, 24);
        arg1.pending_creator = 0x1::option::some<address>(arg2);
        let v0 = CreatorNominatedEvent<T0, T1>{
            pool_id : 0x2::object::uid_to_inner(&arg1.id),
            creator : arg1.creator,
            nominee : arg2,
        };
        0x2::event::emit<CreatorNominatedEvent<T0, T1>>(v0);
    }

    public fun pending_creator<T0, T1>(arg0: &Pool<T0, T1>) : 0x1::option::Option<address> {
        arg0.pending_creator
    }

    public fun phase<T0, T1>(arg0: &Pool<T0, T1>) : u8 {
        arg0.phase
    }

    public fun phase_completed() : u8 {
        1
    }

    public fun phase_migrated() : u8 {
        2
    }

    public fun phase_trading() : u8 {
        0
    }

    public fun project_info<T0, T1>(arg0: &Pool<T0, T1>) : (0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String) {
        (arg0.project.description, arg0.project.twitter, arg0.project.telegram, arg0.project.website)
    }

    public fun quote_buy<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : (u64, u64) {
        if (arg0.phase != 0) {
            return (0, 0)
        };
        let v0 = 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::curve::fee_amount(arg1, arg0.curve_fee_bps);
        let v1 = arg0.virtual_base - arg0.virtual_base_floor;
        let v2 = 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::curve::buy_out_preview(arg0.virtual_base, arg0.virtual_quote, arg1 - v0);
        if (v2 >= v1) {
            let (v5, _, _) = 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::curve::buy_cost_exact_out(arg0.virtual_base, arg0.virtual_quote, v1);
            (v1, 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::curve::fee_amount(v5, arg0.curve_fee_bps))
        } else {
            (v2, v0)
        }
    }

    public fun quote_sell<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : (u64, u64) {
        if (arg0.phase != 0) {
            return (0, 0)
        };
        let (v0, _, _) = 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::curve::sell_out(arg0.virtual_base, arg0.virtual_quote, arg1);
        let v3 = 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::curve::fee_amount(v0, arg0.curve_fee_bps);
        (v0 - v3, v3)
    }

    public fun real_reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.base_reserve), 0x2::balance::value<T0>(&arg0.lp_base_reserve), 0x2::balance::value<T1>(&arg0.quote_reserve))
    }

    public fun seal<T0: drop>(arg0: T0, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : FactoryReceipt<T0> {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<T0>(arg0, 9, arg1, arg2, arg3, arg4, arg5);
        FactoryReceipt<T0>{
            id           : 0x2::object::new(arg5),
            treasury     : v1,
            metadata_cap : 0x2::coin_registry::finalize<T0>(v0, arg5),
        }
    }

    public fun sell<T0, T1>(arg0: &0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::LaunchpadConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: 0x1::option::Option<address>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::assert_version(arg0);
        assert!(arg1.phase == 0, 2);
        assert_not_self_referral(&arg4, 0x2::tx_context::sender(arg5));
        let v0 = 0x2::coin::value<T0>(&arg2);
        let (v1, v2, v3) = 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::curve::sell_out(arg1.virtual_base, arg1.virtual_quote, v0);
        let v4 = 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::curve::fee_amount(v1, arg1.curve_fee_bps);
        let v5 = v1 - v4;
        assert!(v5 > 0, 13);
        assert!(v5 >= arg3, 11);
        arg1.virtual_base = v2;
        arg1.virtual_quote = v3;
        0x2::balance::join<T0>(&mut arg1.base_reserve, 0x2::coin::into_balance<T0>(arg2));
        let v6 = 0x2::balance::split<T1>(&mut arg1.quote_reserve, v1);
        accrue_fee<T0, T1>(arg1, 0x2::balance::split<T1>(&mut v6, v4), arg4, 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::treasury(arg0));
        let v7 = TradedEvent<T0, T1>{
            pool_id       : 0x2::object::uid_to_inner(&arg1.id),
            trader        : 0x2::tx_context::sender(arg5),
            is_buy        : false,
            quote_amount  : v1,
            base_amount   : v0,
            fee           : v4,
            virtual_base  : v2,
            virtual_quote : v3,
        };
        0x2::event::emit<TradedEvent<T0, T1>>(v7);
        0x2::coin::from_balance<T1>(v6, arg5)
    }

    entry fun sell_entry<T0, T1>(arg0: &0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::LaunchpadConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: 0x1::option::Option<address>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = sell<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        send_funds<T1>(v0, 0x2::tx_context::sender(arg5));
    }

    public(friend) fun send_platform_quote<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::balance::send_funds<T0>(arg0, arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public(friend) fun set_migrated<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::object::ID, arg2: bool) {
        arg0.phase = 2;
        0x1::option::fill<0x2::object::ID>(&mut arg0.cetus_pool_id, arg1);
        0x1::option::fill<bool>(&mut arg0.base_is_coin_a, arg2);
    }

    public(friend) fun store_burn_proof<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof) {
        0x1::option::fill<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&mut arg0.burn_proof, arg1);
    }

    public fun threshold<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.threshold
    }

    public fun time_tranche_exists<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        let v0 = TimeTrancheKey{dummy_field: false};
        0x2::dynamic_field::exists_with_type<TimeTrancheKey, TimeTranche<T0>>(&arg0.id, v0)
    }

    public fun time_tranche_info<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, bool) {
        assert!(time_tranche_exists<T0, T1>(arg0), 16);
        let v0 = TimeTrancheKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<TimeTrancheKey, TimeTranche<T0>>(&arg0.id, v0);
        (v1.unlock_ts_ms, 0x2::balance::value<T0>(&v1.locked), 0x2::balance::value<T0>(&v1.locked) == 0)
    }

    fun tranche_buy<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::coin::Coin<T1>, arg3: u64, arg4: address, arg5: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, u64) {
        assert!(arg1 >= arg0.min_buy_amount, 12);
        assert!(0x2::coin::value<T1>(arg2) >= arg1, 15);
        let v0 = arg0.creator;
        let (v1, v2) = buy_internal<T0, T1>(arg0, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg2), arg1), v0, arg3, 0x1::option::none<address>(), arg4, arg5);
        let v3 = v2;
        let v4 = v1;
        0x2::balance::join<T1>(0x2::coin::balance_mut<T1>(arg2), v3);
        assert!(0x2::balance::value<T0>(&v4) > 0, 13);
        (v4, arg1 - 0x2::balance::value<T1>(&v3))
    }

    public fun tvl_tranche_exists<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        let v0 = TvlTrancheKey{dummy_field: false};
        0x2::dynamic_field::exists_with_type<TvlTrancheKey, TvlTranche<T0>>(&arg0.id, v0)
    }

    public fun tvl_tranche_info<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, bool) {
        assert!(tvl_tranche_exists<T0, T1>(arg0), 16);
        let v0 = TvlTrancheKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<TvlTrancheKey, TvlTranche<T0>>(&arg0.id, v0);
        (v1.tvl_target, 0x2::balance::value<T0>(&v1.locked), v1.withdrawn == v1.total_locked)
    }

    public(friend) fun tvl_tranche_target<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        assert!(tvl_tranche_exists<T0, T1>(arg0), 16);
        let v0 = TvlTrancheKey{dummy_field: false};
        0x2::dynamic_field::borrow<TvlTrancheKey, TvlTranche<T0>>(&arg0.id, v0).tvl_target
    }

    public fun tvl_tranche_vesting<T0, T1>(arg0: &Pool<T0, T1>) : (u64, bool, u64, u64, u64) {
        assert!(tvl_tranche_exists<T0, T1>(arg0), 16);
        let v0 = TvlTrancheKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<TvlTrancheKey, TvlTranche<T0>>(&arg0.id, v0);
        (v1.total_locked, v1.gate_open, v1.gate_opened_at_ms, arg0.tvl_vesting_duration_ms, v1.withdrawn)
    }

    public fun unlock_tranche_time<T0, T1>(arg0: &0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::LaunchpadConfig, arg1: &mut Pool<T0, T1>, arg2: &0x2::clock::Clock) {
        0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::assert_version(arg0);
        let v0 = arg1.creator;
        assert!(time_tranche_exists<T0, T1>(arg1), 16);
        let v1 = TimeTrancheKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<TimeTrancheKey, TimeTranche<T0>>(&mut arg1.id, v1);
        assert!(0x2::clock::timestamp_ms(arg2) >= v2.unlock_ts_ms, 18);
        assert!(0x2::balance::value<T0>(&v2.locked) > 0, 17);
        let v3 = 0x2::balance::withdraw_all<T0>(&mut v2.locked);
        let v4 = TimeTrancheUnlockedEvent<T0, T1>{
            pool_id : 0x2::object::uid_to_inner(&arg1.id),
            amount  : 0x2::balance::value<T0>(&v3),
            creator : v0,
        };
        0x2::event::emit<TimeTrancheUnlockedEvent<T0, T1>>(v4);
        0x2::balance::send_funds<T0>(v3, v0);
    }

    public fun update_base_metadata<T0, T1>(arg0: &0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::LaunchpadConfig, arg1: &Pool<T0, T1>, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<0x1::string::String>, arg6: &0x2::tx_context::TxContext) {
        0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::assert_version(arg0);
        assert!(0x2::tx_context::sender(arg6) == arg1.creator, 24);
        let v0 = MetadataCapKey{dummy_field: false};
        let v1 = 0x2::dynamic_object_field::borrow<MetadataCapKey, 0x2::coin_registry::MetadataCap<T0>>(&arg1.id, v0);
        if (0x1::option::is_some<0x1::string::String>(&arg3)) {
            0x2::coin_registry::set_name<T0>(arg2, v1, 0x1::option::extract<0x1::string::String>(&mut arg3));
        };
        if (0x1::option::is_some<0x1::string::String>(&arg4)) {
            0x2::coin_registry::set_description<T0>(arg2, v1, 0x1::option::extract<0x1::string::String>(&mut arg4));
        };
        if (0x1::option::is_some<0x1::string::String>(&arg5)) {
            0x2::coin_registry::set_icon_url<T0>(arg2, v1, 0x1::option::extract<0x1::string::String>(&mut arg5));
        };
        0x1::option::destroy_none<0x1::string::String>(arg3);
        0x1::option::destroy_none<0x1::string::String>(arg4);
        0x1::option::destroy_none<0x1::string::String>(arg5);
    }

    public fun update_project_info<T0, T1>(arg0: &0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::LaunchpadConfig, arg1: &mut Pool<T0, T1>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::tx_context::TxContext) {
        0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::assert_version(arg0);
        assert!(0x2::tx_context::sender(arg6) == arg1.creator, 24);
        arg1.project = new_project_info(arg2, arg3, arg4, arg5);
        let v0 = ProjectInfoUpdatedEvent<T0, T1>{
            pool_id : 0x2::object::uid_to_inner(&arg1.id),
            project : arg1.project,
        };
        0x2::event::emit<ProjectInfoUpdatedEvent<T0, T1>>(v0);
    }

    public fun virtual_reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        (arg0.virtual_base, arg0.virtual_quote, arg0.virtual_base_floor)
    }

    public(friend) fun withdraw_for_migration<T0, T1>(arg0: &mut Pool<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(arg0.phase == 1, 3);
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg0.lp_base_reserve);
        0x2::balance::join<T0>(&mut v0, 0x2::balance::withdraw_all<T0>(&mut arg0.base_reserve));
        (v0, 0x2::balance::withdraw_all<T1>(&mut arg0.quote_reserve))
    }

    // decompiled from Move bytecode v7
}

