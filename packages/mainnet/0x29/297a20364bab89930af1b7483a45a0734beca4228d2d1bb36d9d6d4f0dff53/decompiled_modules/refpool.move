module 0x29297a20364bab89930af1b7483a45a0734beca4228d2d1bb36d9d6d4f0dff53::refpool {
    struct REFPOOL has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RefPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        debt_liquidity: 0x2::balance::Balance<T1>,
        collateral: 0x2::balance::Balance<T0>,
        total_borrowed: u64,
        accrued_fees: u64,
        loans_opened: u64,
        open_loans: u64,
    }

    struct LoanTicket<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        loan_seq: u64,
        principal: u64,
        fee: u64,
        collateral_amount: u64,
        closed: bool,
    }

    public fun collateral_held<T0, T1>(arg0: &RefPool<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.collateral)
    }

    public fun create_pool<T0, T1>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = RefPool<T0, T1>{
            id             : 0x2::object::new(arg1),
            debt_liquidity : 0x2::balance::zero<T1>(),
            collateral     : 0x2::balance::zero<T0>(),
            total_borrowed : 0,
            accrued_fees   : 0,
            loans_opened   : 0,
            open_loans     : 0,
        };
        0x2::transfer::share_object<RefPool<T0, T1>>(v0);
        0x2::object::id<RefPool<T0, T1>>(&v0)
    }

    public fun debt_liquidity<T0, T1>(arg0: &RefPool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.debt_liquidity)
    }

    public fun flat_fee_bps() : u64 {
        50
    }

    fun init(arg0: REFPOOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun open<T0, T1>(arg0: &mut RefPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, LoanTicket<T0, T1>) {
        assert!(arg2 > 0, 1);
        assert!(0x2::balance::value<T1>(&arg0.debt_liquidity) >= arg2, 1);
        0x2::coin::put<T0>(&mut arg0.collateral, arg1);
        arg0.total_borrowed = arg0.total_borrowed + arg2;
        arg0.loans_opened = arg0.loans_opened + 1;
        arg0.open_loans = arg0.open_loans + 1;
        let v0 = LoanTicket<T0, T1>{
            id                : 0x2::object::new(arg3),
            pool_id           : 0x2::object::id<RefPool<T0, T1>>(arg0),
            loan_seq          : arg0.loans_opened,
            principal         : arg2,
            fee               : (((arg2 as u128) * (50 as u128) / (10000 as u128)) as u64),
            collateral_amount : 0x2::coin::value<T0>(&arg1),
            closed            : false,
        };
        (0x2::coin::take<T1>(&mut arg0.debt_liquidity, arg2, arg3), v0)
    }

    public fun open_loans<T0, T1>(arg0: &RefPool<T0, T1>) : u64 {
        arg0.open_loans
    }

    public fun repay_and_close<T0, T1>(arg0: &mut RefPool<T0, T1>, arg1: &mut LoanTicket<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg1.pool_id == 0x2::object::id<RefPool<T0, T1>>(arg0), 3);
        assert!(!arg1.closed, 4);
        let v0 = arg1.principal + arg1.fee;
        assert!(0x2::coin::value<T1>(&arg2) >= v0, 2);
        0x2::coin::put<T1>(&mut arg0.debt_liquidity, 0x2::coin::split<T1>(&mut arg2, v0, arg3));
        arg0.total_borrowed = arg0.total_borrowed - arg1.principal;
        arg0.accrued_fees = arg0.accrued_fees + arg1.fee;
        arg0.open_loans = arg0.open_loans - 1;
        arg1.closed = true;
        arg2
    }

    public fun seed<T0, T1>(arg0: &mut RefPool<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        0x2::coin::put<T1>(&mut arg0.debt_liquidity, arg1);
    }

    public fun ticket_amount_owed<T0, T1>(arg0: &LoanTicket<T0, T1>) : u64 {
        arg0.principal + arg0.fee
    }

    public fun ticket_collateral_amount<T0, T1>(arg0: &LoanTicket<T0, T1>) : u64 {
        arg0.collateral_amount
    }

    public fun ticket_fee<T0, T1>(arg0: &LoanTicket<T0, T1>) : u64 {
        arg0.fee
    }

    public fun ticket_is_closed<T0, T1>(arg0: &LoanTicket<T0, T1>) : bool {
        arg0.closed
    }

    public fun ticket_pool_id<T0, T1>(arg0: &LoanTicket<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun ticket_principal<T0, T1>(arg0: &LoanTicket<T0, T1>) : u64 {
        arg0.principal
    }

    public fun total_borrowed<T0, T1>(arg0: &RefPool<T0, T1>) : u64 {
        arg0.total_borrowed
    }

    public fun withdraw_collateral<T0, T1>(arg0: &mut RefPool<T0, T1>, arg1: LoanTicket<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.pool_id == 0x2::object::id<RefPool<T0, T1>>(arg0), 3);
        assert!(arg1.closed, 5);
        let LoanTicket {
            id                : v0,
            pool_id           : _,
            loan_seq          : _,
            principal         : _,
            fee               : _,
            collateral_amount : v5,
            closed            : _,
        } = arg1;
        0x2::object::delete(v0);
        0x2::coin::take<T0>(&mut arg0.collateral, v5, arg2)
    }

    // decompiled from Move bytecode v7
}

