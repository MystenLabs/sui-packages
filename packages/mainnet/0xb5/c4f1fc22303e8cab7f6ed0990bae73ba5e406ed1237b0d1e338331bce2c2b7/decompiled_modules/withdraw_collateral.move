module 0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::withdraw_collateral {
    struct CollateralWithdrawEvent has copy, drop {
        taker: address,
        obligation: 0x2::object::ID,
        withdraw_asset: 0x1::type_name::TypeName,
        withdraw_amount: u64,
    }

    public fun withdraw_collateral<T0>(arg0: &0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::version::Version, arg1: &mut 0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::obligation::Obligation, arg2: &0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::obligation::ObligationKey, arg3: &mut 0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::market::Market, arg4: &0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::version::assert_current_version(arg0);
        assert!(0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::whitelist::is_address_allowed(0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::market::uid(arg3), 0x2::tx_context::sender(arg8)), 0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::error::whitelist_error());
        assert!(0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::obligation::withdraw_collateral_locked(arg1) == false, 0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::error::obligation_locked());
        0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::obligation::assert_key_match(arg1, arg2);
        0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::market::handle_withdraw_collateral<T0>(arg3, arg5, 0x2::clock::timestamp_ms(arg7) / 1000);
        0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::obligation::accrue_interests_and_rewards(arg1, arg3);
        assert!(arg5 <= 0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::borrow_withdraw_evaluator::max_withdraw_amount<T0>(arg1, arg3, arg4, arg6, arg7), 0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::error::withdraw_collateral_too_much_error());
        let v0 = 0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::obligation::withdraw_collateral<T0>(arg1, arg5);
        let v1 = CollateralWithdrawEvent{
            taker           : 0x2::tx_context::sender(arg8),
            obligation      : 0x2::object::id<0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::obligation::Obligation>(arg1),
            withdraw_asset  : 0x1::type_name::get<T0>(),
            withdraw_amount : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<CollateralWithdrawEvent>(v1);
        0x2::coin::from_balance<T0>(v0, arg8)
    }

    public entry fun withdraw_collateral_entry<T0>(arg0: &0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::version::Version, arg1: &mut 0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::obligation::Obligation, arg2: &0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::obligation::ObligationKey, arg3: &mut 0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::market::Market, arg4: &0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_collateral<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg8));
    }

    // decompiled from Move bytecode v6
}

