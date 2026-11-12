module 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::curve_bundle {
    struct CurveBundle<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        window_end_ms: u64,
        min_sui: u64,
        cap_sui: u64,
        committed: 0x2::balance::Balance<0x2::sui::SUI>,
        total: u64,
        commits: u64,
        claimed: u64,
        dev_payment: 0x2::balance::Balance<0x2::sui::SUI>,
        options: CurveOptions,
        token_cap: 0x1::option::Option<0x2::coin::TreasuryCap<T0>>,
        token_metadata_cap: 0x1::option::Option<0x2::coin_registry::MetadataCap<T0>>,
        share_cap: 0x1::option::Option<0x2::coin::TreasuryCap<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::bundle::Share<T0>>>,
        state: u8,
        spent: u64,
        shares: 0x2::balance::Balance<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::bundle::Share<T0>>,
        excess_paid: u64,
        open_at_ms: u64,
        curve_id: 0x1::option::Option<0x2::object::ID>,
        tokens: 0x2::balance::Balance<T0>,
        burned: u64,
        vault_id: 0x1::option::Option<0x2::object::ID>,
        terms: VaultTerms,
        pool_cap: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>,
        dev_tokens: 0x2::balance::Balance<T0>,
    }

    struct CurveOptions has store {
        dev_buy_sui: u64,
        dev_lock_days: u64,
        open_delay_ms: u64,
        creator_tax_bps: u64,
        website: 0x1::string::String,
        x: 0x1::string::String,
        telegram: 0x1::string::String,
        fee_mode: u8,
    }

    struct VaultTerms has store {
        launch_fee_bps: u64,
        platform_bps: u64,
        sunset_bps: u64,
        limits: 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::Limits,
    }

    struct CurveCommit<phantom T0> has store, key {
        id: 0x2::object::UID,
        bundle_id: 0x2::object::ID,
        amount: u64,
    }

    struct CurveBundleCreated has copy, drop {
        bundle_id: 0x2::object::ID,
        creator: address,
        token: 0x1::ascii::String,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        window_end_ms: u64,
        min_sui: u64,
        cap_sui: u64,
        dev_buy_sui: u64,
        dev_lock_days: u64,
        open_delay_ms: u64,
    }

    struct CurveCommitted has copy, drop {
        bundle_id: 0x2::object::ID,
        commit_id: 0x2::object::ID,
        backer: address,
        amount: u64,
        total: u64,
    }

    struct CurveRefundStarted has copy, drop {
        bundle_id: 0x2::object::ID,
        total: u64,
        timestamp_ms: u64,
    }

    struct CurveRefunded has copy, drop {
        bundle_id: 0x2::object::ID,
        commit_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct CurveBundleLaunched has copy, drop {
        bundle_id: 0x2::object::ID,
        curve_id: 0x2::object::ID,
        total: u64,
        spent: u64,
        launch_fee: u64,
        bought_tokens: u64,
        open_at_ms: u64,
    }

    struct CurveClaimed has copy, drop {
        bundle_id: 0x2::object::ID,
        commit_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        shares: u64,
        excess: u64,
    }

    struct CurveAttached has copy, drop {
        bundle_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        tokens: u64,
        share_supply: u64,
    }

    struct CurveExpired has copy, drop {
        bundle_id: 0x2::object::ID,
        curve_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct CurveRedeemed has copy, drop {
        bundle_id: 0x2::object::ID,
        owner: address,
        shares: u64,
        tokens: u64,
    }

    struct CurveDevReleased has copy, drop {
        bundle_id: 0x2::object::ID,
        lock_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    public fun attach<T0>(arg0: &mut CurveBundle<T0>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::graduation_record<T0>(arg1);
        assert!(0x1::option::is_some<0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::GraduationRecord>(&v0), 669);
        let v1 = 0x1::option::destroy_some<0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::GraduationRecord>(v0);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::protocol_fee<T0, 0x2::sui::SUI>(arg2);
        attach_internal<T0>(arg0, 0x2::object::id<0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>>(arg1), 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::status<T0>(arg1), 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::graduated_pool_id(&v1), 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::graduated_sqrt_price(&v1), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg2), v2, v3, arg3, arg4);
    }

    fun attach_internal<T0>(arg0: &mut CurveBundle<T0>, arg1: 0x2::object::ID, arg2: u8, arg3: 0x2::object::ID, arg4: u128, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 1, 667);
        assert!(0x1::option::some<0x2::object::ID>(arg1) == arg0.curve_id, 668);
        assert!(arg2 == 2, 669);
        assert!(arg5 == arg3, 671);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        let v1 = 0x2::balance::withdraw_all<T0>(&mut arg0.tokens);
        let v2 = 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::book_cetus::token_sqrt(arg4, false);
        let v3 = 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::book::new_on<T0, 0x2::sui::SUI>(1, false, arg5, arg0.terms.limits, 200, v1, 0x2::balance::zero<0x2::sui::SUI>());
        0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::book::seed<T0, 0x2::sui::SUI>(&mut v3, v0, v2);
        let v4 = 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::vault::new_on<T0, 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::bundle::Share<T0>, 0x2::sui::SUI, 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::vault::NoLaunch>(v3, 0x2::object::id<CurveBundle<T0>>(arg0), 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::vault::new_no_launch(arg9), arg0.terms.platform_bps, arg0.terms.sunset_bps, arg0.spent, arg0.spent, true, v2, v0, arg9);
        0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::vault::set_volume_baseline_raw<T0, 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::bundle::Share<T0>, 0x2::sui::SUI>(&mut v4, arg6, arg7);
        let v5 = 0x2::object::id<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::vault::Vault<T0, 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::bundle::Share<T0>, 0x2::sui::SUI>>(&v4);
        arg0.vault_id = 0x1::option::some<0x2::object::ID>(v5);
        arg0.state = 3;
        let v6 = CurveAttached{
            bundle_id    : 0x2::object::id<CurveBundle<T0>>(arg0),
            vault_id     : v5,
            pool_id      : arg5,
            tokens       : 0x2::balance::value<T0>(&v1),
            share_supply : arg0.spent,
        };
        0x2::event::emit<CurveAttached>(v6);
        0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::vault::share<T0, 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::bundle::Share<T0>, 0x2::sui::SUI>(v4);
    }

    public fun attach_unrecorded<T0>(arg0: &mut CurveBundle<T0>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>, arg2: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::graduation::TokenVault<T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::reserves<T0>(arg1);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::protocol_fee<T0, 0x2::sui::SUI>(arg3);
        let v4 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::graduation_record<T0>(arg1);
        attach_unrecorded_internal<T0>(arg0, 0x2::object::id<0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>>(arg1), 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::status<T0>(arg1), 0x1::option::is_some<0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::GraduationRecord>(&v4), 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::graduation::curve_id<T0>(arg2), 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::graduation::pool_id<T0>(arg2), v0, v1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg3), v2, v3, arg4, arg5);
    }

    fun attach_unrecorded_internal<T0>(arg0: &mut CurveBundle<T0>, arg1: 0x2::object::ID, arg2: u8, arg3: bool, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: 0x2::object::ID, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(!arg3, 677);
        assert!(arg4 == arg1, 668);
        attach_internal<T0>(arg0, arg1, arg2, arg5, graduation_sqrt(arg6, arg7), arg8, arg9, arg10, arg11, arg12);
    }

    fun check_launch_options(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        assert!(arg0 <= 1000, 676);
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::new_links(arg1, arg2, arg3);
    }

    fun check_token<T0>(arg0: &0x2::coin_registry::Currency<T0>, arg1: &0x2::coin::TreasuryCap<T0>) {
        assert!(0x2::coin_registry::treasury_cap_id<T0>(arg0) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::coin::TreasuryCap<T0>>(arg1)), 650);
        assert!(!0x2::coin_registry::is_regulated<T0>(arg0), 651);
        assert!(0x2::coin_registry::decimals<T0>(arg0) == 6, 652);
        assert!(0x2::coin::total_supply<T0>(arg1) == 0, 653);
    }

    public fun claim<T0>(arg0: &mut CurveBundle<T0>, arg1: CurveCommit<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::bundle::Share<T0>>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = if (arg0.state == 1) {
            true
        } else if (arg0.state == 3) {
            true
        } else {
            arg0.state == 4
        };
        assert!(v0, 667);
        let CurveCommit {
            id        : v1,
            bundle_id : v2,
            amount    : v3,
        } = arg1;
        let v4 = v1;
        assert!(v2 == 0x2::object::id<CurveBundle<T0>>(arg0), 666);
        arg0.claimed = arg0.claimed + 1;
        let (v5, v6) = if (arg0.claimed == arg0.commits) {
            (0x2::balance::value<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::bundle::Share<T0>>(&arg0.shares), 0x2::balance::value<0x2::sui::SUI>(&arg0.committed))
        } else {
            (mul_div(v3, arg0.spent, arg0.total), mul_div(v3, arg0.total - arg0.spent, arg0.total))
        };
        arg0.excess_paid = arg0.excess_paid + v6;
        let v7 = CurveClaimed{
            bundle_id : v2,
            commit_id : 0x2::object::uid_to_inner(&v4),
            owner     : 0x2::tx_context::sender(arg2),
            amount    : v3,
            shares    : v5,
            excess    : v6,
        };
        0x2::event::emit<CurveClaimed>(v7);
        0x2::object::delete(v4);
        (0x2::coin::from_balance<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::bundle::Share<T0>>(0x2::balance::split<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::bundle::Share<T0>>(&mut arg0.shares, v5), arg2), 0x2::coin::take<0x2::sui::SUI>(&mut arg0.committed, v6, arg2))
    }

    public fun commit<T0>(arg0: &mut CurveBundle<T0>, arg1: &0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::Config, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : CurveCommit<T0> {
        0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::assert_open<0x2::sui::SUI>(arg1);
        assert!(arg0.state == 0, 660);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.window_end_ms, 661);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= mul_div(arg0.cap_sui, 10, 10000), 659);
        commit_internal<T0>(arg0, arg2, arg4)
    }

    public fun commit_amount<T0>(arg0: &CurveCommit<T0>) : u64 {
        arg0.amount
    }

    fun commit_internal<T0>(arg0: &mut CurveBundle<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : CurveCommit<T0> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 675);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.committed, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.total = arg0.total + v0;
        arg0.commits = arg0.commits + 1;
        let v1 = CurveCommit<T0>{
            id        : 0x2::object::new(arg2),
            bundle_id : 0x2::object::id<CurveBundle<T0>>(arg0),
            amount    : v0,
        };
        let v2 = CurveCommitted{
            bundle_id : 0x2::object::id<CurveBundle<T0>>(arg0),
            commit_id : 0x2::object::id<CurveCommit<T0>>(&v1),
            backer    : 0x2::tx_context::sender(arg2),
            amount    : v0,
            total     : arg0.total,
        };
        0x2::event::emit<CurveCommitted>(v2);
        v1
    }

    public fun create<T0>(arg0: &0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::Config, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: &mut 0x2::coin_registry::CoinRegistry, arg3: 0x2::coin::TreasuryCap<T0>, arg4: 0x2::coin_registry::MetadataCap<T0>, arg5: &0x2::coin_registry::Currency<T0>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg8: u64, arg9: u64, arg10: u64, arg11: 0x2::coin::Coin<0x2::sui::SUI>, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: 0x1::string::String, arg17: 0x1::string::String, arg18: 0x1::string::String, arg19: u8, arg20: 0x2::coin::Coin<0x2::sui::SUI>, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) : CurveCommit<T0> {
        let v0 = 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::assert_open<0x2::sui::SUI>(arg0);
        assert!(arg8 >= 1800000 && arg8 <= 172800000, 654);
        let v1 = if (arg9 >= 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::min_target(&v0)) {
            if (arg9 <= arg10) {
                arg10 <= 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::max_target(&v0)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 655);
        assert!(arg14 >= 600000 && arg14 <= 86400000, 656);
        if (arg12 > 0) {
            let v2 = if (arg13 == 7) {
                true
            } else if (arg13 == 30) {
                true
            } else if (arg13 == 90) {
                true
            } else {
                arg13 == 180
            };
            assert!(v2, 657);
        } else {
            assert!(arg13 == 0, 657);
        };
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::fee_mode_preset(arg19);
        check_launch_options(arg15, arg16, arg17, arg18);
        let v3 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::params(arg1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg11) == 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::launch_fee(&v3) + arg12, 655);
        let v4 = 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::launch_fee_bps(arg0);
        let v5 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::initial_virtual_sui(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::graduation_sui(&v3));
        let v6 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::initial_virtual_tokens();
        assert!(tokens_for(v5, v6, net_of(arg10, v4) + arg12) <= mul_div(1000000000000000, 5000, 10000), 673);
        if (arg12 > 0) {
            let v7 = net_of(arg9, v4) + arg12;
            assert!(mul_div(tokens_for(v5, v6, v7), arg12, v7) <= mul_div(1000000000000000, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::max_dev_buy_bps(&v3), 10000), 674);
        };
        check_token<T0>(arg5, &arg3);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::mint_pool_creation_cap<T0>(arg6, arg7, &mut arg3, arg22);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::register_permission_pair<T0, 0x2::sui::SUI>(arg6, arg7, 200, &v8, arg22);
        let v9 = 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::bundle::new_share_cap<T0>(arg2, 9, 0x2::coin_registry::name<T0>(arg5), 0x2::coin_registry::symbol<T0>(arg5), 0x2::coin_registry::icon_url<T0>(arg5), arg22);
        let (v10, v11) = create_internal<T0>(arg0, arg3, arg4, arg5, v9, 0x1::option::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(v8), arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22);
        0x2::transfer::share_object<CurveBundle<T0>>(v10);
        v11
    }

    fun create_internal<T0>(arg0: &0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::Config, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin_registry::MetadataCap<T0>, arg3: &0x2::coin_registry::Currency<T0>, arg4: 0x2::coin::TreasuryCap<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::bundle::Share<T0>>, arg5: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>, arg6: u64, arg7: u64, arg8: u64, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: 0x1::string::String, arg17: u8, arg18: 0x2::coin::Coin<0x2::sui::SUI>, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) : (CurveBundle<T0>, CurveCommit<T0>) {
        let v0 = 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::quote_params<0x2::sui::SUI>(arg0);
        let v1 = CurveOptions{
            dev_buy_sui     : arg10,
            dev_lock_days   : arg11,
            open_delay_ms   : arg12,
            creator_tax_bps : arg13,
            website         : arg14,
            x               : arg15,
            telegram        : arg16,
            fee_mode        : arg17,
        };
        let v2 = VaultTerms{
            launch_fee_bps : 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::launch_fee_bps(arg0),
            platform_bps   : 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::platform_bps(arg0),
            sunset_bps     : 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::sunset_bps(arg0),
            limits         : 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::limits(&v0),
        };
        let v3 = CurveBundle<T0>{
            id                 : 0x2::object::new(arg20),
            creator            : 0x2::tx_context::sender(arg20),
            name               : 0x2::coin_registry::name<T0>(arg3),
            symbol             : 0x2::coin_registry::symbol<T0>(arg3),
            window_end_ms      : 0x2::clock::timestamp_ms(arg19) + arg6,
            min_sui            : arg7,
            cap_sui            : arg8,
            committed          : 0x2::balance::zero<0x2::sui::SUI>(),
            total              : 0,
            commits            : 0,
            claimed            : 0,
            dev_payment        : 0x2::coin::into_balance<0x2::sui::SUI>(arg9),
            options            : v1,
            token_cap          : 0x1::option::some<0x2::coin::TreasuryCap<T0>>(arg1),
            token_metadata_cap : 0x1::option::some<0x2::coin_registry::MetadataCap<T0>>(arg2),
            share_cap          : 0x1::option::some<0x2::coin::TreasuryCap<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::bundle::Share<T0>>>(arg4),
            state              : 0,
            spent              : 0,
            shares             : 0x2::balance::zero<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::bundle::Share<T0>>(),
            excess_paid        : 0,
            open_at_ms         : 0,
            curve_id           : 0x1::option::none<0x2::object::ID>(),
            tokens             : 0x2::balance::zero<T0>(),
            burned             : 0,
            vault_id           : 0x1::option::none<0x2::object::ID>(),
            terms              : v2,
            pool_cap           : arg5,
            dev_tokens         : 0x2::balance::zero<T0>(),
        };
        let v4 = CurveBundleCreated{
            bundle_id     : 0x2::object::id<CurveBundle<T0>>(&v3),
            creator       : v3.creator,
            token         : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            name          : v3.name,
            symbol        : v3.symbol,
            window_end_ms : v3.window_end_ms,
            min_sui       : arg7,
            cap_sui       : arg8,
            dev_buy_sui   : arg10,
            dev_lock_days : arg11,
            open_delay_ms : arg12,
        };
        0x2::event::emit<CurveBundleCreated>(v4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg18) >= mul_div(arg8, 100, 10000), 658);
        let v5 = &mut v3;
        (v3, commit_internal<T0>(v5, arg18, arg20))
    }

    public fun creator<T0>(arg0: &CurveBundle<T0>) : address {
        arg0.creator
    }

    public fun curve_id<T0>(arg0: &CurveBundle<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.curve_id
    }

    public fun expire<T0>(arg0: &mut CurveBundle<T0>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>, arg2: &0x2::clock::Clock) {
        expire_internal<T0>(arg0, 0x2::object::id<0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>>(arg1), 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::status<T0>(arg1), arg2);
    }

    fun expire_internal<T0>(arg0: &mut CurveBundle<T0>, arg1: 0x2::object::ID, arg2: u8, arg3: &0x2::clock::Clock) {
        assert!(arg0.state == 1, 667);
        assert!(0x1::option::some<0x2::object::ID>(arg1) == arg0.curve_id, 668);
        assert!(arg2 == 0, 670);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg0.open_at_ms + 604800000, 662);
        arg0.state = 4;
        let v1 = CurveExpired{
            bundle_id    : 0x2::object::id<CurveBundle<T0>>(arg0),
            curve_id     : arg1,
            timestamp_ms : v0,
        };
        0x2::event::emit<CurveExpired>(v1);
    }

    fun graduation_sqrt(arg0: u64, arg1: u64) : u128 {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::sqrt_price_x64(arg1, mul_div(arg0, 10000 - 1, 10000))
    }

    public fun held_dev_tokens<T0>(arg0: &CurveBundle<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.dev_tokens)
    }

    public fun held_tokens<T0>(arg0: &CurveBundle<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.tokens)
    }

    public fun launch<T0>(arg0: &mut CurveBundle<T0>, arg1: &0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::Config, arg2: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg3: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg4: &0x2::coin_registry::Currency<T0>, arg5: &mut 0x2::coin_registry::Currency<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::bundle::Share<T0>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = launch_pre<T0>(arg0, arg1, arg6, arg7);
        let (v4, v5, v6) = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::create_for_bundle<T0>(0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::curve_launcher(arg1), arg2, arg3, 0x1::option::extract<0x2::coin::TreasuryCap<T0>>(&mut arg0.token_cap), 0x1::option::extract<0x2::coin_registry::MetadataCap<T0>>(&mut arg0.token_metadata_cap), arg4, 0x1::option::extract<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(&mut arg0.pool_cap), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.dev_payment), arg7), arg0.options.dev_buy_sui, arg0.options.dev_lock_days, 0x2::coin::from_balance<0x2::sui::SUI>(v1, arg7), v3, arg0.options.creator_tax_bps, arg0.options.website, arg0.options.x, arg0.options.telegram, arg0.options.fee_mode, arg0.creator, arg6, arg7);
        0x2::balance::join<T0>(&mut arg0.dev_tokens, 0x2::coin::into_balance<T0>(v6));
        launch_post<T0>(arg0, arg5, v0, v2, v3, v4, v5);
    }

    fun launch_post<T0>(arg0: &mut CurveBundle<T0>, arg1: &mut 0x2::coin_registry::Currency<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::bundle::Share<T0>>, arg2: u64, arg3: u64, arg4: u64, arg5: 0x2::object::ID, arg6: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.tokens, 0x2::coin::into_balance<T0>(arg6));
        let v0 = 0x1::option::extract<0x2::coin::TreasuryCap<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::bundle::Share<T0>>>(&mut arg0.share_cap);
        0x2::balance::join<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::bundle::Share<T0>>(&mut arg0.shares, 0x2::coin::mint_balance<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::bundle::Share<T0>>(&mut v0, arg2));
        0x2::coin_registry::make_supply_burn_only<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::bundle::Share<T0>>(arg1, v0);
        arg0.spent = arg2;
        arg0.open_at_ms = arg4;
        arg0.curve_id = 0x1::option::some<0x2::object::ID>(arg5);
        arg0.state = 1;
        let v1 = CurveBundleLaunched{
            bundle_id     : 0x2::object::id<CurveBundle<T0>>(arg0),
            curve_id      : arg5,
            total         : arg0.total,
            spent         : arg2,
            launch_fee    : arg3,
            bought_tokens : 0x2::coin::value<T0>(&arg6),
            open_at_ms    : arg4,
        };
        0x2::event::emit<CurveBundleLaunched>(v1);
    }

    fun launch_pre<T0>(arg0: &mut CurveBundle<T0>, arg1: &0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (u64, 0x2::balance::Balance<0x2::sui::SUI>, u64, u64) {
        0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::assert_open<0x2::sui::SUI>(arg1);
        assert!(arg0.state == 0, 660);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.window_end_ms, 662);
        assert!(v0 < arg0.window_end_ms + 86400000, 664);
        assert!(arg0.total >= arg0.min_sui, 663);
        let v1 = if (arg0.total < arg0.cap_sui) {
            arg0.total
        } else {
            arg0.cap_sui
        };
        let v2 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.committed, v1);
        let v3 = mul_div(v1, arg0.terms.launch_fee_bps, 10000);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v2, v3), arg3), 0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::fee_recipient(arg1));
        };
        (v1, v2, v3, v0 + arg0.options.open_delay_ms)
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    fun net_of(arg0: u64, arg1: u64) : u64 {
        arg0 - mul_div(arg0, arg1, 10000)
    }

    public fun open_at_ms<T0>(arg0: &CurveBundle<T0>) : u64 {
        arg0.open_at_ms
    }

    public fun redeem_expired<T0>(arg0: &mut CurveBundle<T0>, arg1: &mut 0x2::coin_registry::Currency<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::bundle::Share<T0>>, arg2: 0x2::coin::Coin<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::bundle::Share<T0>>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.state == 4, 672);
        let v0 = 0x2::coin::value<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::bundle::Share<T0>>(&arg2);
        assert!(v0 > 0, 675);
        let v1 = mul_div(0x2::balance::value<T0>(&arg0.tokens), v0, arg0.spent - arg0.burned);
        arg0.burned = arg0.burned + v0;
        0x2::coin_registry::burn<0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::bundle::Share<T0>>(arg1, arg2);
        let v2 = CurveRedeemed{
            bundle_id : 0x2::object::id<CurveBundle<T0>>(arg0),
            owner     : 0x2::tx_context::sender(arg3),
            shares    : v0,
            tokens    : v1,
        };
        0x2::event::emit<CurveRedeemed>(v2);
        0x2::coin::take<T0>(&mut arg0.tokens, v1, arg3)
    }

    public fun refund<T0>(arg0: &mut CurveBundle<T0>, arg1: CurveCommit<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.state == 2, 665);
        let CurveCommit {
            id        : v0,
            bundle_id : v1,
            amount    : v2,
        } = arg1;
        let v3 = v0;
        assert!(v1 == 0x2::object::id<CurveBundle<T0>>(arg0), 666);
        let v4 = CurveRefunded{
            bundle_id : v1,
            commit_id : 0x2::object::uid_to_inner(&v3),
            owner     : 0x2::tx_context::sender(arg2),
            amount    : v2,
        };
        0x2::event::emit<CurveRefunded>(v4);
        0x2::object::delete(v3);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.committed, v2, arg2)
    }

    public fun release_dev<T0>(arg0: &mut CurveBundle<T0>, arg1: &0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::Config, arg2: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 3 || arg0.state == 4, 678);
        assert!(0x1::option::some<0x2::object::ID>(0x2::object::id<0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>>(arg2)) == arg0.curve_id, 668);
        let v0 = 0x2::balance::value<T0>(&arg0.dev_tokens);
        assert!(v0 > 0, 678);
        let v1 = CurveDevReleased{
            bundle_id : 0x2::object::id<CurveBundle<T0>>(arg0),
            lock_id   : 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::lock_dev_for_bundle<T0>(0x6917a02c3efd66fe57f813dc4c06bd030465b1ff6f01011bfa32ad94a2eee020::config::curve_launcher(arg1), arg2, 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.dev_tokens), arg4), arg0.options.dev_lock_days, arg0.creator, arg3, arg4),
            owner     : arg0.creator,
            amount    : v0,
        };
        0x2::event::emit<CurveDevReleased>(v1);
    }

    public fun start_refund<T0>(arg0: &mut CurveBundle<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 660);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.window_end_ms, 662);
        assert!(arg0.total < arg0.min_sui || v0 >= arg0.window_end_ms + 86400000, 662);
        arg0.state = 2;
        let v1 = arg0.creator;
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(0x1::option::extract<0x2::coin::TreasuryCap<T0>>(&mut arg0.token_cap), v1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<T0>>(0x1::option::extract<0x2::coin_registry::MetadataCap<T0>>(&mut arg0.token_metadata_cap), v1);
        if (0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(&arg0.pool_cap)) {
            0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(0x1::option::extract<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(&mut arg0.pool_cap), v1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.dev_payment), arg2), v1);
        let v2 = CurveRefundStarted{
            bundle_id    : 0x2::object::id<CurveBundle<T0>>(arg0),
            total        : arg0.total,
            timestamp_ms : v0,
        };
        0x2::event::emit<CurveRefundStarted>(v2);
    }

    public fun state<T0>(arg0: &CurveBundle<T0>) : u8 {
        arg0.state
    }

    fun tokens_for(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg1 as u128) * (arg2 as u128) / ((arg0 as u128) + (arg2 as u128))) as u64)
    }

    public fun totals<T0>(arg0: &CurveBundle<T0>) : (u64, u64, u64, u64) {
        (arg0.total, arg0.min_sui, arg0.cap_sui, arg0.spent)
    }

    public fun vault_id<T0>(arg0: &CurveBundle<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.vault_id
    }

    public fun window_end_ms<T0>(arg0: &CurveBundle<T0>) : u64 {
        arg0.window_end_ms
    }

    // decompiled from Move bytecode v7
}

