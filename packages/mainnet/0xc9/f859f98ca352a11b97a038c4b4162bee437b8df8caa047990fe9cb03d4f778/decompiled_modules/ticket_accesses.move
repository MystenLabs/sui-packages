module 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::ticket_accesses {
    struct TicketForFlashLoanFeeDiscount has drop {
        numerator: u64,
        denominator: u64,
    }

    struct TicketForBorrowingFeeDiscount has drop {
        numerator: u64,
        denominator: u64,
    }

    public fun get_borrowing_fee_discount(arg0: &TicketForBorrowingFeeDiscount) : (u64, u64) {
        (arg0.numerator, arg0.denominator)
    }

    public fun get_flash_loan_fee_discount(arg0: &TicketForFlashLoanFeeDiscount) : (u64, u64) {
        (arg0.numerator, arg0.denominator)
    }

    public fun issue_ticket_for_borrowing_fee_discount<T0: drop>(arg0: &0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::version::Version, arg1: &0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::ticket_issuer_policy::TicketIssuerPolicy, arg2: T0, arg3: u64, arg4: u64) : TicketForBorrowingFeeDiscount {
        0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::version::assert_current_version(arg0);
        assert!(0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::ticket_issuer_policy::is_witness_can_issue_ticket<TicketForBorrowingFeeDiscount, T0>(arg1, &arg2), 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::error::witness_cant_issue_ticket());
        assert!(arg3 <= arg4, 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::error::numerator_cant_be_greater_than_denominator());
        TicketForBorrowingFeeDiscount{
            numerator   : arg3,
            denominator : arg4,
        }
    }

    public fun issue_ticket_for_flash_loan_fee_discount<T0: drop>(arg0: &0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::version::Version, arg1: &0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::ticket_issuer_policy::TicketIssuerPolicy, arg2: T0, arg3: u64, arg4: u64) : TicketForFlashLoanFeeDiscount {
        0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::version::assert_current_version(arg0);
        assert!(0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::ticket_issuer_policy::is_witness_can_issue_ticket<TicketForFlashLoanFeeDiscount, T0>(arg1, &arg2), 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::error::witness_cant_issue_ticket());
        assert!(arg3 <= arg4, 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::error::numerator_cant_be_greater_than_denominator());
        TicketForFlashLoanFeeDiscount{
            numerator   : arg3,
            denominator : arg4,
        }
    }

    // decompiled from Move bytecode v6
}

