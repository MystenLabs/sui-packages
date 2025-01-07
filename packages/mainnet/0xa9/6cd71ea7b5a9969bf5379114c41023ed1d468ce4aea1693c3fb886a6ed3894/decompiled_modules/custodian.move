module 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::custodian {
    struct Custodian<phantom T0> has store, key {
        id: 0x2::object::UID,
        account_balances: 0x2::table::Table<address, 0x2::balance::Balance<T0>>,
    }

    public(friend) fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) : Custodian<T0> {
        Custodian<T0>{
            id               : 0x2::object::new(arg0),
            account_balances : 0x2::table::new<address, 0x2::balance::Balance<T0>>(arg0),
        }
    }

    public(friend) fun account_balance<T0>(arg0: &Custodian<T0>, arg1: address) : u64 {
        if (!0x2::table::contains<address, 0x2::balance::Balance<T0>>(&arg0.account_balances, arg1)) {
            return 0
        };
        0x2::balance::value<T0>(0x2::table::borrow<address, 0x2::balance::Balance<T0>>(&arg0.account_balances, arg1))
    }

    fun borrow_mut_account_balance<T0>(arg0: &mut Custodian<T0>, arg1: address) : &mut 0x2::balance::Balance<T0> {
        if (!0x2::table::contains<address, 0x2::balance::Balance<T0>>(&arg0.account_balances, arg1)) {
            0x2::table::add<address, 0x2::balance::Balance<T0>>(&mut arg0.account_balances, arg1, 0x2::balance::zero<T0>());
        };
        0x2::table::borrow_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.account_balances, arg1)
    }

    public(friend) fun deposit<T0>(arg0: &mut Custodian<T0>, arg1: 0x2::balance::Balance<T0>, arg2: address) {
        0x2::balance::join<T0>(borrow_mut_account_balance<T0>(arg0, arg2), arg1);
    }

    public(friend) fun withdraw<T0>(arg0: &mut Custodian<T0>, arg1: u64, arg2: address) : 0x2::balance::Balance<T0> {
        let v0 = borrow_mut_account_balance<T0>(arg0, arg2);
        assert!(0x2::balance::value<T0>(v0) >= arg1, 0);
        0x2::balance::split<T0>(v0, arg1)
    }

    // decompiled from Move bytecode v6
}

