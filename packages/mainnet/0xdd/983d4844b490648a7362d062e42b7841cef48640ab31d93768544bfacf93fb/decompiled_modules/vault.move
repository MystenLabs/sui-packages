module 0xdd983d4844b490648a7362d062e42b7841cef48640ab31d93768544bfacf93fb::vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct Receipt<phantom T0> {
        vault_id: 0x2::object::ID,
        loan_amount: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct RepayEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        loan_amount: u64,
        repay_actual: u64,
    }

    public fun balance<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    fun check_admin<T0>(arg0: &Vault<T0>, arg1: &AdminCap) {
        assert!(0x2::object::borrow_id<Vault<T0>>(arg0) == &arg1.vault_id, 10010004);
    }

    public entry fun create<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = create_<T0>(0x2::balance::zero<T0>(), arg0);
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun create_<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = 0x2::object::new(arg1);
        let v1 = Vault<T0>{
            id      : v0,
            balance : arg0,
        };
        0x2::transfer::share_object<Vault<T0>>(v1);
        AdminCap{
            id       : 0x2::object::new(arg1),
            vault_id : 0x2::object::uid_to_inner(&v0),
        }
    }

    public fun event_emit_repay<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = RepayEvent<T0>{
            vault_id     : arg0,
            loan_amount  : arg1,
            repay_actual : arg2,
        };
        0x2::event::emit<RepayEvent<T0>>(v0);
    }

    public fun loan<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Receipt<T0>) {
        let v0 = &mut arg0.balance;
        assert!(0x2::balance::value<T0>(v0) >= arg1, 10010001);
        let v1 = 0x2::coin::take<T0>(v0, arg1, arg2);
        let v2 = Receipt<T0>{
            vault_id    : 0x2::object::id<Vault<T0>>(arg0),
            loan_amount : arg1,
        };
        (v1, v2)
    }

    public fun loan_<T0>(arg0: &mut Vault<T0>, arg1: u64) : (0x2::balance::Balance<T0>, Receipt<T0>) {
        let v0 = &mut arg0.balance;
        assert!(0x2::balance::value<T0>(v0) >= arg1, 10010001);
        let v1 = 0x2::balance::split<T0>(v0, arg1);
        let v2 = Receipt<T0>{
            vault_id    : 0x2::object::id<Vault<T0>>(arg0),
            loan_amount : arg1,
        };
        (v1, v2)
    }

    public fun loan_amount<T0>(arg0: &Receipt<T0>) : u64 {
        arg0.loan_amount
    }

    public fun repay<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: Receipt<T0>) {
        let Receipt {
            vault_id    : v0,
            loan_amount : v1,
        } = arg2;
        assert!(0x2::object::id<Vault<T0>>(arg0) == v0, 10010003);
        let v2 = 0x2::coin::value<T0>(&arg1);
        assert!(v2 >= v1, 10010002);
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
        event_emit_repay<T0>(v0, v1, v2);
    }

    public fun repay0<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
        event_emit_repay<T0>(0x2::object::id<Vault<T0>>(arg0), 0, 0x2::coin::value<T0>(&arg1));
    }

    public fun repay0_<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
        event_emit_repay<T0>(0x2::object::id<Vault<T0>>(arg0), 0, 0x2::balance::value<T0>(&arg1));
    }

    public fun repay_<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>, arg2: Receipt<T0>) {
        let Receipt {
            vault_id    : v0,
            loan_amount : v1,
        } = arg2;
        assert!(0x2::object::id<Vault<T0>>(arg0) == v0, 10010003);
        let v2 = 0x2::balance::value<T0>(&arg1);
        assert!(v2 >= v1, 10010002);
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
        event_emit_repay<T0>(v0, v1, v2);
    }

    public entry fun sends<T0>(arg0: &mut Vault<T0>, arg1: &AdminCap, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        check_admin<T0>(arg0, arg1);
        let v0 = 0;
        let v1 = 0x1::vector::length<address>(&arg2);
        assert!(0x1::vector::length<u64>(&arg3) == v1, 10010007);
        let v2 = &mut arg0.balance;
        while (v0 < v1) {
            let v3 = 0x1::vector::pop_back<u64>(&mut arg3);
            assert!(0x2::balance::value<T0>(v2) >= v3, 10010005);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v2, v3, arg4), 0x1::vector::pop_back<address>(&mut arg2));
            v0 = v0 + 1;
        };
    }

    public fun vault_id<T0>(arg0: &Receipt<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    public entry fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ww<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun ww<T0>(arg0: &mut Vault<T0>, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_admin<T0>(arg0, arg1);
        let v0 = &mut arg0.balance;
        assert!(0x2::balance::value<T0>(v0) >= arg2, 10010005);
        0x2::coin::take<T0>(v0, arg2, arg3)
    }

    public fun ww_<T0>(arg0: &mut Vault<T0>, arg1: &AdminCap, arg2: u64) : 0x2::balance::Balance<T0> {
        check_admin<T0>(arg0, arg1);
        let v0 = &mut arg0.balance;
        assert!(0x2::balance::value<T0>(v0) >= arg2, 10010005);
        0x2::balance::split<T0>(v0, arg2)
    }

    // decompiled from Move bytecode v6
}

