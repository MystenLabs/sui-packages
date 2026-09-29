module 0x2fb7dae5b7b22c748d17e232301a0dd7187e3dc41d75d2a1a05ba883d1f4f8a6::popularsui_pad {
    struct PopularsuiVenue has drop {
        dummy_field: bool,
    }

    fun check_graduated<T0>(arg0: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::graduation::TokenVault<T0>, arg2: 0x2::object::ID) {
        assert!(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::status<T0>(arg0) == 2, 2);
        assert!(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::graduation::curve_id<T0>(arg1) == 0x2::object::id<0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>>(arg0), 1);
        assert!(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::graduation::pool_id<T0>(arg1) == arg2, 1);
    }

    public fun fill<T0>(arg0: 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueOrder<T0>, arg1: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg2: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>, arg3: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg4: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg5: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::Registry, arg6: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg7: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg8: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::status<T0>(arg2) == 0, 0);
        let v0 = PopularsuiVenue{dummy_field: false};
        let (v1, v2, v3) = 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::begin_fill<T0, PopularsuiVenue>(arg0, arg1, v0, 0x2::object::id<0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>>(arg2), price<T0>(arg2, 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::decimals<T0>(&arg0)), arg6, arg7, arg8, arg9, arg10);
        let (v4, v5) = swap_curve<T0>(arg2, arg3, arg4, arg5, v1, v2, 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_buy<T0>(&arg0), arg9, arg10);
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::settle_fill<T0>(v3, v4, v5, arg6, arg7, arg10);
    }

    public fun fill_auto<T0>(arg0: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::AutomationOrder<T0>, arg1: u64, arg2: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg3: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>, arg4: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg5: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg6: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::Registry, arg7: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg8: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg9: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_approved<PopularsuiVenue>(arg2), 100);
        assert!(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::status<T0>(arg3) == 0, 0);
        let v0 = PopularsuiVenue{dummy_field: false};
        let (v1, v2, v3) = 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::begin_step<T0, PopularsuiVenue>(arg0, v0, 0x2::object::id<0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>>(arg3), price<T0>(arg3, 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::decimals<T0>(arg0)), arg1, arg7, arg8, arg9, arg10, arg11);
        let (v4, v5) = swap_curve<T0>(arg3, arg4, arg5, arg6, v1, v2, 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::is_buy<T0>(arg0), arg10, arg11);
        0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::settle_step<T0>(v3, v4, v5, arg7, arg8, arg11);
    }

    public fun fill_auto_graduated_a<T0>(arg0: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::AutomationOrder<T0>, arg1: u64, arg2: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg3: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>, arg4: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::graduation::TokenVault<T0>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg7: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg8: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg9: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_approved<PopularsuiVenue>(arg2), 100);
        check_graduated<T0>(arg3, arg4, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>>(arg6));
        let v0 = PopularsuiVenue{dummy_field: false};
        let (v1, v2, v3) = 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::begin_step<T0, PopularsuiVenue>(arg0, v0, 0x2::object::id<0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>>(arg3), pool_price(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0x2::sui::SUI, T0>(arg6), 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::decimals<T0>(arg0), true), arg1, arg7, arg8, arg9, arg10, arg11);
        let (v4, v5) = swap_a<T0>(arg5, arg6, v1, v2, 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::is_buy<T0>(arg0), arg10);
        0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::settle_step<T0>(v3, v4, v5, arg7, arg8, arg11);
    }

    public fun fill_auto_graduated_b<T0>(arg0: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::AutomationOrder<T0>, arg1: u64, arg2: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg3: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>, arg4: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::graduation::TokenVault<T0>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg7: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg8: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg9: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_approved<PopularsuiVenue>(arg2), 100);
        check_graduated<T0>(arg3, arg4, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg6));
        let v0 = PopularsuiVenue{dummy_field: false};
        let (v1, v2, v3) = 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::begin_step<T0, PopularsuiVenue>(arg0, v0, 0x2::object::id<0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>>(arg3), pool_price(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0x2::sui::SUI>(arg6), 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::decimals<T0>(arg0), false), arg1, arg7, arg8, arg9, arg10, arg11);
        let (v4, v5) = swap_b<T0>(arg5, arg6, v1, v2, 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::is_buy<T0>(arg0), arg10);
        0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::automation::settle_step<T0>(v3, v4, v5, arg7, arg8, arg11);
    }

    public fun fill_graduated_a<T0>(arg0: 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueOrder<T0>, arg1: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg2: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>, arg3: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::graduation::TokenVault<T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg6: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg7: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg8: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        check_graduated<T0>(arg2, arg3, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>>(arg5));
        let v0 = PopularsuiVenue{dummy_field: false};
        let (v1, v2, v3) = 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::begin_fill<T0, PopularsuiVenue>(arg0, arg1, v0, 0x2::object::id<0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>>(arg2), pool_price(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0x2::sui::SUI, T0>(arg5), 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::decimals<T0>(&arg0), true), arg6, arg7, arg8, arg9, arg10);
        let (v4, v5) = swap_a<T0>(arg4, arg5, v1, v2, 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_buy<T0>(&arg0), arg9);
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::settle_fill<T0>(v3, v4, v5, arg6, arg7, arg10);
    }

    public fun fill_graduated_b<T0>(arg0: 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueOrder<T0>, arg1: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg2: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>, arg3: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::graduation::TokenVault<T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg6: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg7: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg8: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        check_graduated<T0>(arg2, arg3, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg5));
        let v0 = PopularsuiVenue{dummy_field: false};
        let (v1, v2, v3) = 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::begin_fill<T0, PopularsuiVenue>(arg0, arg1, v0, 0x2::object::id<0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>>(arg2), pool_price(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0x2::sui::SUI>(arg5), 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::decimals<T0>(&arg0), false), arg6, arg7, arg8, arg9, arg10);
        let (v4, v5) = swap_b<T0>(arg4, arg5, v1, v2, 0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::is_buy<T0>(&arg0), arg9);
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::settle_fill<T0>(v3, v4, v5, arg6, arg7, arg10);
    }

    public fun place_buy<T0>(arg0: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u128, arg5: u64, arg6: 0x1::option::Option<address>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::status<T0>(arg1) == 0, 0);
        let v0 = PopularsuiVenue{dummy_field: false};
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::place_buy<T0, PopularsuiVenue>(v0, arg0, 0x2::object::id<0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>>(arg1), 0x2::object::id<0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>>(arg1), arg2, arg3, arg4, arg4 > price<T0>(arg1, 0x2::coin::get_decimals<T0>(arg2)), arg5, arg6, arg7, arg8, arg9);
    }

    public fun place_buy_currency<T0>(arg0: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>, arg2: &0x2::coin_registry::Currency<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u128, arg5: u64, arg6: 0x1::option::Option<address>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::status<T0>(arg1) == 0, 0);
        let v0 = PopularsuiVenue{dummy_field: false};
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::place_buy_currency<T0, PopularsuiVenue>(v0, arg0, 0x2::object::id<0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>>(arg1), 0x2::object::id<0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>>(arg1), arg2, arg3, arg4, arg4 > price<T0>(arg1, 0x2::coin_registry::decimals<T0>(arg2)), arg5, arg6, arg7, arg8, arg9);
    }

    public fun place_sell<T0>(arg0: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: 0x2::coin::Coin<T0>, arg4: u128, arg5: u64, arg6: 0x1::option::Option<address>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::status<T0>(arg1) == 0, 0);
        let v0 = PopularsuiVenue{dummy_field: false};
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::place_sell<T0, PopularsuiVenue>(v0, arg0, 0x2::object::id<0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>>(arg1), 0x2::object::id<0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>>(arg1), arg2, arg3, arg4, arg4 > price<T0>(arg1, 0x2::coin::get_decimals<T0>(arg2)), arg5, arg6, arg7, arg8, arg9);
    }

    public fun place_sell_currency<T0>(arg0: &0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::VenueRegistry, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>, arg2: &0x2::coin_registry::Currency<T0>, arg3: 0x2::coin::Coin<T0>, arg4: u128, arg5: u64, arg6: 0x1::option::Option<address>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::status<T0>(arg1) == 0, 0);
        let v0 = PopularsuiVenue{dummy_field: false};
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::place_sell_currency<T0, PopularsuiVenue>(v0, arg0, 0x2::object::id<0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>>(arg1), 0x2::object::id<0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>>(arg1), arg2, arg3, arg4, arg4 > price<T0>(arg1, 0x2::coin_registry::decimals<T0>(arg2)), arg5, arg6, arg7, arg8, arg9);
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

    public fun price<T0>(arg0: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>, arg1: u8) : u128 {
        let (v0, v1) = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::reserves<T0>(arg0);
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::venue_price(v0, v1, arg1)
    }

    fun swap_a<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: 0x2::balance::Balance<T0>, arg4: bool, arg5: &0x2::clock::Clock) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<T0>) {
        if (arg4) {
            let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x2::sui::SUI, T0>(arg0, arg1, true, true, 0x2::balance::value<0x2::sui::SUI>(&arg2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price() + 1, arg5);
            let v3 = v2;
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x2::sui::SUI, T0>(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0x2::sui::SUI, T0>(&v3)), 0x2::balance::zero<T0>(), v3);
            0x2::balance::join<0x2::sui::SUI>(&mut arg2, v0);
            0x2::balance::join<T0>(&mut arg3, v1);
            assert!(0x2::balance::value<T0>(&arg3) > 0, 5);
        } else {
            let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x2::sui::SUI, T0>(arg0, arg1, false, true, 0x2::balance::value<T0>(&arg3), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price() - 1, arg5);
            let v7 = v6;
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x2::sui::SUI, T0>(arg0, arg1, 0x2::balance::zero<0x2::sui::SUI>(), 0x2::balance::split<T0>(&mut arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0x2::sui::SUI, T0>(&v7)), v7);
            0x2::balance::join<0x2::sui::SUI>(&mut arg2, v4);
            0x2::balance::join<T0>(&mut arg3, v5);
            assert!(0x2::balance::value<0x2::sui::SUI>(&arg2) > 0, 5);
        };
        (arg2, arg3)
    }

    fun swap_b<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: 0x2::balance::Balance<T0>, arg4: bool, arg5: &0x2::clock::Clock) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<T0>) {
        if (arg4) {
            let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, false, true, 0x2::balance::value<0x2::sui::SUI>(&arg2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price() - 1, arg5);
            let v3 = v2;
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v3)), v3);
            0x2::balance::join<0x2::sui::SUI>(&mut arg2, v1);
            0x2::balance::join<T0>(&mut arg3, v0);
            assert!(0x2::balance::value<T0>(&arg3) > 0, 5);
        } else {
            let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, true, true, 0x2::balance::value<T0>(&arg3), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price() + 1, arg5);
            let v7 = v6;
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::split<T0>(&mut arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v7)), 0x2::balance::zero<0x2::sui::SUI>(), v7);
            0x2::balance::join<0x2::sui::SUI>(&mut arg2, v5);
            0x2::balance::join<T0>(&mut arg3, v4);
            assert!(0x2::balance::value<0x2::sui::SUI>(&arg2) > 0, 5);
        };
        (arg2, arg3)
    }

    fun swap_curve<T0>(arg0: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Curve<T0>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg3: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::Registry, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: 0x2::balance::Balance<T0>, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<T0>) {
        if (arg6) {
            0x2::balance::destroy_zero<T0>(arg5);
            let v2 = 0x2::coin::from_balance<0x2::sui::SUI>(arg4, arg8);
            let v3 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::buy<T0>(arg0, arg1, arg2, arg3, &mut v2, 0x2::coin::value<0x2::sui::SUI>(&v2), 0, 0x1::option::none<address>(), arg7, arg8);
            assert!(0x2::coin::value<T0>(&v3) > 0, 5);
            (0x2::coin::into_balance<0x2::sui::SUI>(v2), 0x2::coin::into_balance<T0>(v3))
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(arg4);
            let v4 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::sell<T0>(arg0, arg1, arg2, arg3, 0x2::coin::from_balance<T0>(arg5, arg8), 0, 0x1::option::none<address>(), arg7, arg8);
            assert!(0x2::coin::value<0x2::sui::SUI>(&v4) > 0, 5);
            (0x2::coin::into_balance<0x2::sui::SUI>(v4), 0x2::balance::zero<T0>())
        }
    }

    // decompiled from Move bytecode v7
}

