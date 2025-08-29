module 0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        time: u64,
    }

    public fun borrow<T0>(arg0: &0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::version::Version, arg1: &mut 0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::obligation::Obligation, arg2: &0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::obligation::ObligationKey, arg3: &mut 0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::market::Market, arg4: &0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::version::assert_current_version(arg0);
        assert!(0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::whitelist::is_address_allowed(0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::market::uid(arg3), 0x2::tx_context::sender(arg8)), 0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::error::whitelist_error());
        assert!(0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::obligation::borrow_locked(arg1) == false, 0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::error::obligation_locked());
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::market::is_base_asset_active(arg3, v0), 0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::error::base_asset_not_active_error());
        let v1 = 0x2::clock::timestamp_ms(arg7) / 1000;
        0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::obligation::assert_key_match(arg1, arg2);
        assert!(arg5 > 0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::interest_model::min_borrow_amount(0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::market::interest_model(arg3, v0)), 0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::error::borrow_too_small_error());
        0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::market::handle_outflow<T0>(arg3, arg5, v1);
        0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::obligation::init_debt(arg1, arg3, v0);
        0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::obligation::accrue_interests_and_rewards(arg1, arg3);
        assert!(arg5 <= 0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::borrow_withdraw_evaluator::max_borrow_amount<T0>(arg1, arg3, arg4, arg6, arg7), 0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::error::borrow_too_much_error());
        0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::obligation::increase_debt(arg1, v0, arg5);
        let v2 = BorrowEvent{
            borrower   : 0x2::tx_context::sender(arg8),
            obligation : 0x2::object::id<0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::obligation::Obligation>(arg1),
            asset      : v0,
            amount     : arg5,
            time       : v1,
        };
        0x2::event::emit<BorrowEvent>(v2);
        0x2::coin::from_balance<T0>(0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::market::handle_borrow<T0>(arg3, arg5, v1), arg8)
    }

    public entry fun borrow_entry<T0>(arg0: &0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::version::Version, arg1: &mut 0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::obligation::Obligation, arg2: &0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::obligation::ObligationKey, arg3: &mut 0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::market::Market, arg4: &0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg8));
    }

    // decompiled from Move bytecode v6
}

