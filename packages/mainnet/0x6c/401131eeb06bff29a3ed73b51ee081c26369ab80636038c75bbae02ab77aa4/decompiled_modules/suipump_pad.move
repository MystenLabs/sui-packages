module 0x6c401131eeb06bff29a3ed73b51ee081c26369ab80636038c75bbae02ab77aa4::suipump_pad {
    struct SuipumpVenue has drop {
        dummy_field: bool,
    }

    public fun place_buy<T0>(arg0: &0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::VenueRegistry, arg1: &0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u128, arg5: u64, arg6: 0x1::option::Option<address>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::graduated<T0>(arg1), 0);
        let v0 = SuipumpVenue{dummy_field: false};
        0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::place_buy<T0, SuipumpVenue>(v0, arg0, 0x2::object::id<0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>>(arg1), 0x2::object::id<0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>>(arg1), arg2, arg3, arg4, arg4 > price<T0>(arg1, 0x2::coin::get_decimals<T0>(arg2)), arg5, arg6, arg7, arg8, arg9);
    }

    public fun place_sell<T0>(arg0: &0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::VenueRegistry, arg1: &0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: 0x2::coin::Coin<T0>, arg4: u128, arg5: u64, arg6: 0x1::option::Option<address>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::graduated<T0>(arg1), 0);
        let v0 = SuipumpVenue{dummy_field: false};
        0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::place_sell<T0, SuipumpVenue>(v0, arg0, 0x2::object::id<0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>>(arg1), 0x2::object::id<0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>>(arg1), arg2, arg3, arg4, arg4 > price<T0>(arg1, 0x2::coin::get_decimals<T0>(arg2)), arg5, arg6, arg7, arg8, arg9);
    }

    public fun fill<T0>(arg0: 0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::VenueOrder<T0>, arg1: &0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::VenueRegistry, arg2: &mut 0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>, arg3: &0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::PriceConfig, arg4: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::Config, arg5: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::fees::FeeVault, arg6: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::referral::ReferralRegistry, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::graduated<T0>(arg2), 0);
        let v0 = SuipumpVenue{dummy_field: false};
        let (v1, v2, v3) = 0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::begin_fill<T0, SuipumpVenue>(arg0, arg1, v0, 0x2::object::id<0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>>(arg2), 0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::venue_price(0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::sui_reserve<T0>(arg2), 0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::token_reserve<T0>(arg2), 0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::decimals<T0>(&arg0)), arg4, arg5, arg6, arg7, arg8);
        if (0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::is_buy<T0>(&arg0)) {
            0x2::balance::destroy_zero<T0>(v2);
            let (v4, v5) = 0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::buy<T0>(arg2, 0x2::coin::from_balance<0x2::sui::SUI>(v1, arg8), 0, 0x1::option::none<address>(), arg3, arg7, arg8);
            0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::settle_fill<T0>(v3, 0x2::coin::into_balance<0x2::sui::SUI>(v5), 0x2::coin::into_balance<T0>(v4), arg4, arg5, arg8);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
            0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::settle_fill<T0>(v3, 0x2::coin::into_balance<0x2::sui::SUI>(0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::sell<T0>(arg2, 0x2::coin::from_balance<T0>(v2, arg8), 0, 0x1::option::none<address>(), arg8)), 0x2::balance::zero<T0>(), arg4, arg5, arg8);
        };
    }

    public fun graduated<T0>(arg0: &0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>) : bool {
        0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::graduated<T0>(arg0)
    }

    public fun price<T0>(arg0: &0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>, arg1: u8) : u128 {
        0x6a0d86e12f51681d833cd2c41e6dcbf4d439139793a4833adf5a05c0e0687164::venue_orders::venue_price(0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::sui_reserve<T0>(arg0), 0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::token_reserve<T0>(arg0), arg1)
    }

    // decompiled from Move bytecode v7
}

