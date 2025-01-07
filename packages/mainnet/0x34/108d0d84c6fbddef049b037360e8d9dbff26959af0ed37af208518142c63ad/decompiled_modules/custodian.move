module 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::custodian {
    struct Custodian<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasury_balance: 0x2::balance::Balance<T0>,
        rounds_balance: 0x2::table::Table<u64, 0x2::balance::Balance<T0>>,
        reserve_balance: 0x2::balance::Balance<T0>,
        next_pool_balance: 0x2::balance::Balance<T0>,
    }

    public(friend) fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Custodian<T0>{
            id                : 0x2::object::new(arg0),
            treasury_balance  : 0x2::balance::zero<T0>(),
            rounds_balance    : 0x2::table::new<u64, 0x2::balance::Balance<T0>>(arg0),
            reserve_balance   : 0x2::balance::zero<T0>(),
            next_pool_balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Custodian<T0>>(v0);
    }

    public(friend) fun add_next_pool_balance<T0>(arg0: &mut Custodian<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.next_pool_balance, arg1);
    }

    public(friend) fun add_reserve_balance<T0>(arg0: &mut Custodian<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.reserve_balance, arg1);
    }

    public(friend) fun add_round_balance<T0>(arg0: &mut Custodian<T0>, arg1: u64, arg2: 0x2::balance::Balance<T0>) {
        assert!(0x2::table::contains<u64, 0x2::balance::Balance<T0>>(&arg0.rounds_balance, arg1), 200);
        0x2::balance::join<T0>(0x2::table::borrow_mut<u64, 0x2::balance::Balance<T0>>(&mut arg0.rounds_balance, arg1), arg2);
    }

    public(friend) fun add_treasury_balance<T0>(arg0: &mut Custodian<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.treasury_balance, arg1);
    }

    public fun get_next_pool_value<T0>(arg0: &Custodian<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.next_pool_balance)
    }

    public fun get_reserve_value<T0>(arg0: &Custodian<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.reserve_balance)
    }

    public fun get_treasury_value<T0>(arg0: &Custodian<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.treasury_balance)
    }

    public(friend) fun new_round_balance<T0>(arg0: &mut Custodian<T0>, arg1: u64, arg2: 0x2::balance::Balance<T0>) {
        assert!(!0x2::table::contains<u64, 0x2::balance::Balance<T0>>(&arg0.rounds_balance, arg1), 200);
        0x2::table::add<u64, 0x2::balance::Balance<T0>>(&mut arg0.rounds_balance, arg1, arg2);
    }

    public(friend) fun sub_next_pool_balance<T0>(arg0: &mut Custodian<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T0>(&arg0.next_pool_balance);
        assert!(v0 >= arg1, 202);
        0x2::balance::split<T0>(&mut arg0.next_pool_balance, v0)
    }

    public(friend) fun sub_reserve_balance<T0>(arg0: &mut Custodian<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T0>(&arg0.reserve_balance);
        assert!(v0 >= arg1, 203);
        0x2::balance::split<T0>(&mut arg0.reserve_balance, v0)
    }

    public(friend) fun sub_round_balance<T0>(arg0: &mut Custodian<T0>, arg1: u64, arg2: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::table::contains<u64, 0x2::balance::Balance<T0>>(&arg0.rounds_balance, arg1), 200);
        0x2::balance::split<T0>(0x2::table::borrow_mut<u64, 0x2::balance::Balance<T0>>(&mut arg0.rounds_balance, arg1), arg2)
    }

    public(friend) fun sub_treasury_balance<T0>(arg0: &mut Custodian<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T0>(&arg0.treasury_balance);
        assert!(v0 >= arg1, 201);
        0x2::balance::split<T0>(&mut arg0.treasury_balance, v0)
    }

    // decompiled from Move bytecode v6
}

