module 0xd3ebb9a4131f1f8ca3896d9ecaf4d3ddd44fb4de8dfa67a06718e039cdbc48b1::peer_loan {
    struct Admin has store, key {
        id: 0x2::object::UID,
    }

    struct Loan<phantom T0> has key {
        id: 0x2::object::UID,
        borrower: address,
        allowed_lender: address,
        lender: address,
        principal: u64,
        interest: u64,
        repayment_amount: u64,
        maturity_ms: u64,
        repayment: 0x2::balance::Balance<T0>,
    }

    struct LoanCreated has copy, drop {
        loan_id: 0x2::object::ID,
        borrower: address,
        principal: u64,
        interest: u64,
        maturity_ms: u64,
    }

    struct LoanFunded has copy, drop {
        loan_id: 0x2::object::ID,
        lender: address,
    }

    struct AllowedLenderChanged has copy, drop {
        loan_id: 0x2::object::ID,
        previous_lender: address,
        new_lender: address,
    }

    struct LoanRepaid has copy, drop {
        loan_id: 0x2::object::ID,
        amount: u64,
    }

    struct RepaymentClaimed has copy, drop {
        loan_id: 0x2::object::ID,
        lender: address,
        amount: u64,
    }

    public fun allowed_lender<T0>(arg0: &Loan<T0>) : address {
        arg0.allowed_lender
    }

    public fun borrower<T0>(arg0: &Loan<T0>) : address {
        arg0.borrower
    }

    public fun change_allowed_lender<T0>(arg0: &mut Loan<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.borrower, 2);
        assert!(arg1 != @0x0, 0);
        arg0.allowed_lender = arg1;
        let v0 = AllowedLenderChanged{
            loan_id         : 0x2::object::id<Loan<T0>>(arg0),
            previous_lender : arg0.allowed_lender,
            new_lender      : arg1,
        };
        0x2::event::emit<AllowedLenderChanged>(v0);
    }

    public fun claim<T0>(arg0: &mut Loan<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.lender, 3);
        let v1 = arg0.repayment_amount;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.repayment, v1, arg1), v0);
        let v2 = RepaymentClaimed{
            loan_id : 0x2::object::id<Loan<T0>>(arg0),
            lender  : v0,
            amount  : v1,
        };
        0x2::event::emit<RepaymentClaimed>(v2);
    }

    public fun create<T0>(arg0: &Admin, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 0);
        assert!(arg4 != @0x0, 0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = Loan<T0>{
            id               : 0x2::object::new(arg5),
            borrower         : v0,
            allowed_lender   : arg4,
            lender           : @0x0,
            principal        : arg1,
            interest         : arg2,
            repayment_amount : arg1 + arg2,
            maturity_ms      : arg3,
            repayment        : 0x2::balance::zero<T0>(),
        };
        let v2 = LoanCreated{
            loan_id     : 0x2::object::id<Loan<T0>>(&v1),
            borrower    : v0,
            principal   : arg1,
            interest    : arg2,
            maturity_ms : arg3,
        };
        0x2::event::emit<LoanCreated>(v2);
        0x2::transfer::share_object<Loan<T0>>(v1);
    }

    public fun fund<T0>(arg0: &mut Loan<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.allowed_lender, 3);
        arg0.lender = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.borrower);
        let v1 = LoanFunded{
            loan_id : 0x2::object::id<Loan<T0>>(arg0),
            lender  : v0,
        };
        0x2::event::emit<LoanFunded>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Admin>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun interest<T0>(arg0: &Loan<T0>) : u64 {
        arg0.interest
    }

    public fun is_allowed_lender<T0>(arg0: &Loan<T0>, arg1: address) : bool {
        arg0.allowed_lender == arg1
    }

    public fun lender<T0>(arg0: &Loan<T0>) : address {
        arg0.lender
    }

    public fun maturity_ms<T0>(arg0: &Loan<T0>) : u64 {
        arg0.maturity_ms
    }

    public fun principal<T0>(arg0: &Loan<T0>) : u64 {
        arg0.principal
    }

    public fun repay<T0>(arg0: &mut Loan<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.borrower, 2);
        0x2::coin::put<T0>(&mut arg0.repayment, arg1);
        let v0 = LoanRepaid{
            loan_id : 0x2::object::id<Loan<T0>>(arg0),
            amount  : arg0.repayment_amount,
        };
        0x2::event::emit<LoanRepaid>(v0);
    }

    public fun repayment_amount<T0>(arg0: &Loan<T0>) : u64 {
        arg0.repayment_amount
    }

    // decompiled from Move bytecode v7
}

