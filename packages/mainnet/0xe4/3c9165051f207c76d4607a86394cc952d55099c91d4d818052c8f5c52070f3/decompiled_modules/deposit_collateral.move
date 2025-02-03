module 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::deposit_collateral {
    struct CollateralDepositEvent has copy, drop {
        provider: address,
        obligation: 0x2::object::ID,
        deposit_asset: 0x1::type_name::TypeName,
        deposit_amount: u64,
    }

    public entry fun deposit_collateral<T0>(arg0: &0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::version::Version, arg1: &mut 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::obligation::Obligation, arg2: &mut 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::version::assert_current_version(arg0);
        assert!(0x2da61c07dec5b60272c576ecd96a8f95e067b5e4387dc31b41ab6a12a49086db::whitelist::is_address_allowed(0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::uid(arg2), 0x2::tx_context::sender(arg4)), 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::error::whitelist_error());
        assert!(0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::obligation::deposit_collateral_locked(arg1) == false, 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::error::obligation_locked());
        let v0 = 0x1::type_name::get<T0>();
        assert!(0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::is_collateral_active(arg2, v0), 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::error::collateral_not_active_error());
        assert!(0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::has_risk_model(arg2, v0) == true, 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::error::invalid_collateral_type_error());
        let v1 = CollateralDepositEvent{
            provider       : 0x2::tx_context::sender(arg4),
            obligation     : 0x2::object::id<0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::obligation::Obligation>(arg1),
            deposit_asset  : v0,
            deposit_amount : 0x2::coin::value<T0>(&arg3),
        };
        0x2::event::emit<CollateralDepositEvent>(v1);
        0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::handle_add_collateral<T0>(arg2, 0x2::coin::value<T0>(&arg3));
        0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::obligation::deposit_collateral<T0>(arg1, 0x2::coin::into_balance<T0>(arg3));
    }

    // decompiled from Move bytecode v6
}

