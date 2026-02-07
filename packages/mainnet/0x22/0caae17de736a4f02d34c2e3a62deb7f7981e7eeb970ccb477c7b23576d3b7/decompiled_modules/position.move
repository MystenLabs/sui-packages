module 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::position {
    struct LoanPosition has store, key {
        id: 0x2::object::UID,
        loan_id: 0x2::object::ID,
        side: u8,
        lender: address,
        borrower: address,
        principal: u64,
        rate: u64,
        duration: u64,
        collateral_amount: u64,
        start_time: u64,
        maturity_time: u64,
        status: u8,
        book_id: 0x2::object::ID,
    }

    struct MatchReceipt {
        book_id: 0x2::object::ID,
        lend_order_id: u64,
        borrow_order_id: u64,
        matched_amount: u64,
        rate: u64,
        duration: u64,
        collateral_required: u64,
        lender: address,
        borrower: address,
    }

    struct LoanCreated has copy, drop {
        position_id: 0x2::object::ID,
        loan_id: 0x2::object::ID,
        side: u8,
        lender: address,
        borrower: address,
        principal: u64,
        rate: u64,
        duration: u64,
        start_time: u64,
        maturity_time: u64,
        book_id: 0x2::object::ID,
    }

    public fun book_id(arg0: &LoanPosition) : 0x2::object::ID {
        arg0.book_id
    }

    public fun borrower(arg0: &LoanPosition) : address {
        arg0.borrower
    }

    public fun collateral_amount(arg0: &LoanPosition) : u64 {
        arg0.collateral_amount
    }

    public fun duration(arg0: &LoanPosition) : u64 {
        arg0.duration
    }

    public fun lender(arg0: &LoanPosition) : address {
        arg0.lender
    }

    public fun loan_id(arg0: &LoanPosition) : 0x2::object::ID {
        arg0.loan_id
    }

    public fun maturity_time(arg0: &LoanPosition) : u64 {
        arg0.maturity_time
    }

    public(friend) fun new_match_receipt(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: address, arg8: address) : MatchReceipt {
        MatchReceipt{
            book_id             : arg0,
            lend_order_id       : arg1,
            borrow_order_id     : arg2,
            matched_amount      : arg3,
            rate                : arg4,
            duration            : arg5,
            collateral_required : arg6,
            lender              : arg7,
            borrower            : arg8,
        }
    }

    public fun principal(arg0: &LoanPosition) : u64 {
        arg0.principal
    }

    public fun rate(arg0: &LoanPosition) : u64 {
        arg0.rate
    }

    public(friend) fun receipt_borrower(arg0: &MatchReceipt) : address {
        arg0.borrower
    }

    public(friend) fun receipt_collateral_required(arg0: &MatchReceipt) : u64 {
        arg0.collateral_required
    }

    public(friend) fun receipt_lend_order_id(arg0: &MatchReceipt) : u64 {
        arg0.lend_order_id
    }

    public(friend) fun receipt_lender(arg0: &MatchReceipt) : address {
        arg0.lender
    }

    public(friend) fun receipt_matched_amount(arg0: &MatchReceipt) : u64 {
        arg0.matched_amount
    }

    public(friend) fun receipt_rate(arg0: &MatchReceipt) : u64 {
        arg0.rate
    }

    public(friend) fun set_status(arg0: &mut LoanPosition, arg1: u8) {
        assert!(arg0.status == 0, 1);
        arg0.status = arg1;
    }

    public(friend) fun settle_receipt(arg0: MatchReceipt, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (LoanPosition, LoanPosition) {
        let MatchReceipt {
            book_id             : v0,
            lend_order_id       : _,
            borrow_order_id     : _,
            matched_amount      : v3,
            rate                : v4,
            duration            : v5,
            collateral_required : v6,
            lender              : v7,
            borrower            : v8,
        } = arg0;
        let v9 = arg1 + v5 * 1000;
        let v10 = 0x2::object::new(arg2);
        let v11 = 0x2::object::uid_to_inner(&v10);
        let v12 = LoanPosition{
            id                : v10,
            loan_id           : v11,
            side              : 0,
            lender            : v7,
            borrower          : v8,
            principal         : v3,
            rate              : v4,
            duration          : v5,
            collateral_amount : v6,
            start_time        : arg1,
            maturity_time     : v9,
            status            : 0,
            book_id           : v0,
        };
        let v13 = LoanPosition{
            id                : 0x2::object::new(arg2),
            loan_id           : v11,
            side              : 1,
            lender            : v7,
            borrower          : v8,
            principal         : v3,
            rate              : v4,
            duration          : v5,
            collateral_amount : v6,
            start_time        : arg1,
            maturity_time     : v9,
            status            : 0,
            book_id           : v0,
        };
        let v14 = LoanCreated{
            position_id   : 0x2::object::id<LoanPosition>(&v12),
            loan_id       : v11,
            side          : 0,
            lender        : v7,
            borrower      : v8,
            principal     : v3,
            rate          : v4,
            duration      : v5,
            start_time    : arg1,
            maturity_time : v9,
            book_id       : v0,
        };
        0x2::event::emit<LoanCreated>(v14);
        let v15 = LoanCreated{
            position_id   : 0x2::object::id<LoanPosition>(&v13),
            loan_id       : v11,
            side          : 1,
            lender        : v7,
            borrower      : v8,
            principal     : v3,
            rate          : v4,
            duration      : v5,
            start_time    : arg1,
            maturity_time : v9,
            book_id       : v0,
        };
        0x2::event::emit<LoanCreated>(v15);
        (v12, v13)
    }

    public fun side(arg0: &LoanPosition) : u8 {
        arg0.side
    }

    public fun start_time(arg0: &LoanPosition) : u64 {
        arg0.start_time
    }

    public fun status(arg0: &LoanPosition) : u8 {
        arg0.status
    }

    // decompiled from Move bytecode v6
}

