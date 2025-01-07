module 0x62285e6bf9ce841f9bf98b7e3a8e4478e02219135cf2bc1ccaf409ec5883f7b6::vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        to_lend: 0x2::balance::Balance<T0>,
        fee_fix: u64,
        fee_bps: u64,
    }

    struct Receipt<phantom T0> {
        vault_id: 0x2::object::ID,
        loan_amount: u64,
        repay_amount: u64,
    }

    struct FlashLoanEvent<phantom T0> has copy, drop {
        loan_amount: u64,
        repay_amount: u64,
        repay_actual: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    public fun new<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : AdminCap {
        assert!(arg2 >= 0 && arg2 < 10000, 5);
        let v0 = 0x2::object::new(arg3);
        let v1 = Vault<T0>{
            id      : v0,
            to_lend : arg0,
            fee_fix : arg1,
            fee_bps : arg2,
        };
        0x2::transfer::share_object<Vault<T0>>(v1);
        AdminCap{
            id       : 0x2::object::new(arg3),
            vault_id : 0x2::object::uid_to_inner(&v0),
        }
    }

    fun check_admin<T0>(arg0: &Vault<T0>, arg1: &AdminCap) {
        assert!(0x2::object::borrow_id<Vault<T0>>(arg0) == &arg1.vault_id, 3);
    }

    public entry fun create<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = new<T0>(0x2::coin::into_balance<T0>(arg0), arg1, arg2, arg3);
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun create_<T0>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = new<T0>(0x2::balance::zero<T0>(), arg0, arg1, arg2);
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun deposit<T0>(arg0: &mut Vault<T0>, arg1: &AdminCap, arg2: 0x2::coin::Coin<T0>) {
        check_admin<T0>(arg0, arg1);
        0x2::coin::put<T0>(&mut arg0.to_lend, arg2);
    }

    public entry fun deposit_<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::put<T0>(&mut arg0.to_lend, arg1);
    }

    public fun fee<T0>(arg0: &Vault<T0>) : (u64, u64) {
        (arg0.fee_fix, arg0.fee_bps)
    }

    public fun limit_tansfer_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
    }

    public fun loan<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Receipt<T0>) {
        let v0 = &mut arg0.to_lend;
        assert!(0x2::balance::value<T0>(v0) >= arg1, 0);
        let v1 = 0x2::coin::take<T0>(v0, arg1, arg2);
        let v2 = Receipt<T0>{
            vault_id     : 0x2::object::id<Vault<T0>>(arg0),
            loan_amount  : arg1,
            repay_amount : arg1 + arg1 / 10000 * arg0.fee_bps + arg0.fee_fix,
        };
        (v1, v2)
    }

    public fun loan_<T0>(arg0: &mut Vault<T0>, arg1: u64) : (0x2::balance::Balance<T0>, Receipt<T0>) {
        let v0 = &mut arg0.to_lend;
        assert!(0x2::balance::value<T0>(v0) >= arg1, 0);
        let v1 = 0x2::balance::split<T0>(v0, arg1);
        let v2 = Receipt<T0>{
            vault_id     : 0x2::object::id<Vault<T0>>(arg0),
            loan_amount  : arg1,
            repay_amount : arg1 + arg1 / 10000 * arg0.fee_bps + arg0.fee_fix,
        };
        (v1, v2)
    }

    public fun loan_amount<T0>(arg0: &Receipt<T0>) : u64 {
        arg0.loan_amount
    }

    public fun max_loan<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.to_lend)
    }

    public fun repay<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: Receipt<T0>) {
        let Receipt {
            vault_id     : v0,
            loan_amount  : v1,
            repay_amount : v2,
        } = arg2;
        assert!(0x2::object::id<Vault<T0>>(arg0) == v0, 2);
        let v3 = 0x2::coin::value<T0>(&arg1);
        assert!(v3 >= v2, 1);
        0x2::coin::put<T0>(&mut arg0.to_lend, arg1);
        let v4 = FlashLoanEvent<T0>{
            loan_amount  : v1,
            repay_amount : v2,
            repay_actual : v3,
        };
        0x2::event::emit<FlashLoanEvent<T0>>(v4);
    }

    public fun repay_<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>, arg2: Receipt<T0>) {
        let Receipt {
            vault_id     : v0,
            loan_amount  : v1,
            repay_amount : v2,
        } = arg2;
        assert!(0x2::object::id<Vault<T0>>(arg0) == v0, 2);
        let v3 = 0x2::balance::value<T0>(&arg1);
        assert!(v3 >= v2, 1);
        0x2::balance::join<T0>(&mut arg0.to_lend, arg1);
        let v4 = FlashLoanEvent<T0>{
            loan_amount  : v1,
            repay_amount : v2,
            repay_actual : v3,
        };
        0x2::event::emit<FlashLoanEvent<T0>>(v4);
    }

    public fun repay_amount<T0>(arg0: &Receipt<T0>) : u64 {
        arg0.repay_amount
    }

    public entry fun sends<T0>(arg0: &mut Vault<T0>, arg1: &AdminCap, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        check_admin<T0>(arg0, arg1);
        let v0 = 0x1::vector::length<address>(&arg2);
        let v1 = 0;
        assert!(0x1::vector::length<u64>(&arg3) == v0, 9);
        let v2 = &mut arg0.to_lend;
        while (v1 < v0) {
            let v3 = 0x1::vector::pop_back<u64>(&mut arg3);
            assert!(0x2::balance::value<T0>(v2) >= v3, 4);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v2, v3, arg4), 0x1::vector::pop_back<address>(&mut arg2));
            v1 = v1 + 1;
        };
    }

    public entry fun update_fee<T0>(arg0: &mut Vault<T0>, arg1: &AdminCap, arg2: u64, arg3: u64) {
        check_admin<T0>(arg0, arg1);
        arg0.fee_fix = arg2;
        arg0.fee_bps = arg3;
    }

    public fun vault_id<T0>(arg0: &Receipt<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_admin<T0>(arg0, arg1);
        let v0 = &mut arg0.to_lend;
        assert!(0x2::balance::value<T0>(v0) >= arg2, 4);
        0x2::coin::take<T0>(v0, arg2, arg3)
    }

    public entry fun ww<T0>(arg0: &mut Vault<T0>, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

