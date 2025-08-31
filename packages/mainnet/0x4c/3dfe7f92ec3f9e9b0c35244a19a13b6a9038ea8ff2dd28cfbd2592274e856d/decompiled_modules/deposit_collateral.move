module 0x4c3dfe7f92ec3f9e9b0c35244a19a13b6a9038ea8ff2dd28cfbd2592274e856d::deposit_collateral {
    struct CollateralDepositEvent has copy, drop {
        provider: address,
        obligation: 0x2::object::ID,
        deposit_asset: 0x1::type_name::TypeName,
        deposit_amount: u64,
    }

    public entry fun deposit_collateral<T0>(arg0: &0x4c3dfe7f92ec3f9e9b0c35244a19a13b6a9038ea8ff2dd28cfbd2592274e856d::version::Version, arg1: &mut 0x4c3dfe7f92ec3f9e9b0c35244a19a13b6a9038ea8ff2dd28cfbd2592274e856d::obligation::Obligation, arg2: &mut 0x4c3dfe7f92ec3f9e9b0c35244a19a13b6a9038ea8ff2dd28cfbd2592274e856d::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x4c3dfe7f92ec3f9e9b0c35244a19a13b6a9038ea8ff2dd28cfbd2592274e856d::version::assert_current_version(arg0);
        assert!(0x4c3dfe7f92ec3f9e9b0c35244a19a13b6a9038ea8ff2dd28cfbd2592274e856d::whitelist::is_address_allowed(0x4c3dfe7f92ec3f9e9b0c35244a19a13b6a9038ea8ff2dd28cfbd2592274e856d::market::uid(arg2), 0x2::tx_context::sender(arg4)), 0x4c3dfe7f92ec3f9e9b0c35244a19a13b6a9038ea8ff2dd28cfbd2592274e856d::error::whitelist_error());
        assert!(0x4c3dfe7f92ec3f9e9b0c35244a19a13b6a9038ea8ff2dd28cfbd2592274e856d::obligation::deposit_collateral_locked(arg1) == false, 0x4c3dfe7f92ec3f9e9b0c35244a19a13b6a9038ea8ff2dd28cfbd2592274e856d::error::obligation_locked());
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x4c3dfe7f92ec3f9e9b0c35244a19a13b6a9038ea8ff2dd28cfbd2592274e856d::market::is_collateral_active(arg2, v0), 0x4c3dfe7f92ec3f9e9b0c35244a19a13b6a9038ea8ff2dd28cfbd2592274e856d::error::collateral_not_active_error());
        assert!(0x4c3dfe7f92ec3f9e9b0c35244a19a13b6a9038ea8ff2dd28cfbd2592274e856d::market::has_risk_model(arg2, v0) == true, 0x4c3dfe7f92ec3f9e9b0c35244a19a13b6a9038ea8ff2dd28cfbd2592274e856d::error::invalid_collateral_type_error());
        let v1 = CollateralDepositEvent{
            provider       : 0x2::tx_context::sender(arg4),
            obligation     : 0x2::object::id<0x4c3dfe7f92ec3f9e9b0c35244a19a13b6a9038ea8ff2dd28cfbd2592274e856d::obligation::Obligation>(arg1),
            deposit_asset  : v0,
            deposit_amount : 0x2::coin::value<T0>(&arg3),
        };
        0x2::event::emit<CollateralDepositEvent>(v1);
        0x4c3dfe7f92ec3f9e9b0c35244a19a13b6a9038ea8ff2dd28cfbd2592274e856d::market::handle_add_collateral<T0>(arg2, 0x2::coin::value<T0>(&arg3));
        0x4c3dfe7f92ec3f9e9b0c35244a19a13b6a9038ea8ff2dd28cfbd2592274e856d::obligation::deposit_collateral<T0>(arg1, 0x2::coin::into_balance<T0>(arg3));
    }

    // decompiled from Move bytecode v6
}

