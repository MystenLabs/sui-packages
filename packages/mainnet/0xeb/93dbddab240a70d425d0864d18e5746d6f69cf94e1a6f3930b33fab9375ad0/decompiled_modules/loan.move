module 0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::loan {
    struct Loan<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        source_id: 0x2::object::ID,
        lender: address,
        borrower: address,
        collateral: 0x2::balance::Balance<T0>,
        principal: u64,
        apr_bps: u64,
        start_ms: u64,
        due_ms: u64,
        grace_ms: u64,
        penalty_x: u64,
        interest_share_bps: u64,
        default_fee_bps: u64,
        fee_recipient: address,
        repaid: 0x2::balance::Balance<T1>,
        status: u8,
    }

    struct Terms has copy, drop {
        apr_bps: u64,
        term_ms: u64,
        grace_ms: u64,
        penalty_x: u64,
        interest_share_bps: u64,
        default_fee_bps: u64,
        fee_recipient: address,
    }

    struct LoanOpened<phantom T0, phantom T1> has copy, drop {
        loan_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
        lender: address,
        borrower: address,
        collateral: u64,
        principal: u64,
        fee: u64,
        apr_bps: u64,
        start_ms: u64,
        due_ms: u64,
        grace_ms: u64,
        penalty_x: u64,
        interest_share_bps: u64,
        default_fee_bps: u64,
    }

    struct LoanRepaid<phantom T0, phantom T1> has copy, drop {
        loan_id: 0x2::object::ID,
        borrower: address,
        principal: u64,
        interest: u64,
        platform_cut: u64,
        late_ms: u64,
        repaid_ms: u64,
    }

    struct RepaymentClaimed<phantom T0, phantom T1> has copy, drop {
        loan_id: 0x2::object::ID,
        lender: address,
        amount: u64,
        claimed_ms: u64,
    }

    struct LoanDefaulted<phantom T0, phantom T1> has copy, drop {
        loan_id: 0x2::object::ID,
        lender: address,
        borrower: address,
        collateral: u64,
        platform_cut: u64,
        principal: u64,
        claimed_ms: u64,
    }

    public fun amount_due<T0, T1>(arg0: &Loan<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        arg0.principal + interest_at(arg0.principal, arg0.apr_bps, arg0.start_ms, arg0.due_ms, arg0.penalty_x, 0x2::clock::timestamp_ms(arg1))
    }

    public fun apr_bps<T0, T1>(arg0: &Loan<T0, T1>) : u64 {
        arg0.apr_bps
    }

    public fun borrower<T0, T1>(arg0: &Loan<T0, T1>) : address {
        arg0.borrower
    }

    public fun claim_default<T0, T1>(arg0: Loan<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.lender, 13900079698320424963);
        release_default<T0, T1>(arg0, arg1, arg2)
    }

    public fun claim_repaid<T0, T1>(arg0: Loan<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::tx_context::sender(arg2) == arg0.lender, 13900079672550621187);
        release_repaid<T0, T1>(arg0, arg1, arg2)
    }

    public fun collateral_amount<T0, T1>(arg0: &Loan<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.collateral)
    }

    public fun default_fee_bps<T0, T1>(arg0: &Loan<T0, T1>) : u64 {
        arg0.default_fee_bps
    }

    fun destroy<T0, T1>(arg0: Loan<T0, T1>) : (address, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let Loan {
            id                 : v0,
            source_id          : _,
            lender             : v2,
            borrower           : _,
            collateral         : v4,
            principal          : _,
            apr_bps            : _,
            start_ms           : _,
            due_ms             : _,
            grace_ms           : _,
            penalty_x          : _,
            interest_share_bps : _,
            default_fee_bps    : _,
            fee_recipient      : _,
            repaid             : v14,
            status             : _,
        } = arg0;
        0x2::object::delete(v0);
        (v2, v4, v14)
    }

    public fun due_ms<T0, T1>(arg0: &Loan<T0, T1>) : u64 {
        arg0.due_ms
    }

    public fun grace_ms<T0, T1>(arg0: &Loan<T0, T1>) : u64 {
        arg0.grace_ms
    }

    public fun interest_at(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = if (arg5 > arg3) {
            arg5 - arg3
        } else {
            0
        };
        let v1 = (10000 as u128) * 31536000000;
        ((((arg0 as u128) * (arg1 as u128) * (((arg3 - arg2) as u128) + (v0 as u128) * (arg4 as u128)) + v1 - 1) / v1) as u64)
    }

    public fun interest_share_bps<T0, T1>(arg0: &Loan<T0, T1>) : u64 {
        arg0.interest_share_bps
    }

    public fun is_defaulted<T0, T1>(arg0: &Loan<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        arg0.status == 0 && 0x2::clock::timestamp_ms(arg1) >= arg0.due_ms + arg0.grace_ms
    }

    public fun is_repaid<T0, T1>(arg0: &Loan<T0, T1>) : bool {
        arg0.status == 1
    }

    public fun lender<T0, T1>(arg0: &Loan<T0, T1>) : address {
        arg0.lender
    }

    public(friend) fun open<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: u64, arg6: Terms, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = Loan<T0, T1>{
            id                 : 0x2::object::new(arg8),
            source_id          : arg0,
            lender             : arg1,
            borrower           : arg2,
            collateral         : arg3,
            principal          : arg4,
            apr_bps            : arg6.apr_bps,
            start_ms           : v0,
            due_ms             : v0 + arg6.term_ms,
            grace_ms           : arg6.grace_ms,
            penalty_x          : arg6.penalty_x,
            interest_share_bps : arg6.interest_share_bps,
            default_fee_bps    : arg6.default_fee_bps,
            fee_recipient      : arg6.fee_recipient,
            repaid             : 0x2::balance::zero<T1>(),
            status             : 0,
        };
        let v2 = 0x2::object::id<Loan<T0, T1>>(&v1);
        let v3 = LoanOpened<T0, T1>{
            loan_id            : v2,
            source_id          : arg0,
            lender             : arg1,
            borrower           : arg2,
            collateral         : 0x2::balance::value<T0>(&v1.collateral),
            principal          : arg4,
            fee                : arg5,
            apr_bps            : arg6.apr_bps,
            start_ms           : v0,
            due_ms             : v1.due_ms,
            grace_ms           : arg6.grace_ms,
            penalty_x          : arg6.penalty_x,
            interest_share_bps : arg6.interest_share_bps,
            default_fee_bps    : arg6.default_fee_bps,
        };
        0x2::event::emit<LoanOpened<T0, T1>>(v3);
        0x2::transfer::share_object<Loan<T0, T1>>(v1);
        v2
    }

    public fun penalty_x<T0, T1>(arg0: &Loan<T0, T1>) : u64 {
        arg0.penalty_x
    }

    public fun platform_cut(arg0: u64, arg1: u64) : u64 {
        0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::math::mul_div(arg0, arg1, 10000)
    }

    public fun principal<T0, T1>(arg0: &Loan<T0, T1>) : u64 {
        arg0.principal
    }

    public(friend) fun release_default<T0, T1>(arg0: Loan<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.status == 0, 13900924200560361481);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.due_ms + arg0.grace_ms, 13900642734173454343);
        let (v1, v2, v3) = destroy<T0, T1>(arg0);
        0x2::balance::destroy_zero<T1>(v3);
        let v4 = 0x2::coin::from_balance<T0>(v2, arg2);
        let v5 = 0x2::coin::value<T0>(&v4);
        let v6 = 0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::math::mul_div(v5, arg0.default_fee_bps, 10000);
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v4, v6, arg2), arg0.fee_recipient);
        };
        let v7 = LoanDefaulted<T0, T1>{
            loan_id      : 0x2::object::id<Loan<T0, T1>>(&arg0),
            lender       : v1,
            borrower     : arg0.borrower,
            collateral   : v5,
            platform_cut : v6,
            principal    : arg0.principal,
            claimed_ms   : v0,
        };
        0x2::event::emit<LoanDefaulted<T0, T1>>(v7);
        v4
    }

    public(friend) fun release_repaid<T0, T1>(arg0: Loan<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg0.status == 1, 13901205628292562955);
        let (v0, v1, v2) = destroy<T0, T1>(arg0);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        let v4 = RepaymentClaimed<T0, T1>{
            loan_id    : 0x2::object::id<Loan<T0, T1>>(&arg0),
            lender     : v0,
            amount     : 0x2::balance::value<T1>(&v3),
            claimed_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<RepaymentClaimed<T0, T1>>(v4);
        0x2::coin::from_balance<T1>(v3, arg2)
    }

    public fun repaid_amount<T0, T1>(arg0: &Loan<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.repaid)
    }

    public fun repay<T0, T1>(arg0: &mut Loan<T0, T1>, arg1: &mut 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.status == 0, 13900924002991865865);
        assert!(0x2::tx_context::sender(arg3) == arg0.borrower, 13899798107379466241);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 < arg0.due_ms + arg0.grace_ms, 13900361065923084293);
        let v1 = interest_at(arg0.principal, arg0.apr_bps, arg0.start_ms, arg0.due_ms, arg0.penalty_x, v0);
        let v2 = arg0.principal + v1;
        assert!(0x2::coin::value<T1>(arg1) >= v2, 13901486978715353101);
        let v3 = 0x2::coin::split<T1>(arg1, v2, arg3);
        let v4 = platform_cut(v1, arg0.interest_share_bps);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v3, v4, arg3), arg0.fee_recipient);
        };
        0x2::balance::join<T1>(&mut arg0.repaid, 0x2::coin::into_balance<T1>(v3));
        arg0.status = 1;
        let v5 = if (v0 > arg0.due_ms) {
            v0 - arg0.due_ms
        } else {
            0
        };
        let v6 = LoanRepaid<T0, T1>{
            loan_id      : 0x2::object::id<Loan<T0, T1>>(arg0),
            borrower     : arg0.borrower,
            principal    : arg0.principal,
            interest     : v1,
            platform_cut : v4,
            late_ms      : v5,
            repaid_ms    : v0,
        };
        0x2::event::emit<LoanRepaid<T0, T1>>(v6);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.collateral), arg3)
    }

    public fun source_id<T0, T1>(arg0: &Loan<T0, T1>) : 0x2::object::ID {
        arg0.source_id
    }

    public fun start_ms<T0, T1>(arg0: &Loan<T0, T1>) : u64 {
        arg0.start_ms
    }

    public(friend) fun terms(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: address) : Terms {
        Terms{
            apr_bps            : arg0,
            term_ms            : arg1,
            grace_ms           : arg2,
            penalty_x          : arg3,
            interest_share_bps : arg4,
            default_fee_bps    : arg5,
            fee_recipient      : arg6,
        }
    }

    // decompiled from Move bytecode v7
}

