module 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault {
    struct CollateralKey has copy, drop, store {
        loan_id: 0x2::object::ID,
    }

    struct LoanInfoKey has copy, drop, store {
        loan_id: 0x2::object::ID,
    }

    struct LoanInfo has copy, drop, store {
        lender: address,
        borrower: address,
        principal: u64,
        rate: u64,
        maturity_time: u64,
        collateral_amount: u64,
    }

    struct CollateralVault<phantom T0> has key {
        id: 0x2::object::UID,
        active_loans: u64,
        total_locked: u64,
    }

    struct CollateralDeposited has copy, drop {
        loan_id: 0x2::object::ID,
        amount: u64,
    }

    struct CollateralWithdrawn has copy, drop {
        loan_id: 0x2::object::ID,
        amount: u64,
    }

    public(friend) fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) : CollateralVault<T0> {
        CollateralVault<T0>{
            id           : 0x2::object::new(arg0),
            active_loans : 0,
            total_locked : 0,
        }
    }

    public fun active_loans<T0>(arg0: &CollateralVault<T0>) : u64 {
        arg0.active_loans
    }

    public(friend) fun deposit<T0>(arg0: &mut CollateralVault<T0>, arg1: 0x2::object::ID, arg2: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        let v1 = CollateralKey{loan_id: arg1};
        0x2::dynamic_field::add<CollateralKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v1, arg2);
        arg0.active_loans = arg0.active_loans + 1;
        arg0.total_locked = arg0.total_locked + v0;
        let v2 = CollateralDeposited{
            loan_id : arg1,
            amount  : v0,
        };
        0x2::event::emit<CollateralDeposited>(v2);
    }

    public fun get_loan_info<T0>(arg0: &CollateralVault<T0>, arg1: 0x2::object::ID) : LoanInfo {
        let v0 = LoanInfoKey{loan_id: arg1};
        assert!(0x2::dynamic_field::exists_<LoanInfoKey>(&arg0.id, v0), 201);
        let v1 = LoanInfoKey{loan_id: arg1};
        *0x2::dynamic_field::borrow<LoanInfoKey, LoanInfo>(&arg0.id, v1)
    }

    public fun has_collateral<T0>(arg0: &CollateralVault<T0>, arg1: 0x2::object::ID) : bool {
        let v0 = CollateralKey{loan_id: arg1};
        0x2::dynamic_field::exists_<CollateralKey>(&arg0.id, v0)
    }

    public fun has_loan_info<T0>(arg0: &CollateralVault<T0>, arg1: 0x2::object::ID) : bool {
        let v0 = LoanInfoKey{loan_id: arg1};
        0x2::dynamic_field::exists_<LoanInfoKey>(&arg0.id, v0)
    }

    public fun loan_info_borrower(arg0: &LoanInfo) : address {
        arg0.borrower
    }

    public fun loan_info_collateral_amount(arg0: &LoanInfo) : u64 {
        arg0.collateral_amount
    }

    public fun loan_info_lender(arg0: &LoanInfo) : address {
        arg0.lender
    }

    public fun loan_info_maturity_time(arg0: &LoanInfo) : u64 {
        arg0.maturity_time
    }

    public fun loan_info_principal(arg0: &LoanInfo) : u64 {
        arg0.principal
    }

    public fun loan_info_rate(arg0: &LoanInfo) : u64 {
        arg0.rate
    }

    public(friend) fun remove_loan_info<T0>(arg0: &mut CollateralVault<T0>, arg1: 0x2::object::ID) {
        let v0 = LoanInfoKey{loan_id: arg1};
        0x2::dynamic_field::remove<LoanInfoKey, LoanInfo>(&mut arg0.id, v0);
    }

    public(friend) fun share<T0>(arg0: CollateralVault<T0>) {
        0x2::transfer::share_object<CollateralVault<T0>>(arg0);
    }

    public(friend) fun store_loan_info<T0>(arg0: &mut CollateralVault<T0>, arg1: 0x2::object::ID, arg2: address, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = LoanInfo{
            lender            : arg2,
            borrower          : arg3,
            principal         : arg4,
            rate              : arg5,
            maturity_time     : arg6,
            collateral_amount : arg7,
        };
        let v1 = LoanInfoKey{loan_id: arg1};
        0x2::dynamic_field::add<LoanInfoKey, LoanInfo>(&mut arg0.id, v1, v0);
    }

    public fun total_locked<T0>(arg0: &CollateralVault<T0>) : u64 {
        arg0.total_locked
    }

    public(friend) fun withdraw<T0>(arg0: &mut CollateralVault<T0>, arg1: 0x2::object::ID) : 0x2::balance::Balance<T0> {
        let v0 = CollateralKey{loan_id: arg1};
        assert!(0x2::dynamic_field::exists_<CollateralKey>(&arg0.id, v0), 200);
        let v1 = CollateralKey{loan_id: arg1};
        let v2 = 0x2::dynamic_field::remove<CollateralKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v1);
        let v3 = 0x2::balance::value<T0>(&v2);
        arg0.active_loans = arg0.active_loans - 1;
        arg0.total_locked = arg0.total_locked - v3;
        let v4 = CollateralWithdrawn{
            loan_id : arg1,
            amount  : v3,
        };
        0x2::event::emit<CollateralWithdrawn>(v4);
        v2
    }

    // decompiled from Move bytecode v6
}

