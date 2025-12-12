module 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::flash_loan {
    struct BorrowFlashLoanEvent has copy, drop {
        borrower: address,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        fee: u64,
    }

    struct RepayFlashLoanEvent has copy, drop {
        borrower: address,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        fee: u64,
    }

    public fun borrow_flash_loan(arg0: &0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::version::Version, arg1: &mut 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::Market, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::reserve::FlashLoan<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>) {
        assert!(!0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::is_paused(arg1), 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::error::market_paused_error());
        0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::version::assert_current_version(arg0);
        assert!(arg2 > 0, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::error::zero_amount_error());
        borrow_flash_loan_internal(arg1, arg2, arg3, arg4)
    }

    fun borrow_flash_loan_internal(arg0: &mut 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::Market, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::reserve::FlashLoan<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>) {
        let v0 = 0x1::type_name::get<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>();
        assert!(0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::is_base_asset_active(arg0, v0), 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::error::base_asset_not_active_error());
        let (v1, v2) = 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::borrow_flash_loan(arg0, arg1, 0x2::clock::timestamp_ms(arg2) / 1000, arg3);
        let v3 = v2;
        let v4 = BorrowFlashLoanEvent{
            borrower : 0x2::tx_context::sender(arg3),
            asset    : v0,
            amount   : arg1,
            fee      : 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::reserve::flash_loan_fee(&v3),
        };
        0x2::event::emit<BorrowFlashLoanEvent>(v4);
        (v1, v3)
    }

    public fun repay_flash_loan(arg0: &0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::version::Version, arg1: &mut 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::Market, arg2: 0x2::coin::Coin<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>, arg3: 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::reserve::FlashLoan<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>, arg4: &mut 0x2::tx_context::TxContext) {
        0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::version::assert_current_version(arg0);
        assert!(!0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::is_paused(arg1), 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::error::market_paused_error());
        assert!(0x2::coin::value<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>(&arg2) > 0, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::error::zero_amount_error());
        let v0 = RepayFlashLoanEvent{
            borrower : 0x2::tx_context::sender(arg4),
            asset    : 0x1::type_name::get<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>(),
            amount   : 0x2::coin::value<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>(&arg2),
            fee      : 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::reserve::flash_loan_fee(&arg3),
        };
        0x2::event::emit<RepayFlashLoanEvent>(v0);
        0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::repay_flash_loan(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

