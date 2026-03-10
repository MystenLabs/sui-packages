module 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::withdraw_collateral {
    struct CollateralWithdrawEvent has copy, drop {
        taker: address,
        obligation: 0x2::object::ID,
        withdraw_asset: 0x1::type_name::TypeName,
        withdraw_amount: u64,
    }

    public fun withdraw_collateral<T0>(arg0: &0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::version::Version, arg1: &mut 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::Obligation, arg2: &0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::ObligationKey, arg3: &mut 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::Market, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0xe2785270b2e6179e68204dd5901a43f9a0e1c566baf656cad705d45a419c4d3a::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::version::assert_current_version(arg0);
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::assert_whitelist_access(arg3, arg8);
        assert!(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::withdraw_collateral_locked(arg1) == false, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::error::obligation_locked());
        assert!(arg5 > 0, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::error::zero_withdrawal_amount_error());
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::assert_key_match(arg1, arg2);
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::handle_withdraw_collateral<T0>(arg3, arg5, 0x2::clock::timestamp_ms(arg7) / 1000);
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::accrue_interests(arg1, arg3);
        assert!(arg5 <= 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::borrow_withdraw_evaluator::max_withdraw_amount<T0>(arg1, arg3, arg4, arg6, arg7), 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::error::withdraw_collateral_too_much_error());
        let v0 = 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::withdraw_collateral<T0>(arg1, arg5);
        let v1 = CollateralWithdrawEvent{
            taker           : 0x2::tx_context::sender(arg8),
            obligation      : 0x2::object::id<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::Obligation>(arg1),
            withdraw_asset  : 0x1::type_name::get<T0>(),
            withdraw_amount : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<CollateralWithdrawEvent>(v1);
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::check_is_collateral_price_fluctuate(arg1, arg3, arg6, arg7);
        0x2::coin::from_balance<T0>(v0, arg8)
    }

    public entry fun withdraw_collateral_entry<T0>(arg0: &0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::version::Version, arg1: &mut 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::Obligation, arg2: &0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::ObligationKey, arg3: &mut 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::Market, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0xe2785270b2e6179e68204dd5901a43f9a0e1c566baf656cad705d45a419c4d3a::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_collateral<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg8));
    }

    // decompiled from Move bytecode v6
}

