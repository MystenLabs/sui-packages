module 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::deposit_collateral {
    struct CollateralDepositEvent has copy, drop {
        provider: address,
        obligation: 0x2::object::ID,
        deposit_asset: 0x1::type_name::TypeName,
        deposit_amount: u64,
    }

    public entry fun deposit_collateral<T0>(arg0: &0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::version::Version, arg1: &mut 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::obligation::Obligation, arg2: &mut 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::version::assert_current_version(arg0);
        assert!(0x78334396e159bd9a1393da1185dfe34f6ebfa8bd9e68987220a60393586ddcaf::whitelist::is_address_allowed(0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::market::uid(arg2), 0x2::tx_context::sender(arg4)), 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::error::whitelist_error());
        assert!(0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::obligation::deposit_collateral_locked(arg1) == false, 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::error::obligation_locked());
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::market::is_collateral_active(arg2, v0), 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::error::collateral_not_active_error());
        assert!(0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::market::has_risk_model(arg2, v0) == true, 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::error::invalid_collateral_type_error());
        let v1 = CollateralDepositEvent{
            provider       : 0x2::tx_context::sender(arg4),
            obligation     : 0x2::object::id<0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::obligation::Obligation>(arg1),
            deposit_asset  : v0,
            deposit_amount : 0x2::coin::value<T0>(&arg3),
        };
        0x2::event::emit<CollateralDepositEvent>(v1);
        0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::market::handle_add_collateral<T0>(arg2, 0x2::coin::value<T0>(&arg3));
        0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::obligation::deposit_collateral<T0>(arg1, 0x2::coin::into_balance<T0>(arg3));
    }

    // decompiled from Move bytecode v6
}

