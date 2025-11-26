module 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::flash_loan {
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

    public fun borrow_flash_loan(arg0: &0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::version::Version, arg1: &mut 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::Market, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::reserve::FlashLoan<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>) {
        assert!(!0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::is_paused(arg1), 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::error::market_paused_error());
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::version::assert_current_version(arg0);
        assert!(arg2 > 0, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::error::zero_amount_error());
        borrow_flash_loan_internal(arg1, arg2, arg3, arg4)
    }

    fun borrow_flash_loan_internal(arg0: &mut 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::Market, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::reserve::FlashLoan<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>) {
        let v0 = 0x1::type_name::get<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>();
        assert!(0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::is_base_asset_active(arg0, v0), 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::error::base_asset_not_active_error());
        let (v1, v2) = 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::borrow_flash_loan(arg0, arg1, 0x2::clock::timestamp_ms(arg2) / 1000, arg3);
        let v3 = v2;
        let v4 = BorrowFlashLoanEvent{
            borrower : 0x2::tx_context::sender(arg3),
            asset    : v0,
            amount   : arg1,
            fee      : 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::reserve::flash_loan_fee(&v3),
        };
        0x2::event::emit<BorrowFlashLoanEvent>(v4);
        (v1, v3)
    }

    public fun repay_flash_loan(arg0: &0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::version::Version, arg1: &mut 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::Market, arg2: 0x2::coin::Coin<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>, arg3: 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::reserve::FlashLoan<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>, arg4: &mut 0x2::tx_context::TxContext) {
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::version::assert_current_version(arg0);
        assert!(!0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::is_paused(arg1), 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::error::market_paused_error());
        assert!(0x2::coin::value<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>(&arg2) > 0, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::error::zero_amount_error());
        let v0 = RepayFlashLoanEvent{
            borrower : 0x2::tx_context::sender(arg4),
            asset    : 0x1::type_name::get<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>(),
            amount   : 0x2::coin::value<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>(&arg2),
            fee      : 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::reserve::flash_loan_fee(&arg3),
        };
        0x2::event::emit<RepayFlashLoanEvent>(v0);
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::repay_flash_loan(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

