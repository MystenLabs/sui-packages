module 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::deposit_collateral {
    struct CollateralDepositEvent has copy, drop {
        provider: address,
        obligation: 0x2::object::ID,
        deposit_asset: 0x1::type_name::TypeName,
        deposit_amount: u64,
    }

    public entry fun deposit_collateral<T0>(arg0: &0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::version::Version, arg1: &mut 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::obligation::Obligation, arg2: &mut 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::version::assert_current_version(arg0);
        assert!(0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::whitelist::is_address_allowed(0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::market::uid(arg2), 0x2::tx_context::sender(arg4)), 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::error::whitelist_error());
        assert!(0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::obligation::deposit_collateral_locked(arg1) == false, 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::error::obligation_locked());
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::market::is_collateral_active(arg2, v0), 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::error::collateral_not_active_error());
        assert!(0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::market::has_risk_model(arg2, v0) == true, 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::error::invalid_collateral_type_error());
        assert!(!0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::obligation::has_coin_x_as_debt(arg1, v0), 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::error::unable_to_deposit_a_borrowed_coin());
        let v1 = CollateralDepositEvent{
            provider       : 0x2::tx_context::sender(arg4),
            obligation     : 0x2::object::id<0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::obligation::Obligation>(arg1),
            deposit_asset  : v0,
            deposit_amount : 0x2::coin::value<T0>(&arg3),
        };
        0x2::event::emit<CollateralDepositEvent>(v1);
        0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::market::handle_add_collateral<T0>(arg2, 0x2::coin::value<T0>(&arg3));
        0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::obligation::deposit_collateral<T0>(arg1, 0x2::coin::into_balance<T0>(arg3));
    }

    // decompiled from Move bytecode v6
}

