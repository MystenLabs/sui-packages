module 0x80b53028706c643252e9238111a04b38f57aec043df212748eca2dbd03f0f615::vice_pad {
    struct Route has key {
        id: 0x2::object::UID,
        pool_ids: vector<0x2::object::ID>,
        types_a: vector<0x1::type_name::TypeName>,
        types_b: vector<0x1::type_name::TypeName>,
        dexes: vector<u8>,
        a_to_b: vector<bool>,
        start_type: 0x1::type_name::TypeName,
        end_type: 0x1::type_name::TypeName,
    }

    struct RouteBuilder {
        pool_ids: vector<0x2::object::ID>,
        types_a: vector<0x1::type_name::TypeName>,
        types_b: vector<0x1::type_name::TypeName>,
        dexes: vector<u8>,
        a_to_b: vector<bool>,
        current_type: 0x1::type_name::TypeName,
    }

    struct ViceVenue has drop {
        dummy_field: bool,
    }

    struct PriceProof {
        route_id: 0x2::object::ID,
        cursor: u64,
        rate_q64: u256,
        reverse: bool,
        sqrt_prices: vector<u128>,
    }

    struct SwapPath2<phantom T0, T1> {
        route_id: 0x2::object::ID,
        cursor: u64,
        reverse: bool,
        expected_type: 0x1::type_name::TypeName,
        expected_coin_id: 0x2::object::ID,
        sqrt_prices: vector<u128>,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        tokens: 0x2::balance::Balance<T0>,
        ticket: T1,
    }

    fun advance<T0, T1>(arg0: &mut SwapPath2<T0, T1>, arg1: &Route, arg2: u64, arg3: 0x2::object::ID, arg4: 0x1::type_name::TypeName) {
        let v0 = if (arg0.reverse && !*0x1::vector::borrow<bool>(&arg1.a_to_b, arg2) || *0x1::vector::borrow<bool>(&arg1.a_to_b, arg2)) {
            *0x1::vector::borrow<0x1::type_name::TypeName>(&arg1.types_b, arg2)
        } else {
            *0x1::vector::borrow<0x1::type_name::TypeName>(&arg1.types_a, arg2)
        };
        assert!(arg4 == v0, 2);
        arg0.expected_type = arg4;
        arg0.expected_coin_id = arg3;
        let v1 = if (arg0.reverse) {
            arg2
        } else {
            arg2 + 1
        };
        arg0.cursor = v1;
    }

    public fun begin_auto_buy<T0>(arg0: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::AutomationOrder<T0>, arg1: u64, arg2: &Route, arg3: PriceProof, arg4: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg5: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg6: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, SwapPath2<T0, 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::StepTicket<T0>>) {
        assert!(0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::is_buy<T0>(arg0) && !arg3.reverse, 3);
        assert!(arg2.end_type == 0x1::type_name::with_defining_ids<T0>(), 2);
        let (v0, v1) = finish_price(arg3, arg2, 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::decimals<T0>(arg0));
        let v2 = ViceVenue{dummy_field: false};
        let (v3, v4, v5) = 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::begin_step<T0, ViceVenue>(arg0, v2, 0x2::object::id<Route>(arg2), v0, arg1, arg4, arg5, arg6, arg7, arg8);
        let v6 = v4;
        let v7 = v3;
        assert!(0x2::balance::value<T0>(&v6) == 0 && 0x2::balance::value<0x2::sui::SUI>(&v7) > 0, 7);
        let v8 = 0x2::coin::from_balance<0x2::sui::SUI>(v7, arg8);
        let v9 = SwapPath2<T0, 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::StepTicket<T0>>{
            route_id         : 0x2::object::id<Route>(arg2),
            cursor           : 0,
            reverse          : false,
            expected_type    : 0x1::type_name::with_defining_ids<0x2::sui::SUI>(),
            expected_coin_id : 0x2::object::id<0x2::coin::Coin<0x2::sui::SUI>>(&v8),
            sqrt_prices      : v1,
            sui              : 0x2::balance::zero<0x2::sui::SUI>(),
            tokens           : v6,
            ticket           : v5,
        };
        (v8, v9)
    }

    public fun begin_auto_sell<T0>(arg0: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::AutomationOrder<T0>, arg1: u64, arg2: &Route, arg3: PriceProof, arg4: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg5: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg6: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, SwapPath2<T0, 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::StepTicket<T0>>) {
        assert!(!0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::is_buy<T0>(arg0) && arg3.reverse, 3);
        assert!(arg2.end_type == 0x1::type_name::with_defining_ids<T0>(), 2);
        let (v0, v1) = finish_price(arg3, arg2, 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::decimals<T0>(arg0));
        let v2 = ViceVenue{dummy_field: false};
        let (v3, v4, v5) = 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::begin_step<T0, ViceVenue>(arg0, v2, 0x2::object::id<Route>(arg2), v0, arg1, arg4, arg5, arg6, arg7, arg8);
        let v6 = v4;
        let v7 = v3;
        assert!(0x2::balance::value<0x2::sui::SUI>(&v7) == 0 && 0x2::balance::value<T0>(&v6) > 0, 7);
        let v8 = 0x2::coin::from_balance<T0>(v6, arg8);
        let v9 = SwapPath2<T0, 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::StepTicket<T0>>{
            route_id         : 0x2::object::id<Route>(arg2),
            cursor           : 0x1::vector::length<0x2::object::ID>(&arg2.pool_ids),
            reverse          : true,
            expected_type    : 0x1::type_name::with_defining_ids<T0>(),
            expected_coin_id : 0x2::object::id<0x2::coin::Coin<T0>>(&v8),
            sqrt_prices      : v1,
            sui              : v7,
            tokens           : 0x2::balance::zero<T0>(),
            ticket           : v5,
        };
        (v8, v9)
    }

    public fun begin_limit_buy<T0>(arg0: 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueOrder<T0>, arg1: &Route, arg2: PriceProof, arg3: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg4: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg5: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg6: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, SwapPath2<T0, 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::FillTicket<T0>>) {
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_buy<T0>(&arg0), 3);
        assert!(arg1.end_type == 0x1::type_name::with_defining_ids<T0>(), 2);
        assert!(!arg2.reverse, 3);
        let (v0, v1) = finish_price(arg2, arg1, 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::decimals<T0>(&arg0));
        let v2 = ViceVenue{dummy_field: false};
        let (v3, v4, v5) = 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::begin_fill<T0, ViceVenue>(arg0, arg3, v2, 0x2::object::id<Route>(arg1), v0, arg4, arg5, arg6, arg7, arg8);
        let v6 = v4;
        let v7 = v3;
        assert!(0x2::balance::value<T0>(&v6) == 0 && 0x2::balance::value<0x2::sui::SUI>(&v7) > 0, 7);
        let v8 = 0x2::coin::from_balance<0x2::sui::SUI>(v7, arg8);
        let v9 = SwapPath2<T0, 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::FillTicket<T0>>{
            route_id         : 0x2::object::id<Route>(arg1),
            cursor           : 0,
            reverse          : false,
            expected_type    : 0x1::type_name::with_defining_ids<0x2::sui::SUI>(),
            expected_coin_id : 0x2::object::id<0x2::coin::Coin<0x2::sui::SUI>>(&v8),
            sqrt_prices      : v1,
            sui              : 0x2::balance::zero<0x2::sui::SUI>(),
            tokens           : v6,
            ticket           : v5,
        };
        (v8, v9)
    }

    public fun begin_limit_sell<T0>(arg0: 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueOrder<T0>, arg1: &Route, arg2: PriceProof, arg3: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg4: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg5: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg6: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, SwapPath2<T0, 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::FillTicket<T0>>) {
        assert!(!0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_buy<T0>(&arg0), 3);
        assert!(arg1.end_type == 0x1::type_name::with_defining_ids<T0>(), 2);
        assert!(arg2.reverse, 3);
        let (v0, v1) = finish_price(arg2, arg1, 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::decimals<T0>(&arg0));
        let v2 = ViceVenue{dummy_field: false};
        let (v3, v4, v5) = 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::begin_fill<T0, ViceVenue>(arg0, arg3, v2, 0x2::object::id<Route>(arg1), v0, arg4, arg5, arg6, arg7, arg8);
        let v6 = v4;
        let v7 = v3;
        assert!(0x2::balance::value<0x2::sui::SUI>(&v7) == 0 && 0x2::balance::value<T0>(&v6) > 0, 7);
        let v8 = 0x2::coin::from_balance<T0>(v6, arg8);
        let v9 = SwapPath2<T0, 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::FillTicket<T0>>{
            route_id         : 0x2::object::id<Route>(arg1),
            cursor           : 0x1::vector::length<0x2::object::ID>(&arg1.pool_ids),
            reverse          : true,
            expected_type    : 0x1::type_name::with_defining_ids<T0>(),
            expected_coin_id : 0x2::object::id<0x2::coin::Coin<T0>>(&v8),
            sqrt_prices      : v1,
            sui              : v7,
            tokens           : 0x2::balance::zero<T0>(),
            ticket           : v5,
        };
        (v8, v9)
    }

    fun check_step<T0, T1>(arg0: &SwapPath2<T0, T1>, arg1: &Route, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u8, arg5: bool, arg6: 0x1::type_name::TypeName, arg7: 0x1::type_name::TypeName, arg8: u128) : u64 {
        assert!(same_id(arg0.route_id, 0x2::object::id<Route>(arg1)) && same_id(arg0.expected_coin_id, arg2), 7);
        let v0 = if (arg0.reverse) {
            assert!(arg0.cursor > 0, 6);
            arg0.cursor - 1
        } else {
            arg0.cursor
        };
        assert!(v0 < 0x1::vector::length<0x2::object::ID>(&arg1.pool_ids), 6);
        assert!(leg_identity_ok(*0x1::vector::borrow<0x2::object::ID>(&arg1.pool_ids, v0), arg3, *0x1::vector::borrow<u8>(&arg1.dexes, v0), arg4, *0x1::vector::borrow<0x1::type_name::TypeName>(&arg1.types_a, v0), arg6, *0x1::vector::borrow<0x1::type_name::TypeName>(&arg1.types_b, v0), arg7), 1);
        let v1 = arg0.reverse && !*0x1::vector::borrow<bool>(&arg1.a_to_b, v0) || *0x1::vector::borrow<bool>(&arg1.a_to_b, v0);
        assert!(arg5 == v1, 3);
        let v2 = if (arg5) {
            arg6
        } else {
            arg7
        };
        assert!(arg0.expected_type == v2, 2);
        assert!(arg8 > 0 && arg8 == *0x1::vector::borrow<u128>(&arg0.sqrt_prices, v0), 4);
        v0
    }

    fun compose_rate(arg0: u256, arg1: u128, arg2: bool) : u256 {
        assert!(arg1 > 0, 4);
        let v0 = if (arg2) {
            (arg1 as u256) * (arg1 as u256) / 18446744073709551616
        } else {
            340282366920938463463374607431768211456 * 18446744073709551616 / (arg1 as u256) * (arg1 as u256)
        };
        assert!(v0 > 0, 4);
        let v1 = arg0 * v0 / 18446744073709551616;
        assert!(v1 > 0 && v1 <= 18446744073709551615 * 18446744073709551616, 5);
        v1
    }

    fun feed(arg0: PriceProof, arg1: &Route, arg2: 0x2::object::ID, arg3: u8, arg4: bool, arg5: 0x1::type_name::TypeName, arg6: 0x1::type_name::TypeName, arg7: u128) : PriceProof {
        assert!(same_id(arg0.route_id, 0x2::object::id<Route>(arg1)), 0);
        let v0 = if (arg0.reverse) {
            arg0.cursor - 1
        } else {
            arg0.cursor
        };
        assert!(v0 < 0x1::vector::length<0x2::object::ID>(&arg1.pool_ids), 6);
        assert!(leg_identity_ok(*0x1::vector::borrow<0x2::object::ID>(&arg1.pool_ids, v0), arg2, *0x1::vector::borrow<u8>(&arg1.dexes, v0), arg3, *0x1::vector::borrow<0x1::type_name::TypeName>(&arg1.types_a, v0), arg5, *0x1::vector::borrow<0x1::type_name::TypeName>(&arg1.types_b, v0), arg6), 1);
        let v1 = arg0.reverse && !*0x1::vector::borrow<bool>(&arg1.a_to_b, v0) || *0x1::vector::borrow<bool>(&arg1.a_to_b, v0);
        assert!(v1 == arg4, 3);
        assert!(arg7 > 0, 4);
        arg0.rate_q64 = compose_rate(arg0.rate_q64, arg7, arg4);
        *0x1::vector::borrow_mut<u128>(&mut arg0.sqrt_prices, v0) = arg7;
        let v2 = if (arg0.reverse) {
            v0
        } else {
            v0 + 1
        };
        arg0.cursor = v2;
        arg0
    }

    public fun feed_bluefin_a2b<T0, T1>(arg0: PriceProof, arg1: &Route, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) : PriceProof {
        feed(arg0, arg1, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), 0, true, 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg2))
    }

    public fun feed_bluefin_b2a<T0, T1>(arg0: PriceProof, arg1: &Route, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) : PriceProof {
        feed(arg0, arg1, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), 0, false, 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg2))
    }

    public fun feed_cetus_a2b<T0, T1>(arg0: PriceProof, arg1: &Route, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : PriceProof {
        feed(arg0, arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), 1, true, 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2))
    }

    public fun feed_cetus_b2a<T0, T1>(arg0: PriceProof, arg1: &Route, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : PriceProof {
        feed(arg0, arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), 1, false, 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2))
    }

    public fun feed_turbos_a2b<T0, T1, T2>(arg0: PriceProof, arg1: &Route, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>) : PriceProof {
        feed(arg0, arg1, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg2), 2, true, 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg2))
    }

    public fun feed_turbos_b2a<T0, T1, T2>(arg0: PriceProof, arg1: &Route, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>) : PriceProof {
        feed(arg0, arg1, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg2), 2, false, 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg2))
    }

    fun finish_price(arg0: PriceProof, arg1: &Route, arg2: u8) : (u128, vector<u128>) {
        let PriceProof {
            route_id    : v0,
            cursor      : v1,
            rate_q64    : v2,
            reverse     : v3,
            sqrt_prices : v4,
        } = arg0;
        assert!(same_id(v0, 0x2::object::id<Route>(arg1)) && is_complete(v1, 0x1::vector::length<0x2::object::ID>(&arg1.pool_ids), v3), 6);
        assert!(v2 > 0, 4);
        let v5 = price_scaled(v2, arg2, v3);
        assert!(v5 > 0 && v5 <= 18446744073709551615 * 18446744073709551616, 5);
        ((v5 as u128), v4)
    }

    public fun freeze_route(arg0: RouteBuilder, arg1: &mut 0x2::tx_context::TxContext) : Route {
        let RouteBuilder {
            pool_ids     : v0,
            types_a      : v1,
            types_b      : v2,
            dexes        : v3,
            a_to_b       : v4,
            current_type : v5,
        } = arg0;
        let v6 = v0;
        assert!(0x1::vector::length<0x2::object::ID>(&v6) > 0, 0);
        Route{
            id         : 0x2::object::new(arg1),
            pool_ids   : v6,
            types_a    : v1,
            types_b    : v2,
            dexes      : v3,
            a_to_b     : v4,
            start_type : 0x1::type_name::with_defining_ids<0x2::sui::SUI>(),
            end_type   : v5,
        }
    }

    fun is_complete(arg0: u64, arg1: u64, arg2: bool) : bool {
        arg2 && arg0 == 0 || arg0 == arg1
    }

    public fun leg_count(arg0: &Route) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.pool_ids)
    }

    fun leg_identity_ok(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u8, arg3: u8, arg4: 0x1::type_name::TypeName, arg5: 0x1::type_name::TypeName, arg6: 0x1::type_name::TypeName, arg7: 0x1::type_name::TypeName) : bool {
        if (same_id(arg0, arg1)) {
            if (arg2 == arg3) {
                if (arg4 == arg5) {
                    arg6 == arg7
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun place_buy<T0>(arg0: &Route, arg1: PriceProof, arg2: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg3: 0x2::object::ID, arg4: &0x2::coin::CoinMetadata<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u128, arg7: u64, arg8: 0x1::option::Option<address>, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.end_type == 0x1::type_name::with_defining_ids<T0>() && !arg1.reverse, 2);
        let (v0, _) = finish_price(arg1, arg0, 0x2::coin::get_decimals<T0>(arg4));
        let v2 = ViceVenue{dummy_field: false};
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::place_buy<T0, ViceVenue>(v2, arg2, 0x2::object::id<Route>(arg0), arg3, arg4, arg5, arg6, arg6 > v0, arg7, arg8, arg9, arg10, arg11);
    }

    public fun place_buy_currency<T0>(arg0: &Route, arg1: PriceProof, arg2: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg3: 0x2::object::ID, arg4: &0x2::coin_registry::Currency<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u128, arg7: u64, arg8: 0x1::option::Option<address>, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.end_type == 0x1::type_name::with_defining_ids<T0>() && !arg1.reverse, 2);
        let (v0, _) = finish_price(arg1, arg0, 0x2::coin_registry::decimals<T0>(arg4));
        let v2 = ViceVenue{dummy_field: false};
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::place_buy_currency<T0, ViceVenue>(v2, arg2, 0x2::object::id<Route>(arg0), arg3, arg4, arg5, arg6, arg6 > v0, arg7, arg8, arg9, arg10, arg11);
    }

    public fun place_dca<T0>(arg0: &Route, arg1: PriceProof, arg2: 0x2::object::ID, arg3: &0x2::coin::CoinMetadata<T0>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: u64, arg7: u128, arg8: u128, arg9: u16, arg10: 0x1::option::Option<address>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.end_type == 0x1::type_name::with_defining_ids<T0>() && !arg1.reverse, 2);
        let (_, _) = finish_price(arg1, arg0, 0x2::coin::get_decimals<T0>(arg3));
        0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::place_dca<T0, ViceVenue>(0x2::object::id<Route>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun place_dca_currency<T0>(arg0: &Route, arg1: PriceProof, arg2: 0x2::object::ID, arg3: &0x2::coin_registry::Currency<T0>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: u64, arg7: u128, arg8: u128, arg9: u16, arg10: 0x1::option::Option<address>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.end_type == 0x1::type_name::with_defining_ids<T0>() && !arg1.reverse, 2);
        let (_, _) = finish_price(arg1, arg0, 0x2::coin_registry::decimals<T0>(arg3));
        0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::place_dca_currency<T0, ViceVenue>(0x2::object::id<Route>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun place_sell<T0>(arg0: &Route, arg1: PriceProof, arg2: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg3: 0x2::object::ID, arg4: &0x2::coin::CoinMetadata<T0>, arg5: 0x2::coin::Coin<T0>, arg6: u128, arg7: u64, arg8: 0x1::option::Option<address>, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.end_type == 0x1::type_name::with_defining_ids<T0>() && arg1.reverse, 2);
        let (v0, _) = finish_price(arg1, arg0, 0x2::coin::get_decimals<T0>(arg4));
        let v2 = ViceVenue{dummy_field: false};
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::place_sell<T0, ViceVenue>(v2, arg2, 0x2::object::id<Route>(arg0), arg3, arg4, arg5, arg6, arg6 > v0, arg7, arg8, arg9, arg10, arg11);
    }

    public fun place_sell_currency<T0>(arg0: &Route, arg1: PriceProof, arg2: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg3: 0x2::object::ID, arg4: &0x2::coin_registry::Currency<T0>, arg5: 0x2::coin::Coin<T0>, arg6: u128, arg7: u64, arg8: 0x1::option::Option<address>, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.end_type == 0x1::type_name::with_defining_ids<T0>() && arg1.reverse, 2);
        let (v0, _) = finish_price(arg1, arg0, 0x2::coin_registry::decimals<T0>(arg4));
        let v2 = ViceVenue{dummy_field: false};
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::place_sell_currency<T0, ViceVenue>(v2, arg2, 0x2::object::id<Route>(arg0), arg3, arg4, arg5, arg6, arg6 > v0, arg7, arg8, arg9, arg10, arg11);
    }

    public fun place_strategy<T0>(arg0: &Route, arg1: PriceProof, arg2: 0x2::object::ID, arg3: &0x2::coin::CoinMetadata<T0>, arg4: 0x2::coin::Coin<T0>, arg5: vector<u128>, arg6: vector<bool>, arg7: vector<u16>, arg8: vector<bool>, arg9: u16, arg10: 0x1::option::Option<address>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.end_type == 0x1::type_name::with_defining_ids<T0>(), 2);
        let (_, _) = finish_price(arg1, arg0, 0x2::coin::get_decimals<T0>(arg3));
        0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::place_strategy<T0, ViceVenue>(0x2::object::id<Route>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun place_strategy_currency<T0>(arg0: &Route, arg1: PriceProof, arg2: 0x2::object::ID, arg3: &0x2::coin_registry::Currency<T0>, arg4: 0x2::coin::Coin<T0>, arg5: vector<u128>, arg6: vector<bool>, arg7: vector<u16>, arg8: vector<bool>, arg9: u16, arg10: 0x1::option::Option<address>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.end_type == 0x1::type_name::with_defining_ids<T0>(), 2);
        let (_, _) = finish_price(arg1, arg0, 0x2::coin_registry::decimals<T0>(arg3));
        0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::place_strategy_currency<T0, ViceVenue>(0x2::object::id<Route>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    fun pow10(arg0: u8) : u256 {
        assert!(arg0 <= 38, 5);
        let v0 = 0;
        let v1 = 1;
        while (v0 < arg0) {
            v1 = v1 * 10;
            v0 = v0 + 1;
        };
        v1
    }

    fun price_scaled(arg0: u256, arg1: u8, arg2: bool) : u256 {
        if (arg2) {
            arg0 * pow10(arg1) * 1000000000000 / 18446744073709551616
        } else {
            pow10(arg1) * 1000000000000 * 18446744073709551616 / arg0
        }
    }

    fun push(arg0: RouteBuilder, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: 0x1::type_name::TypeName, arg4: u8, arg5: bool) : RouteBuilder {
        assert!(0x1::vector::length<0x2::object::ID>(&arg0.pool_ids) < 4, 0);
        let v0 = if (arg5) {
            arg2
        } else {
            arg3
        };
        let v1 = if (arg5) {
            arg3
        } else {
            arg2
        };
        assert!(arg0.current_type == v0, 2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.pool_ids, arg1);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.types_a, arg2);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.types_b, arg3);
        0x1::vector::push_back<u8>(&mut arg0.dexes, arg4);
        0x1::vector::push_back<bool>(&mut arg0.a_to_b, arg5);
        arg0.current_type = v1;
        arg0
    }

    public fun push_bluefin_a2b<T0, T1>(arg0: RouteBuilder, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) : RouteBuilder {
        push(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1), 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), 0, true)
    }

    public fun push_bluefin_b2a<T0, T1>(arg0: RouteBuilder, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) : RouteBuilder {
        push(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1), 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), 0, false)
    }

    public fun push_cetus_a2b<T0, T1>(arg0: RouteBuilder, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : RouteBuilder {
        push(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1), 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), 1, true)
    }

    public fun push_cetus_b2a<T0, T1>(arg0: RouteBuilder, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : RouteBuilder {
        push(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1), 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), 1, false)
    }

    public fun push_turbos_a2b<T0, T1, T2>(arg0: RouteBuilder, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>) : RouteBuilder {
        push(arg0, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1), 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), 2, true)
    }

    public fun push_turbos_b2a<T0, T1, T2>(arg0: RouteBuilder, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>) : RouteBuilder {
        push(arg0, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1), 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), 2, false)
    }

    public fun route_id(arg0: &Route) : 0x2::object::ID {
        0x2::object::id<Route>(arg0)
    }

    fun same_id(arg0: 0x2::object::ID, arg1: 0x2::object::ID) : bool {
        arg0 == arg1
    }

    public fun settle_auto_buy<T0>(arg0: &Route, arg1: SwapPath2<T0, 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::StepTicket<T0>>, arg2: 0x2::coin::Coin<T0>, arg3: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg4: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.reverse && arg1.cursor == 0x1::vector::length<0x2::object::ID>(&arg0.pool_ids), 6);
        assert!(same_id(arg1.route_id, 0x2::object::id<Route>(arg0)) && arg0.end_type == 0x1::type_name::with_defining_ids<T0>(), 0);
        assert!(arg1.expected_type == 0x1::type_name::with_defining_ids<T0>() && arg1.expected_coin_id == 0x2::object::id<0x2::coin::Coin<T0>>(&arg2), 7);
        let SwapPath2 {
            route_id         : _,
            cursor           : _,
            reverse          : _,
            expected_type    : _,
            expected_coin_id : _,
            sqrt_prices      : _,
            sui              : v6,
            tokens           : v7,
            ticket           : v8,
        } = arg1;
        let v9 = v7;
        0x2::balance::join<T0>(&mut v9, 0x2::coin::into_balance<T0>(arg2));
        0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::settle_step<T0>(v8, v6, v9, arg3, arg4, arg5);
    }

    public fun settle_auto_sell<T0>(arg0: &Route, arg1: SwapPath2<T0, 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::StepTicket<T0>>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg4: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.reverse && arg1.cursor == 0, 6);
        assert!(same_id(arg1.route_id, 0x2::object::id<Route>(arg0)) && arg0.start_type == 0x1::type_name::with_defining_ids<0x2::sui::SUI>(), 0);
        assert!(arg1.expected_type == 0x1::type_name::with_defining_ids<0x2::sui::SUI>() && arg1.expected_coin_id == 0x2::object::id<0x2::coin::Coin<0x2::sui::SUI>>(&arg2), 7);
        let SwapPath2 {
            route_id         : _,
            cursor           : _,
            reverse          : _,
            expected_type    : _,
            expected_coin_id : _,
            sqrt_prices      : _,
            sui              : v6,
            tokens           : v7,
            ticket           : v8,
        } = arg1;
        let v9 = v6;
        0x2::balance::join<0x2::sui::SUI>(&mut v9, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::settle_step<T0>(v8, v9, v7, arg3, arg4, arg5);
    }

    public fun settle_limit_buy<T0>(arg0: &Route, arg1: SwapPath2<T0, 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::FillTicket<T0>>, arg2: 0x2::coin::Coin<T0>, arg3: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg4: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.reverse && arg1.cursor == 0x1::vector::length<0x2::object::ID>(&arg0.pool_ids), 6);
        assert!(same_id(arg1.route_id, 0x2::object::id<Route>(arg0)) && arg0.end_type == 0x1::type_name::with_defining_ids<T0>(), 0);
        assert!(arg1.expected_type == 0x1::type_name::with_defining_ids<T0>() && arg1.expected_coin_id == 0x2::object::id<0x2::coin::Coin<T0>>(&arg2), 7);
        let SwapPath2 {
            route_id         : _,
            cursor           : _,
            reverse          : _,
            expected_type    : _,
            expected_coin_id : _,
            sqrt_prices      : _,
            sui              : v6,
            tokens           : v7,
            ticket           : v8,
        } = arg1;
        let v9 = v7;
        0x2::balance::join<T0>(&mut v9, 0x2::coin::into_balance<T0>(arg2));
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::settle_fill<T0>(v8, v6, v9, arg3, arg4, arg5);
    }

    public fun settle_limit_sell<T0>(arg0: &Route, arg1: SwapPath2<T0, 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::FillTicket<T0>>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg4: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.reverse && arg1.cursor == 0, 6);
        assert!(same_id(arg1.route_id, 0x2::object::id<Route>(arg0)) && arg0.start_type == 0x1::type_name::with_defining_ids<0x2::sui::SUI>(), 0);
        assert!(arg1.expected_type == 0x1::type_name::with_defining_ids<0x2::sui::SUI>() && arg1.expected_coin_id == 0x2::object::id<0x2::coin::Coin<0x2::sui::SUI>>(&arg2), 7);
        let SwapPath2 {
            route_id         : _,
            cursor           : _,
            reverse          : _,
            expected_type    : _,
            expected_coin_id : _,
            sqrt_prices      : _,
            sui              : v6,
            tokens           : v7,
            ticket           : v8,
        } = arg1;
        let v9 = v6;
        0x2::balance::join<0x2::sui::SUI>(&mut v9, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::settle_fill<T0>(v8, v9, v7, arg3, arg4, arg5);
    }

    public fun share_route(arg0: Route) {
        0x2::transfer::share_object<Route>(arg0);
    }

    public fun start_price(arg0: &Route) : PriceProof {
        assert!(arg0.start_type == 0x1::type_name::with_defining_ids<0x2::sui::SUI>(), 2);
        PriceProof{
            route_id    : 0x2::object::id<Route>(arg0),
            cursor      : 0,
            rate_q64    : 18446744073709551616,
            reverse     : false,
            sqrt_prices : zero_prices(0x1::vector::length<0x2::object::ID>(&arg0.pool_ids)),
        }
    }

    public fun start_route() : RouteBuilder {
        RouteBuilder{
            pool_ids     : 0x1::vector::empty<0x2::object::ID>(),
            types_a      : 0x1::vector::empty<0x1::type_name::TypeName>(),
            types_b      : 0x1::vector::empty<0x1::type_name::TypeName>(),
            dexes        : b"",
            a_to_b       : vector[],
            current_type : 0x1::type_name::with_defining_ids<0x2::sui::SUI>(),
        }
    }

    public fun start_sell_price(arg0: &Route) : PriceProof {
        PriceProof{
            route_id    : 0x2::object::id<Route>(arg0),
            cursor      : 0x1::vector::length<0x2::object::ID>(&arg0.pool_ids),
            rate_q64    : 18446744073709551616,
            reverse     : true,
            sqrt_prices : zero_prices(0x1::vector::length<0x2::object::ID>(&arg0.pool_ids)),
        }
    }

    public fun swap_bluefin_a2b<T0, T1, T2, T3>(arg0: &Route, arg1: SwapPath2<T0, T1>, arg2: 0x2::coin::Coin<T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T3>, SwapPath2<T0, T1>) {
        let v0 = 0x2::coin::value<T2>(&arg2);
        assert!(v0 > 0, 7);
        let v1 = 0x2::coin::into_balance<T2>(arg2);
        let (v2, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg5, arg3, arg4, true, true, v0, 4295048016 + 1);
        let v5 = v4;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg3, arg4, 0x2::balance::split<T2>(&mut v1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v5)), 0x2::balance::zero<T3>(), v5);
        0x2::balance::join<T2>(&mut v1, v2);
        assert!(0x2::balance::value<T2>(&v1) == 0, 8);
        0x2::balance::destroy_zero<T2>(v1);
        let v6 = 0x2::coin::from_balance<T3>(v3, arg6);
        let v7 = &mut arg1;
        advance<T0, T1>(v7, arg0, check_step<T0, T1>(&arg1, arg0, 0x2::object::id<0x2::coin::Coin<T2>>(&arg2), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg4), 0, true, 0x1::type_name::with_defining_ids<T2>(), 0x1::type_name::with_defining_ids<T3>(), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T2, T3>(arg4)), 0x2::object::id<0x2::coin::Coin<T3>>(&v6), 0x1::type_name::with_defining_ids<T3>());
        (v6, arg1)
    }

    public fun swap_bluefin_b2a<T0, T1, T2, T3>(arg0: &Route, arg1: SwapPath2<T0, T1>, arg2: 0x2::coin::Coin<T3>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, SwapPath2<T0, T1>) {
        let v0 = 0x2::coin::value<T3>(&arg2);
        assert!(v0 > 0, 7);
        let v1 = 0x2::coin::into_balance<T3>(arg2);
        let (v2, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg5, arg3, arg4, false, true, v0, 79226673515401279992447579055 - 1);
        let v5 = v4;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg3, arg4, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v5)), v5);
        0x2::balance::join<T3>(&mut v1, v3);
        assert!(0x2::balance::value<T3>(&v1) == 0, 8);
        0x2::balance::destroy_zero<T3>(v1);
        let v6 = 0x2::coin::from_balance<T2>(v2, arg6);
        let v7 = &mut arg1;
        advance<T0, T1>(v7, arg0, check_step<T0, T1>(&arg1, arg0, 0x2::object::id<0x2::coin::Coin<T3>>(&arg2), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg4), 0, false, 0x1::type_name::with_defining_ids<T2>(), 0x1::type_name::with_defining_ids<T3>(), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T2, T3>(arg4)), 0x2::object::id<0x2::coin::Coin<T2>>(&v6), 0x1::type_name::with_defining_ids<T2>());
        (v6, arg1)
    }

    public fun swap_cetus_a2b<T0, T1, T2, T3>(arg0: &Route, arg1: SwapPath2<T0, T1>, arg2: 0x2::coin::Coin<T2>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T3>, SwapPath2<T0, T1>) {
        let v0 = 0x2::coin::value<T2>(&arg2);
        assert!(v0 > 0, 7);
        let v1 = 0x2::coin::into_balance<T2>(arg2);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg3, arg4, true, true, v0, 4295048016 + 1, arg5);
        let v5 = v4;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg3, arg4, 0x2::balance::split<T2>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v5)), 0x2::balance::zero<T3>(), v5);
        0x2::balance::join<T2>(&mut v1, v2);
        assert!(0x2::balance::value<T2>(&v1) == 0, 8);
        0x2::balance::destroy_zero<T2>(v1);
        let v6 = 0x2::coin::from_balance<T3>(v3, arg6);
        let v7 = &mut arg1;
        advance<T0, T1>(v7, arg0, check_step<T0, T1>(&arg1, arg0, 0x2::object::id<0x2::coin::Coin<T2>>(&arg2), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4), 1, true, 0x1::type_name::with_defining_ids<T2>(), 0x1::type_name::with_defining_ids<T3>(), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T2, T3>(arg4)), 0x2::object::id<0x2::coin::Coin<T3>>(&v6), 0x1::type_name::with_defining_ids<T3>());
        (v6, arg1)
    }

    public fun swap_cetus_b2a<T0, T1, T2, T3>(arg0: &Route, arg1: SwapPath2<T0, T1>, arg2: 0x2::coin::Coin<T3>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, SwapPath2<T0, T1>) {
        let v0 = 0x2::coin::value<T3>(&arg2);
        assert!(v0 > 0, 7);
        let v1 = 0x2::coin::into_balance<T3>(arg2);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg3, arg4, false, true, v0, 79226673515401279992447579055 - 1, arg5);
        let v5 = v4;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg3, arg4, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v5)), v5);
        0x2::balance::join<T3>(&mut v1, v3);
        assert!(0x2::balance::value<T3>(&v1) == 0, 8);
        0x2::balance::destroy_zero<T3>(v1);
        let v6 = 0x2::coin::from_balance<T2>(v2, arg6);
        let v7 = &mut arg1;
        advance<T0, T1>(v7, arg0, check_step<T0, T1>(&arg1, arg0, 0x2::object::id<0x2::coin::Coin<T3>>(&arg2), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4), 1, false, 0x1::type_name::with_defining_ids<T2>(), 0x1::type_name::with_defining_ids<T3>(), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T2, T3>(arg4)), 0x2::object::id<0x2::coin::Coin<T2>>(&v6), 0x1::type_name::with_defining_ids<T2>());
        (v6, arg1)
    }

    public fun swap_turbos_a2b<T0, T1, T2, T3, T4>(arg0: &Route, arg1: SwapPath2<T0, T1>, arg2: 0x2::coin::Coin<T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T3>, SwapPath2<T0, T1>) {
        let v0 = 0x2::coin::value<T2>(&arg2);
        assert!(v0 > 0, 7);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T2>>();
        0x1::vector::push_back<0x2::coin::Coin<T2>>(&mut v1, arg2);
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T2, T3, T4>(arg3, v1, v0, 0, 4295048016, true, 0x2::tx_context::sender(arg6), 0x2::clock::timestamp_ms(arg5) + 60000, arg5, arg4, arg6);
        let v4 = v3;
        let v5 = v2;
        assert!(0x2::coin::value<T2>(&v4) == 0, 8);
        0x2::coin::destroy_zero<T2>(v4);
        let v6 = &mut arg1;
        advance<T0, T1>(v6, arg0, check_step<T0, T1>(&arg1, arg0, 0x2::object::id<0x2::coin::Coin<T2>>(&arg2), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>>(arg3), 2, true, 0x1::type_name::with_defining_ids<T2>(), 0x1::type_name::with_defining_ids<T3>(), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T2, T3, T4>(arg3)), 0x2::object::id<0x2::coin::Coin<T3>>(&v5), 0x1::type_name::with_defining_ids<T3>());
        (v5, arg1)
    }

    public fun swap_turbos_b2a<T0, T1, T2, T3, T4>(arg0: &Route, arg1: SwapPath2<T0, T1>, arg2: 0x2::coin::Coin<T3>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, SwapPath2<T0, T1>) {
        let v0 = 0x2::coin::value<T3>(&arg2);
        assert!(v0 > 0, 7);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T3>>();
        0x1::vector::push_back<0x2::coin::Coin<T3>>(&mut v1, arg2);
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T2, T3, T4>(arg3, v1, v0, 0, 79226673515401279992447579055 - 1, true, 0x2::tx_context::sender(arg6), 0x2::clock::timestamp_ms(arg5) + 60000, arg5, arg4, arg6);
        let v4 = v3;
        let v5 = v2;
        assert!(0x2::coin::value<T3>(&v4) == 0, 8);
        0x2::coin::destroy_zero<T3>(v4);
        let v6 = &mut arg1;
        advance<T0, T1>(v6, arg0, check_step<T0, T1>(&arg1, arg0, 0x2::object::id<0x2::coin::Coin<T3>>(&arg2), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>>(arg3), 2, false, 0x1::type_name::with_defining_ids<T2>(), 0x1::type_name::with_defining_ids<T3>(), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T2, T3, T4>(arg3)), 0x2::object::id<0x2::coin::Coin<T2>>(&v5), 0x1::type_name::with_defining_ids<T2>());
        (v5, arg1)
    }

    public fun terminal_type(arg0: &Route) : 0x1::type_name::TypeName {
        arg0.end_type
    }

    fun zero_prices(arg0: u64) : vector<u128> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < arg0) {
            0x1::vector::push_back<u128>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

