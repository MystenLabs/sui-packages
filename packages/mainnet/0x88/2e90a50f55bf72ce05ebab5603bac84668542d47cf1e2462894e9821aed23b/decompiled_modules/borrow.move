module 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        time: u64,
    }

    public fun borrow<T0>(arg0: &0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::version::Version, arg1: &mut 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::obligation::Obligation, arg2: &0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::obligation::ObligationKey, arg3: &mut 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::market::Market, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::version::assert_current_version(arg0);
        assert!(0x1318fdc90319ec9c24df1456d960a447521b0a658316155895014a6e39b5482f::whitelist::is_address_allowed(0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::market::uid(arg3), 0x2::tx_context::sender(arg8)), 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::error::whitelist_error());
        assert!(0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::obligation::borrow_locked(arg1) == false, 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::error::obligation_locked());
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::market::is_base_asset_active(arg3, v0), 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::error::base_asset_not_active_error());
        let v1 = 0x2::clock::timestamp_ms(arg7) / 1000;
        0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::obligation::assert_key_match(arg1, arg2);
        assert!(arg5 > 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::interest_model::min_borrow_amount(0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::market::interest_model(arg3, v0)), 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::error::borrow_too_small_error());
        0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::market::handle_outflow<T0>(arg3, arg5, v1);
        0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::obligation::init_debt(arg1, arg3, v0);
        0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::obligation::accrue_interests_and_rewards(arg1, arg3);
        assert!(arg5 <= 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::borrow_withdraw_evaluator::max_borrow_amount<T0>(arg1, arg3, arg4, arg6, arg7), 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::error::borrow_too_much_error());
        0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::obligation::increase_debt(arg1, v0, arg5);
        let v2 = BorrowEvent{
            borrower   : 0x2::tx_context::sender(arg8),
            obligation : 0x2::object::id<0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::obligation::Obligation>(arg1),
            asset      : v0,
            amount     : arg5,
            time       : v1,
        };
        0x2::event::emit<BorrowEvent>(v2);
        0x2::coin::from_balance<T0>(0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::market::handle_borrow<T0>(arg3, arg5, v1), arg8)
    }

    public entry fun borrow_entry<T0>(arg0: &0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::version::Version, arg1: &mut 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::obligation::Obligation, arg2: &0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::obligation::ObligationKey, arg3: &mut 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::market::Market, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg8));
    }

    // decompiled from Move bytecode v6
}

