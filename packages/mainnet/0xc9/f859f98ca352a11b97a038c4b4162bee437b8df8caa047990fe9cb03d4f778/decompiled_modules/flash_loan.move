module 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::flash_loan {
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

    struct BorrowFlashLoanV2Event has copy, drop {
        borrower: address,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        fee: u64,
        fee_discount_numerator: u64,
        fee_discount_denominator: u64,
    }

    struct RepayFlashLoanV2Event has copy, drop {
        borrower: address,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        fee: u64,
    }

    public fun borrow_flash_loan<T0>(arg0: &0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::version::Version, arg1: &mut 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::market::Market, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::reserve::FlashLoan<T0>) {
        0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::version::assert_current_version(arg0);
        borrow_flash_loan_internal<T0>(arg1, arg2, 0x1::option::none<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::ticket_accesses::TicketForFlashLoanFeeDiscount>(), arg3)
    }

    fun borrow_flash_loan_internal<T0>(arg0: &mut 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::market::Market, arg1: u64, arg2: 0x1::option::Option<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::ticket_accesses::TicketForFlashLoanFeeDiscount>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::reserve::FlashLoan<T0>) {
        assert!(0x1318fdc90319ec9c24df1456d960a447521b0a658316155895014a6e39b5482f::whitelist::is_address_allowed(0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::market::uid(arg0), 0x2::tx_context::sender(arg3)), 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::error::whitelist_error());
        let v0 = 0x1::type_name::get<T0>();
        assert!(0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::market::is_base_asset_active(arg0, v0), 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::error::base_asset_not_active_error());
        let v1 = 1;
        let v2 = 0;
        let (v3, v4) = if (0x1::option::is_some<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::ticket_accesses::TicketForFlashLoanFeeDiscount>(&arg2)) {
            let v5 = 0x1::option::extract<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::ticket_accesses::TicketForFlashLoanFeeDiscount>(&mut arg2);
            let (v6, v7) = 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::ticket_accesses::get_flash_loan_fee_discount(&v5);
            v1 = v7;
            v2 = v6;
            0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::market::borrow_flash_loan_with_ticket<T0>(arg0, v5, arg1, arg3)
        } else {
            0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::market::borrow_flash_loan<T0>(arg0, arg1, arg3)
        };
        let v8 = v4;
        let v9 = BorrowFlashLoanV2Event{
            borrower                 : 0x2::tx_context::sender(arg3),
            asset                    : v0,
            amount                   : arg1,
            fee                      : 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::reserve::flash_loan_fee<T0>(&v8),
            fee_discount_numerator   : v2,
            fee_discount_denominator : v1,
        };
        0x2::event::emit<BorrowFlashLoanV2Event>(v9);
        (v3, v8)
    }

    public fun borrow_flash_loan_with_ticket<T0>(arg0: &0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::version::Version, arg1: &mut 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::market::Market, arg2: u64, arg3: 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::ticket_accesses::TicketForFlashLoanFeeDiscount, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::reserve::FlashLoan<T0>) {
        0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::version::assert_current_version(arg0);
        borrow_flash_loan_internal<T0>(arg1, arg2, 0x1::option::some<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::ticket_accesses::TicketForFlashLoanFeeDiscount>(arg3), arg4)
    }

    public fun repay_flash_loan<T0>(arg0: &0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::version::Version, arg1: &mut 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::market::Market, arg2: 0x2::coin::Coin<T0>, arg3: 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::reserve::FlashLoan<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::version::assert_current_version(arg0);
        let v0 = RepayFlashLoanV2Event{
            borrower : 0x2::tx_context::sender(arg4),
            asset    : 0x1::type_name::get<T0>(),
            amount   : 0x2::coin::value<T0>(&arg2),
            fee      : 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::reserve::flash_loan_fee<T0>(&arg3),
        };
        0x2::event::emit<RepayFlashLoanV2Event>(v0);
        0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::market::repay_flash_loan<T0>(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

