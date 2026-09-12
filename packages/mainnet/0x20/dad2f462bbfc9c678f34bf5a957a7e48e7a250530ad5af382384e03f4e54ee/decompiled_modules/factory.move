module 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::factory {
    public fun create<T0>(arg0: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::Config, arg1: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::registry::Registry, arg2: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::fees::FeeVault, arg3: 0x2::coin::TreasuryCap<T0>, arg4: 0x2::coin::CoinMetadata<T0>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::assert_active(arg0);
        assert!(0x2::coin::total_supply<T0>(&arg3) == 0, 0);
        assert!(0x2::coin::get_decimals<T0>(&arg4) == 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::decimals(arg0), 1);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::total_supply(arg0);
        let v2 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::curve::new<T0>(arg0, v0, 0x2::coin::mint_balance<T0>(&mut arg3, v1), arg9, arg10);
        let v3 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::curve::id<T0>(&v2);
        let v4 = 0x2::coin::get_symbol<T0>(&arg4);
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::registry::register<T0>(arg1, v4, v3);
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::fees::register_curve(arg2, v3, v0);
        let v5 = 0x2::coin::get_icon_url<T0>(&arg4);
        let v6 = if (0x1::option::is_some<0x2::url::Url>(&v5)) {
            let v7 = *0x1::option::borrow<0x2::url::Url>(&v5);
            0x1::string::from_ascii(0x2::url::inner_url(&v7))
        } else {
            0x1::string::utf8(b"")
        };
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::events::token_created(0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::events::new_token_created(v3, 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::curve::coin_type<T0>(&v2), 0x2::coin::get_name<T0>(&arg4), v4, arg5, v6, v0, 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::decimals(arg0), v1, 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::curve_supply(arg0), 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::virtual_sui(arg0), 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::virtual_tokens(arg0), arg6, arg7, arg8, 0x2::clock::timestamp_ms(arg9)));
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::curve::share<T0>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T0>>(arg3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(arg4);
        v3
    }

    public fun create_token<T0>(arg0: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::Config, arg1: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::registry::Registry, arg2: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::fees::FeeVault, arg3: 0x2::coin::TreasuryCap<T0>, arg4: 0x2::coin::CoinMetadata<T0>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        create<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun dev_buy<T0>(arg0: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::curve::Curve<T0>, arg1: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::Config, arg2: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::fees::FeeVault, arg3: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::referral::ReferralRegistry, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::curve::buy<T0>(arg0, arg1, arg2, arg3, arg4, arg5, 0x1::option::none<address>(), arg6, arg7);
        let v2 = v1;
        let v3 = 0x2::tx_context::sender(arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v3);
        if (0x2::coin::value<0x2::sui::SUI>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, v3);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v2);
        };
    }

    public fun dev_buy_into<T0>(arg0: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::curve::Curve<T0>, arg1: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::Config, arg2: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::fees::FeeVault, arg3: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::referral::ReferralRegistry, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::curve::buy<T0>(arg0, arg1, arg2, arg3, arg4, arg5, 0x1::option::none<address>(), arg6, arg7);
        let v2 = v1;
        let v3 = 0x2::tx_context::sender(arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v3);
        if (0x2::coin::value<0x2::sui::SUI>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, v3);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v2);
        };
    }

    public fun icon_url(arg0: vector<u8>) : 0x2::url::Url {
        0x2::url::new_unsafe_from_bytes(arg0)
    }

    public fun is_symbol_available(arg0: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::registry::Registry, arg1: 0x1::ascii::String) : bool {
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::registry::is_symbol_available(arg0, arg1)
    }

    public fun open<T0>(arg0: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::Config, arg1: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::registry::Registry, arg2: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::fees::FeeVault, arg3: 0x2::coin::TreasuryCap<T0>, arg4: 0x2::coin::CoinMetadata<T0>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::curve::Curve<T0> {
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::assert_active(arg0);
        assert!(0x2::coin::total_supply<T0>(&arg3) == 0, 0);
        assert!(0x2::coin::get_decimals<T0>(&arg4) == 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::decimals(arg0), 1);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::total_supply(arg0);
        let v2 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::curve::new<T0>(arg0, v0, 0x2::coin::mint_balance<T0>(&mut arg3, v1), arg9, arg10);
        let v3 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::curve::id<T0>(&v2);
        let v4 = 0x2::coin::get_symbol<T0>(&arg4);
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::registry::register<T0>(arg1, v4, v3);
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::fees::register_curve(arg2, v3, v0);
        let v5 = 0x2::coin::get_icon_url<T0>(&arg4);
        let v6 = if (0x1::option::is_some<0x2::url::Url>(&v5)) {
            let v7 = *0x1::option::borrow<0x2::url::Url>(&v5);
            0x1::string::from_ascii(0x2::url::inner_url(&v7))
        } else {
            0x1::string::utf8(b"")
        };
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::events::token_created(0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::events::new_token_created(v3, 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::curve::coin_type<T0>(&v2), 0x2::coin::get_name<T0>(&arg4), v4, arg5, v6, v0, 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::decimals(arg0), v1, 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::curve_supply(arg0), 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::virtual_sui(arg0), 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::virtual_tokens(arg0), arg6, arg7, arg8, 0x2::clock::timestamp_ms(arg9)));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T0>>(arg3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(arg4);
        v2
    }

    // decompiled from Move bytecode v7
}

