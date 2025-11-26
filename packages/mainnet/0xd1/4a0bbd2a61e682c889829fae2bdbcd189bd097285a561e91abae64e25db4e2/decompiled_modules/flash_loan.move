module 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::flash_loan {
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

    public fun borrow_flash_loan(arg0: &0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::version::Version, arg1: &mut 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::Market, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD>, 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::reserve::FlashLoan<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD>) {
        assert!(!0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::is_paused(arg1), 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::error::market_paused_error());
        0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::version::assert_current_version(arg0);
        assert!(arg2 > 0, 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::error::zero_amount_error());
        borrow_flash_loan_internal(arg1, arg2, arg3, arg4)
    }

    fun borrow_flash_loan_internal(arg0: &mut 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::Market, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD>, 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::reserve::FlashLoan<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD>) {
        let v0 = 0x1::type_name::get<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD>();
        assert!(0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::is_base_asset_active(arg0, v0), 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::error::base_asset_not_active_error());
        let (v1, v2) = 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::borrow_flash_loan(arg0, arg1, 0x2::clock::timestamp_ms(arg2) / 1000, arg3);
        let v3 = v2;
        let v4 = BorrowFlashLoanEvent{
            borrower : 0x2::tx_context::sender(arg3),
            asset    : v0,
            amount   : arg1,
            fee      : 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::reserve::flash_loan_fee(&v3),
        };
        0x2::event::emit<BorrowFlashLoanEvent>(v4);
        (v1, v3)
    }

    public fun repay_flash_loan(arg0: &0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::version::Version, arg1: &mut 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::Market, arg2: 0x2::coin::Coin<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD>, arg3: 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::reserve::FlashLoan<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD>, arg4: &mut 0x2::tx_context::TxContext) {
        0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::version::assert_current_version(arg0);
        assert!(!0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::is_paused(arg1), 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::error::market_paused_error());
        assert!(0x2::coin::value<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD>(&arg2) > 0, 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::error::zero_amount_error());
        let v0 = RepayFlashLoanEvent{
            borrower : 0x2::tx_context::sender(arg4),
            asset    : 0x1::type_name::get<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD>(),
            amount   : 0x2::coin::value<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD>(&arg2),
            fee      : 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::reserve::flash_loan_fee(&arg3),
        };
        0x2::event::emit<RepayFlashLoanEvent>(v0);
        0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::repay_flash_loan(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

