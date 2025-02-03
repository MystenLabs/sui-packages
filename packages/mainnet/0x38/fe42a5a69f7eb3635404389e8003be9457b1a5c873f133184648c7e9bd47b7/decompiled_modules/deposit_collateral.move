module 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::deposit_collateral {
    struct CollateralDepositEvent has copy, drop {
        provider: address,
        obligation: 0x2::object::ID,
        deposit_asset: 0x1::type_name::TypeName,
        deposit_amount: u64,
    }

    public entry fun deposit_collateral<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::assert_current_version(arg0);
        assert!(0x1318fdc90319ec9c24df1456d960a447521b0a658316155895014a6e39b5482f::whitelist::is_address_allowed(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::uid(arg2), 0x2::tx_context::sender(arg4)), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::error::whitelist_error());
        assert!(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::deposit_collateral_locked(arg1) == false, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::error::obligation_locked());
        let v0 = 0x1::type_name::get<T0>();
        assert!(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::is_collateral_active(arg2, v0), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::error::collateral_not_active_error());
        assert!(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::has_risk_model(arg2, v0) == true, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::error::invalid_collateral_type_error());
        assert!(!0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::has_coin_x_as_debt(arg1, v0), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::error::unable_to_deposit_a_borrowed_coin());
        let v1 = CollateralDepositEvent{
            provider       : 0x2::tx_context::sender(arg4),
            obligation     : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg1),
            deposit_asset  : v0,
            deposit_amount : 0x2::coin::value<T0>(&arg3),
        };
        0x2::event::emit<CollateralDepositEvent>(v1);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::handle_add_collateral<T0>(arg2, 0x2::coin::value<T0>(&arg3));
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::deposit_collateral<T0>(arg1, 0x2::coin::into_balance<T0>(arg3));
    }

    // decompiled from Move bytecode v6
}

