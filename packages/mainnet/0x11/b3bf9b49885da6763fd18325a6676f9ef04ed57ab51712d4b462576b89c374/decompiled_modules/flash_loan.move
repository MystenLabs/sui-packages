module 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::flash_loan {
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

    public fun borrow_flash_loan(arg0: &0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::version::Version, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD>, 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::reserve::FlashLoan<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD>) {
        assert!(!0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::is_paused(arg1), 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::error::market_paused_error());
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::version::assert_current_version(arg0);
        assert!(arg2 > 0, 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::error::zero_amount_error());
        borrow_flash_loan_internal(arg1, arg2, arg3, arg4)
    }

    fun borrow_flash_loan_internal(arg0: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD>, 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::reserve::FlashLoan<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD>) {
        let v0 = 0x1::type_name::get<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD>();
        assert!(0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::is_base_asset_active(arg0, v0), 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::error::base_asset_not_active_error());
        let (v1, v2) = 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::borrow_flash_loan(arg0, arg1, 0x2::clock::timestamp_ms(arg2) / 1000, arg3);
        let v3 = v2;
        let v4 = BorrowFlashLoanEvent{
            borrower : 0x2::tx_context::sender(arg3),
            asset    : v0,
            amount   : arg1,
            fee      : 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::reserve::flash_loan_fee(&v3),
        };
        0x2::event::emit<BorrowFlashLoanEvent>(v4);
        (v1, v3)
    }

    public fun repay_flash_loan(arg0: &0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::version::Version, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market, arg2: 0x2::coin::Coin<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD>, arg3: 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::reserve::FlashLoan<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD>, arg4: &mut 0x2::tx_context::TxContext) {
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::version::assert_current_version(arg0);
        assert!(!0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::is_paused(arg1), 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::error::market_paused_error());
        assert!(0x2::coin::value<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD>(&arg2) > 0, 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::error::zero_amount_error());
        let v0 = RepayFlashLoanEvent{
            borrower : 0x2::tx_context::sender(arg4),
            asset    : 0x1::type_name::get<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD>(),
            amount   : 0x2::coin::value<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD>(&arg2),
            fee      : 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::reserve::flash_loan_fee(&arg3),
        };
        0x2::event::emit<RepayFlashLoanEvent>(v0);
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::repay_flash_loan(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

