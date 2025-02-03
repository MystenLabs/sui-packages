module 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::flash_loan {
    struct BorrowFlashLoanEvent has copy, drop {
        borrower: address,
        asset: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct RepayFlashLoanEvent has copy, drop {
        borrower: address,
        asset: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun borrow_flash_loan<T0>(arg0: &0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::version::Version, arg1: &mut 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::Market, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::reserve::FlashLoan<T0>) {
        0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::version::assert_current_version(arg0);
        assert!(0x7f57ec0d4321030acd3f97911411ad73ac456d2c56775016348bd159c9c8c163::whitelist::is_address_allowed(0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::uid(arg1), 0x2::tx_context::sender(arg3)), 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::error::whitelist_error());
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::is_base_asset_active(arg1, v0), 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::error::base_asset_not_active_error());
        let v1 = BorrowFlashLoanEvent{
            borrower : 0x2::tx_context::sender(arg3),
            asset    : v0,
            amount   : arg2,
        };
        0x2::event::emit<BorrowFlashLoanEvent>(v1);
        0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::borrow_flash_loan<T0>(arg1, arg2, arg3)
    }

    public fun repay_flash_loan<T0>(arg0: &0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::version::Version, arg1: &mut 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::Market, arg2: 0x2::coin::Coin<T0>, arg3: 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::reserve::FlashLoan<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::version::assert_current_version(arg0);
        let v0 = RepayFlashLoanEvent{
            borrower : 0x2::tx_context::sender(arg4),
            asset    : 0x1::type_name::get<T0>(),
            amount   : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<RepayFlashLoanEvent>(v0);
        0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::repay_flash_loan<T0>(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

