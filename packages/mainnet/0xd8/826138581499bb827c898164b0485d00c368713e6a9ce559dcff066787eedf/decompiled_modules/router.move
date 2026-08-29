module 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::router {
    public fun charge_buy(arg0: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::Config, arg1: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::fees::FeeVault, arg2: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::referral::ReferralRegistry, arg3: 0x2::object::ID, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x1::option::Option<address>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::assert_active(arg0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg4);
        assert!(v0 > 0, 0);
        let v1 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::math::mul_bps(v0, 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::fee_bps(arg0));
        if (v1 == 0) {
            return 0
        };
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::fees::accrue(arg1, arg3, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg4), v1), 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::referral::resolve_and_bind(arg2, 0x2::tx_context::sender(arg7), arg5, arg6));
        v1
    }

    public fun charge_sell(arg0: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::Config, arg1: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::fees::FeeVault, arg2: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::referral::ReferralRegistry, arg3: 0x2::object::ID, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x1::option::Option<address>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        charge_buy(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun deposit_pool_fees<T0>(arg0: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::fees::FeeVault, arg1: 0x2::object::ID, arg2: 0x1::ascii::String, arg3: address, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock) {
        let v0 = 0x2::coin::value<T0>(&arg5);
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::fees::deposit_external(arg0, arg1, arg4, 0x1::option::none<address>());
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg5, arg3);
        } else {
            0x2::coin::destroy_zero<T0>(arg5);
        };
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::events::post_graduation_fees(arg1, arg2, 0x2::balance::value<0x2::sui::SUI>(&arg4), v0, 0x2::clock::timestamp_ms(arg6));
    }

    public fun quote_fee(arg0: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::Config, arg1: u64) : u64 {
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::math::mul_bps(arg1, 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::fee_bps(arg0))
    }

    public fun split_exact(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::split<0x2::sui::SUI>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

