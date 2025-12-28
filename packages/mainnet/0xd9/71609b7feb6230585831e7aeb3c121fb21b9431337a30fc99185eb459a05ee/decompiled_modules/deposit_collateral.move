module 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::deposit_collateral {
    struct CollateralDepositEvent has copy, drop {
        provider: address,
        obligation: 0x2::object::ID,
        deposit_asset: 0x1::type_name::TypeName,
        deposit_amount: u64,
    }

    public entry fun deposit_collateral<T0>(arg0: &0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::version::Version, arg1: &mut 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::Obligation, arg2: &mut 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::version::assert_current_version(arg0);
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::assert_whitelist_access(arg2, arg4);
        assert!(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::deposit_collateral_locked(arg1) == false, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::error::obligation_locked());
        assert!(0x2::coin::value<T0>(&arg3) > 0, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::error::zero_deposit_amount_error());
        let v0 = 0x1::type_name::get<T0>();
        assert!(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::has_risk_model(arg2, v0) == true, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::error::invalid_collateral_type_error());
        assert!(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::is_collateral_active(arg2, v0), 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::error::collateral_not_active_error());
        assert!(!0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::has_coin_x_as_debt(arg1, v0), 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::error::unable_to_deposit_a_borrowed_coin());
        assert!(0x2::coin::value<T0>(&arg3) >= *0x2::dynamic_field::borrow<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market_dynamic_keys::MinCollateralAmountKey, u64>(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::uid(arg2), 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market_dynamic_keys::min_collateral_amount_key(v0)), 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::error::min_collateral_amount_error());
        let v1 = CollateralDepositEvent{
            provider       : 0x2::tx_context::sender(arg4),
            obligation     : 0x2::object::id<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::Obligation>(arg1),
            deposit_asset  : v0,
            deposit_amount : 0x2::coin::value<T0>(&arg3),
        };
        0x2::event::emit<CollateralDepositEvent>(v1);
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::handle_add_collateral<T0>(arg2, 0x2::coin::value<T0>(&arg3));
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::deposit_collateral<T0>(arg1, 0x2::coin::into_balance<T0>(arg3));
    }

    // decompiled from Move bytecode v6
}

