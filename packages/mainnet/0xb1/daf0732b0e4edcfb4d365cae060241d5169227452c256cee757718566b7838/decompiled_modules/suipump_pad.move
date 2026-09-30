module 0xcbb2625f7a0953d76b62ff1a3dbd5833eee5b0879a8837494e7fdfe98421841e::suipump_pad {
    struct SuipumpVenue has drop {
        dummy_field: bool,
    }

    public fun graduated<T0>(arg0: &0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>) : bool {
        0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::graduated<T0>(arg0)
    }

    public fun place_buy<T0>(arg0: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg1: &0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u128, arg5: u64, arg6: 0x1::option::Option<address>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::graduated<T0>(arg1), 0);
        let v0 = SuipumpVenue{dummy_field: false};
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::place_buy<T0, SuipumpVenue>(v0, arg0, 0x2::object::id<0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>>(arg1), 0x2::object::id<0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>>(arg1), arg2, arg3, arg4, arg4 > price<T0>(arg1, 0x2::coin::get_decimals<T0>(arg2)), arg5, arg6, arg7, arg8, arg9);
    }

    public fun place_buy_currency<T0>(arg0: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg1: &0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>, arg2: &0x2::coin_registry::Currency<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u128, arg5: u64, arg6: 0x1::option::Option<address>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::graduated<T0>(arg1), 0);
        let v0 = SuipumpVenue{dummy_field: false};
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::place_buy_currency<T0, SuipumpVenue>(v0, arg0, 0x2::object::id<0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>>(arg1), 0x2::object::id<0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>>(arg1), arg2, arg3, arg4, arg4 > price<T0>(arg1, 0x2::coin_registry::decimals<T0>(arg2)), arg5, arg6, arg7, arg8, arg9);
    }

    public fun place_sell<T0>(arg0: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg1: &0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: 0x2::coin::Coin<T0>, arg4: u128, arg5: u64, arg6: 0x1::option::Option<address>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::graduated<T0>(arg1), 0);
        let v0 = SuipumpVenue{dummy_field: false};
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::place_sell<T0, SuipumpVenue>(v0, arg0, 0x2::object::id<0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>>(arg1), 0x2::object::id<0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>>(arg1), arg2, arg3, arg4, arg4 > price<T0>(arg1, 0x2::coin::get_decimals<T0>(arg2)), arg5, arg6, arg7, arg8, arg9);
    }

    public fun place_sell_currency<T0>(arg0: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg1: &0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>, arg2: &0x2::coin_registry::Currency<T0>, arg3: 0x2::coin::Coin<T0>, arg4: u128, arg5: u64, arg6: 0x1::option::Option<address>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::graduated<T0>(arg1), 0);
        let v0 = SuipumpVenue{dummy_field: false};
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::place_sell_currency<T0, SuipumpVenue>(v0, arg0, 0x2::object::id<0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>>(arg1), 0x2::object::id<0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>>(arg1), arg2, arg3, arg4, arg4 > price<T0>(arg1, 0x2::coin_registry::decimals<T0>(arg2)), arg5, arg6, arg7, arg8, arg9);
    }

    fun check_pool(arg0: 0x1::option::Option<0x2::object::ID>, arg1: 0x2::object::ID) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0), 1);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0) == arg1, 1);
    }

    public fun fill<T0>(arg0: 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueOrder<T0>, arg1: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg2: &mut 0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>, arg3: &0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::PriceConfig, arg4: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg5: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg6: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::graduated<T0>(arg2), 0);
        let v0 = SuipumpVenue{dummy_field: false};
        let (v1, v2, v3) = 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::begin_fill<T0, SuipumpVenue>(arg0, arg1, v0, 0x2::object::id<0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>>(arg2), price<T0>(arg2, 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::decimals<T0>(&arg0)), arg4, arg5, arg6, arg7, arg8);
        if (0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_buy<T0>(&arg0)) {
            0x2::balance::destroy_zero<T0>(v2);
            let (v4, v5) = 0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::buy<T0>(arg2, 0x2::coin::from_balance<0x2::sui::SUI>(v1, arg8), 0, 0x1::option::none<address>(), arg3, arg7, arg8);
            0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::settle_fill<T0>(v3, 0x2::coin::into_balance<0x2::sui::SUI>(v5), 0x2::coin::into_balance<T0>(v4), arg4, arg5, arg8);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
            0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::settle_fill<T0>(v3, 0x2::coin::into_balance<0x2::sui::SUI>(0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::sell<T0>(arg2, 0x2::coin::from_balance<T0>(v2, arg8), 0, 0x1::option::none<address>(), arg8)), 0x2::balance::zero<T0>(), arg4, arg5, arg8);
        };
    }

    public fun fill_auto<T0>(arg0: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::AutomationOrder<T0>, arg1: u64, arg2: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg3: &mut 0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>, arg4: &0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::PriceConfig, arg5: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg6: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg7: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_approved<SuipumpVenue>(arg2), 100);
        assert!(!0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::graduated<T0>(arg3), 0);
        let v0 = SuipumpVenue{dummy_field: false};
        let (v1, v2, v3) = 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::begin_step<T0, SuipumpVenue>(arg0, v0, 0x2::object::id<0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>>(arg3), price<T0>(arg3, 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::decimals<T0>(arg0)), arg1, arg5, arg6, arg7, arg8, arg9);
        if (0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::is_buy<T0>(arg0)) {
            0x2::balance::destroy_zero<T0>(v2);
            let (v4, v5) = 0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::buy<T0>(arg3, 0x2::coin::from_balance<0x2::sui::SUI>(v1, arg9), 0, 0x1::option::none<address>(), arg4, arg8, arg9);
            0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::settle_step<T0>(v3, 0x2::coin::into_balance<0x2::sui::SUI>(v5), 0x2::coin::into_balance<T0>(v4), arg5, arg6, arg9);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
            0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::settle_step<T0>(v3, 0x2::coin::into_balance<0x2::sui::SUI>(0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::sell<T0>(arg3, 0x2::coin::from_balance<T0>(v2, arg9), 0, 0x1::option::none<address>(), arg9)), 0x2::balance::zero<T0>(), arg5, arg6, arg9);
        };
    }

    public fun fill_auto_graduated_a<T0>(arg0: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::AutomationOrder<T0>, arg1: u64, arg2: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg3: &0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg6: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg7: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg8: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_approved<SuipumpVenue>(arg2), 100);
        assert!(0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::graduated<T0>(arg3), 2);
        check_pool(0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::pool_id<T0>(arg3), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>>(arg5));
        fill_auto_pool_a<T0>(arg0, arg1, 0x2::object::id<0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>>(arg3), arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun fill_auto_graduated_a_template<T0>(arg0: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::AutomationOrder<T0>, arg1: u64, arg2: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg3: &0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::Curve<T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg6: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg7: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg8: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_approved<SuipumpVenue>(arg2), 100);
        assert!(0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::graduated<T0>(arg3), 2);
        check_pool(0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::pool_id<T0>(arg3), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>>(arg5));
        fill_auto_pool_a<T0>(arg0, arg1, 0x2::object::id<0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::Curve<T0>>(arg3), arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun fill_auto_graduated_b<T0>(arg0: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::AutomationOrder<T0>, arg1: u64, arg2: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg3: &0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg6: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg7: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg8: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_approved<SuipumpVenue>(arg2), 100);
        assert!(0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::graduated<T0>(arg3), 2);
        check_pool(0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::pool_id<T0>(arg3), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg5));
        fill_auto_pool_b<T0>(arg0, arg1, 0x2::object::id<0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>>(arg3), arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun fill_auto_graduated_b_template<T0>(arg0: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::AutomationOrder<T0>, arg1: u64, arg2: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg3: &0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::Curve<T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg6: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg7: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg8: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_approved<SuipumpVenue>(arg2), 100);
        assert!(0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::graduated<T0>(arg3), 2);
        check_pool(0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::pool_id<T0>(arg3), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg5));
        fill_auto_pool_b<T0>(arg0, arg1, 0x2::object::id<0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::Curve<T0>>(arg3), arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    fun fill_auto_pool_a<T0>(arg0: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::AutomationOrder<T0>, arg1: u64, arg2: 0x2::object::ID, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg5: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg6: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg7: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = SuipumpVenue{dummy_field: false};
        let (v1, v2, v3) = 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::begin_step<T0, SuipumpVenue>(arg0, v0, arg2, pool_price(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0x2::sui::SUI, T0>(arg4), 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::decimals<T0>(arg0), true), arg1, arg5, arg6, arg7, arg8, arg9);
        let v4 = v2;
        let v5 = v1;
        if (0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::is_buy<T0>(arg0)) {
            let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x2::sui::SUI, T0>(arg3, arg4, true, true, 0x2::balance::value<0x2::sui::SUI>(&v5), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price() + 1, arg8);
            let v9 = v8;
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x2::sui::SUI, T0>(arg3, arg4, 0x2::balance::split<0x2::sui::SUI>(&mut v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0x2::sui::SUI, T0>(&v9)), 0x2::balance::zero<T0>(), v9);
            0x2::balance::join<0x2::sui::SUI>(&mut v5, v6);
            0x2::balance::join<T0>(&mut v4, v7);
            assert!(0x2::balance::value<T0>(&v4) > 0, 5);
        } else {
            let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x2::sui::SUI, T0>(arg3, arg4, false, true, 0x2::balance::value<T0>(&v4), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price() - 1, arg8);
            let v13 = v12;
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x2::sui::SUI, T0>(arg3, arg4, 0x2::balance::zero<0x2::sui::SUI>(), 0x2::balance::split<T0>(&mut v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0x2::sui::SUI, T0>(&v13)), v13);
            0x2::balance::join<0x2::sui::SUI>(&mut v5, v10);
            0x2::balance::join<T0>(&mut v4, v11);
            assert!(0x2::balance::value<0x2::sui::SUI>(&v5) > 0, 5);
        };
        0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::settle_step<T0>(v3, v5, v4, arg5, arg6, arg9);
    }

    fun fill_auto_pool_b<T0>(arg0: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::AutomationOrder<T0>, arg1: u64, arg2: 0x2::object::ID, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg6: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg7: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = SuipumpVenue{dummy_field: false};
        let (v1, v2, v3) = 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::begin_step<T0, SuipumpVenue>(arg0, v0, arg2, pool_price(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0x2::sui::SUI>(arg4), 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::decimals<T0>(arg0), false), arg1, arg5, arg6, arg7, arg8, arg9);
        let v4 = v2;
        let v5 = v1;
        if (0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::is_buy<T0>(arg0)) {
            let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg3, arg4, false, true, 0x2::balance::value<0x2::sui::SUI>(&v5), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price() - 1, arg8);
            let v9 = v8;
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg3, arg4, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(&mut v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v9)), v9);
            0x2::balance::join<0x2::sui::SUI>(&mut v5, v7);
            0x2::balance::join<T0>(&mut v4, v6);
            assert!(0x2::balance::value<T0>(&v4) > 0, 5);
        } else {
            let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg3, arg4, true, true, 0x2::balance::value<T0>(&v4), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price() + 1, arg8);
            let v13 = v12;
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg3, arg4, 0x2::balance::split<T0>(&mut v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v13)), 0x2::balance::zero<0x2::sui::SUI>(), v13);
            0x2::balance::join<0x2::sui::SUI>(&mut v5, v11);
            0x2::balance::join<T0>(&mut v4, v10);
            assert!(0x2::balance::value<0x2::sui::SUI>(&v5) > 0, 5);
        };
        0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::settle_step<T0>(v3, v5, v4, arg5, arg6, arg9);
    }

    public fun fill_auto_template<T0>(arg0: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::AutomationOrder<T0>, arg1: u64, arg2: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg3: &mut 0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::Curve<T0>, arg4: &0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::PriceConfig, arg5: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg6: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg7: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_approved<SuipumpVenue>(arg2), 100);
        assert!(!0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::graduated<T0>(arg3), 0);
        let v0 = SuipumpVenue{dummy_field: false};
        let (v1, v2, v3) = 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::begin_step<T0, SuipumpVenue>(arg0, v0, 0x2::object::id<0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::Curve<T0>>(arg3), price_template<T0>(arg3, 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::decimals<T0>(arg0)), arg1, arg5, arg6, arg7, arg8, arg9);
        if (0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::is_buy<T0>(arg0)) {
            0x2::balance::destroy_zero<T0>(v2);
            let (v4, v5) = 0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::buy<T0>(arg3, 0x2::coin::from_balance<0x2::sui::SUI>(v1, arg9), 0, 0x1::option::none<address>(), arg4, arg8, arg9);
            0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::settle_step<T0>(v3, 0x2::coin::into_balance<0x2::sui::SUI>(v5), 0x2::coin::into_balance<T0>(v4), arg5, arg6, arg9);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
            0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::settle_step<T0>(v3, 0x2::coin::into_balance<0x2::sui::SUI>(0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::sell<T0>(arg3, 0x2::coin::from_balance<T0>(v2, arg9), 0, 0x1::option::none<address>(), arg9)), 0x2::balance::zero<T0>(), arg5, arg6, arg9);
        };
    }

    public fun fill_graduated_a<T0>(arg0: 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueOrder<T0>, arg1: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg2: &0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg5: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg6: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg7: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::graduated<T0>(arg2), 2);
        check_pool(0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::pool_id<T0>(arg2), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>>(arg4));
        fill_pool_a<T0>(arg0, arg1, 0x2::object::id<0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>>(arg2), arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun fill_graduated_a_template<T0>(arg0: 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueOrder<T0>, arg1: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg2: &0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::Curve<T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg5: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg6: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg7: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::graduated<T0>(arg2), 2);
        check_pool(0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::pool_id<T0>(arg2), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>>(arg4));
        fill_pool_a<T0>(arg0, arg1, 0x2::object::id<0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::Curve<T0>>(arg2), arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun fill_graduated_b<T0>(arg0: 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueOrder<T0>, arg1: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg2: &0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg6: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg7: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::graduated<T0>(arg2), 2);
        check_pool(0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::pool_id<T0>(arg2), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg4));
        fill_pool_b<T0>(arg0, arg1, 0x2::object::id<0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>>(arg2), arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun fill_graduated_b_template<T0>(arg0: 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueOrder<T0>, arg1: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg2: &0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::Curve<T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg6: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg7: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::graduated<T0>(arg2), 2);
        check_pool(0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::pool_id<T0>(arg2), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg4));
        fill_pool_b<T0>(arg0, arg1, 0x2::object::id<0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::Curve<T0>>(arg2), arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    fun fill_pool_a<T0>(arg0: 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueOrder<T0>, arg1: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg2: 0x2::object::ID, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg5: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg6: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg7: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = SuipumpVenue{dummy_field: false};
        let (v1, v2, v3) = 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::begin_fill<T0, SuipumpVenue>(arg0, arg1, v0, arg2, pool_price(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0x2::sui::SUI, T0>(arg4), 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::decimals<T0>(&arg0), true), arg5, arg6, arg7, arg8, arg9);
        let v4 = v2;
        let v5 = v1;
        if (0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_buy<T0>(&arg0)) {
            let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x2::sui::SUI, T0>(arg3, arg4, true, true, 0x2::balance::value<0x2::sui::SUI>(&v5), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price() + 1, arg8);
            let v9 = v8;
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x2::sui::SUI, T0>(arg3, arg4, 0x2::balance::split<0x2::sui::SUI>(&mut v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0x2::sui::SUI, T0>(&v9)), 0x2::balance::zero<T0>(), v9);
            0x2::balance::join<0x2::sui::SUI>(&mut v5, v6);
            0x2::balance::join<T0>(&mut v4, v7);
            assert!(0x2::balance::value<T0>(&v4) > 0, 5);
        } else {
            let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x2::sui::SUI, T0>(arg3, arg4, false, true, 0x2::balance::value<T0>(&v4), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price() - 1, arg8);
            let v13 = v12;
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x2::sui::SUI, T0>(arg3, arg4, 0x2::balance::zero<0x2::sui::SUI>(), 0x2::balance::split<T0>(&mut v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0x2::sui::SUI, T0>(&v13)), v13);
            0x2::balance::join<0x2::sui::SUI>(&mut v5, v10);
            0x2::balance::join<T0>(&mut v4, v11);
            assert!(0x2::balance::value<0x2::sui::SUI>(&v5) > 0, 5);
        };
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::settle_fill<T0>(v3, v5, v4, arg5, arg6, arg9);
    }

    fun fill_pool_b<T0>(arg0: 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueOrder<T0>, arg1: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg2: 0x2::object::ID, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg6: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg7: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = SuipumpVenue{dummy_field: false};
        let (v1, v2, v3) = 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::begin_fill<T0, SuipumpVenue>(arg0, arg1, v0, arg2, pool_price(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0x2::sui::SUI>(arg4), 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::decimals<T0>(&arg0), false), arg5, arg6, arg7, arg8, arg9);
        let v4 = v2;
        let v5 = v1;
        if (0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_buy<T0>(&arg0)) {
            let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg3, arg4, false, true, 0x2::balance::value<0x2::sui::SUI>(&v5), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price() - 1, arg8);
            let v9 = v8;
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg3, arg4, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(&mut v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v9)), v9);
            0x2::balance::join<0x2::sui::SUI>(&mut v5, v7);
            0x2::balance::join<T0>(&mut v4, v6);
            assert!(0x2::balance::value<T0>(&v4) > 0, 5);
        } else {
            let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg3, arg4, true, true, 0x2::balance::value<T0>(&v4), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price() + 1, arg8);
            let v13 = v12;
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg3, arg4, 0x2::balance::split<T0>(&mut v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v13)), 0x2::balance::zero<0x2::sui::SUI>(), v13);
            0x2::balance::join<0x2::sui::SUI>(&mut v5, v11);
            0x2::balance::join<T0>(&mut v4, v10);
            assert!(0x2::balance::value<0x2::sui::SUI>(&v5) > 0, 5);
        };
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::settle_fill<T0>(v3, v5, v4, arg5, arg6, arg9);
    }

    public fun fill_template<T0>(arg0: 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueOrder<T0>, arg1: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg2: &mut 0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::Curve<T0>, arg3: &0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::PriceConfig, arg4: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg5: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg6: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::graduated<T0>(arg2), 0);
        let v0 = SuipumpVenue{dummy_field: false};
        let (v1, v2, v3) = 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::begin_fill<T0, SuipumpVenue>(arg0, arg1, v0, 0x2::object::id<0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::Curve<T0>>(arg2), price_template<T0>(arg2, 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::decimals<T0>(&arg0)), arg4, arg5, arg6, arg7, arg8);
        if (0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_buy<T0>(&arg0)) {
            0x2::balance::destroy_zero<T0>(v2);
            let (v4, v5) = 0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::buy<T0>(arg2, 0x2::coin::from_balance<0x2::sui::SUI>(v1, arg8), 0, 0x1::option::none<address>(), arg3, arg7, arg8);
            0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::settle_fill<T0>(v3, 0x2::coin::into_balance<0x2::sui::SUI>(v5), 0x2::coin::into_balance<T0>(v4), arg4, arg5, arg8);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
            0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::settle_fill<T0>(v3, 0x2::coin::into_balance<0x2::sui::SUI>(0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::sell<T0>(arg2, 0x2::coin::from_balance<T0>(v2, arg8), 0, 0x1::option::none<address>(), arg8)), 0x2::balance::zero<T0>(), arg4, arg5, arg8);
        };
    }

    public fun graduated_template<T0>(arg0: &0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::Curve<T0>) : bool {
        0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::graduated<T0>(arg0)
    }

    public fun place_buy_template<T0>(arg0: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg1: &0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::Curve<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u128, arg5: u64, arg6: 0x1::option::Option<address>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::graduated<T0>(arg1), 0);
        let v0 = SuipumpVenue{dummy_field: false};
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::place_buy<T0, SuipumpVenue>(v0, arg0, 0x2::object::id<0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::Curve<T0>>(arg1), 0x2::object::id<0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::Curve<T0>>(arg1), arg2, arg3, arg4, arg4 > price_template<T0>(arg1, 0x2::coin::get_decimals<T0>(arg2)), arg5, arg6, arg7, arg8, arg9);
    }

    public fun place_buy_template_currency<T0>(arg0: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg1: &0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::Curve<T0>, arg2: &0x2::coin_registry::Currency<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u128, arg5: u64, arg6: 0x1::option::Option<address>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::graduated<T0>(arg1), 0);
        let v0 = SuipumpVenue{dummy_field: false};
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::place_buy_currency<T0, SuipumpVenue>(v0, arg0, 0x2::object::id<0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::Curve<T0>>(arg1), 0x2::object::id<0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::Curve<T0>>(arg1), arg2, arg3, arg4, arg4 > price_template<T0>(arg1, 0x2::coin_registry::decimals<T0>(arg2)), arg5, arg6, arg7, arg8, arg9);
    }

    public fun place_sell_template<T0>(arg0: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg1: &0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::Curve<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: 0x2::coin::Coin<T0>, arg4: u128, arg5: u64, arg6: 0x1::option::Option<address>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::graduated<T0>(arg1), 0);
        let v0 = SuipumpVenue{dummy_field: false};
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::place_sell<T0, SuipumpVenue>(v0, arg0, 0x2::object::id<0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::Curve<T0>>(arg1), 0x2::object::id<0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::Curve<T0>>(arg1), arg2, arg3, arg4, arg4 > price_template<T0>(arg1, 0x2::coin::get_decimals<T0>(arg2)), arg5, arg6, arg7, arg8, arg9);
    }

    public fun place_sell_template_currency<T0>(arg0: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg1: &0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::Curve<T0>, arg2: &0x2::coin_registry::Currency<T0>, arg3: 0x2::coin::Coin<T0>, arg4: u128, arg5: u64, arg6: 0x1::option::Option<address>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::graduated<T0>(arg1), 0);
        let v0 = SuipumpVenue{dummy_field: false};
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::place_sell_currency<T0, SuipumpVenue>(v0, arg0, 0x2::object::id<0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::Curve<T0>>(arg1), 0x2::object::id<0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::Curve<T0>>(arg1), arg2, arg3, arg4, arg4 > price_template<T0>(arg1, 0x2::coin_registry::decimals<T0>(arg2)), arg5, arg6, arg7, arg8, arg9);
    }

    fun pool_price(arg0: u128, arg1: u8, arg2: bool) : u128 {
        assert!(arg0 > 0, 3);
        let v0 = (arg0 as u256) * (arg0 as u256);
        let v1 = 1000000000000;
        let v2 = 0;
        while (v2 < arg1) {
            v1 = v1 * 10;
            v2 = v2 + 1;
        };
        let v3 = 340282366920938463463374607431768211456;
        let v4 = if (arg2) {
            v3 / v0 * v1 + v3 % v0 * v1 / v0
        } else {
            (v0 >> 128) * v1 + ((v0 & v3 - 1) * v1 >> 128)
        };
        assert!(v4 <= 340282366920938463444927863358058659840, 4);
        (v4 as u128)
    }

    public fun price<T0>(arg0: &0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>, arg1: u8) : u128 {
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::venue_price(0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::sui_reserve<T0>(arg0) + 4369000000000, 0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::token_reserve<T0>(arg0) + 273000000000000, arg1)
    }

    public fun price_template<T0>(arg0: &0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::Curve<T0>, arg1: u8) : u128 {
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::venue_price(0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::sui_reserve<T0>(arg0) + 4369000000000, 0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::token_reserve<T0>(arg0) + 273000000000000, arg1)
    }

    // decompiled from Move bytecode v7
}

