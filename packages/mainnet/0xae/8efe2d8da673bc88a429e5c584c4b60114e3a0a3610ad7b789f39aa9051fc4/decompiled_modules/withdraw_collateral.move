module 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::withdraw_collateral {
    struct CollateralWithdrawEvent has copy, drop {
        taker: address,
        obligation: 0x2::object::ID,
        withdraw_asset: 0x1::type_name::TypeName,
        withdraw_amount: u64,
    }

    public fun withdraw_collateral<T0>(arg0: &0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::version::Version, arg1: &mut 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::Obligation, arg2: &0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::ObligationKey, arg3: &mut 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::Market, arg4: &0x2dc52442a27e2f2b361663c00ab56ce6da272a8f1427a1c15bf77429f8399f0a::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0xa5e8e2f789e62771d342ec92fd6597f8f5b3c68193f1ac46f4c4b12cd8b4a63f::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::is_paused(arg3), 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::error::market_paused_error());
        0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::version::assert_current_version(arg0);
        assert!(arg5 > 0, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::error::zero_amount_error());
        assert!(0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::withdraw_collateral_locked(arg1) == false, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::error::obligation_locked());
        0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::assert_key_match(arg1, arg2);
        0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::handle_withdraw_collateral<T0>(arg3, arg5, 0x2::clock::timestamp_ms(arg7) / 1000);
        0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::accrue_interests_and_rewards(arg1, arg3);
        assert!(arg5 <= 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::borrow_withdraw_evaluator::max_withdraw_amount<T0>(arg1, arg3, arg4, arg6, arg7), 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::error::withdraw_collateral_too_much_error());
        let v0 = 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::withdraw_collateral<T0>(arg1, arg5);
        let v1 = CollateralWithdrawEvent{
            taker           : 0x2::tx_context::sender(arg8),
            obligation      : 0x2::object::id<0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::Obligation>(arg1),
            withdraw_asset  : 0x1::type_name::get<T0>(),
            withdraw_amount : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<CollateralWithdrawEvent>(v1);
        0x2::coin::from_balance<T0>(v0, arg8)
    }

    public fun withdraw_collateral_entry<T0>(arg0: &0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::version::Version, arg1: &mut 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::Obligation, arg2: &0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::ObligationKey, arg3: &mut 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::Market, arg4: &0x2dc52442a27e2f2b361663c00ab56ce6da272a8f1427a1c15bf77429f8399f0a::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0xa5e8e2f789e62771d342ec92fd6597f8f5b3c68193f1ac46f4c4b12cd8b4a63f::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::is_paused(arg3), 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::error::market_paused_error());
        let v0 = withdraw_collateral<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg8));
    }

    // decompiled from Move bytecode v6
}

