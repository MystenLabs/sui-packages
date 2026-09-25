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

    public fun price<T0>(arg0: &0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>, arg1: u8) : u128 {
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::venue_price(0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::sui_reserve<T0>(arg0) + 4369000000000, 0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::token_reserve<T0>(arg0) + 273000000000000, arg1)
    }

    public fun price_template<T0>(arg0: &0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::Curve<T0>, arg1: u8) : u128 {
        0xc214db7837d4ac8033361d4e8c5ab5b44d122fc5c39424a4332805aa85de1277::venue_orders::venue_price(0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::sui_reserve<T0>(arg0) + 4369000000000, 0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::token_reserve<T0>(arg0) + 273000000000000, arg1)
    }

    // decompiled from Move bytecode v7
}

