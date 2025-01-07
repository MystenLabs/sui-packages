module 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::custodian {
    struct Custodian<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        treasury_balance: 0x2::balance::Balance<T1>,
        rounds_balance: 0x2::table::Table<u64, 0x2::balance::Balance<T1>>,
    }

    public(friend) fun new<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Custodian<T0, T1>{
            id               : 0x2::object::new(arg0),
            treasury_balance : 0x2::balance::zero<T1>(),
            rounds_balance   : 0x2::table::new<u64, 0x2::balance::Balance<T1>>(arg0),
        };
        0x2::transfer::share_object<Custodian<T0, T1>>(v0);
    }

    public(friend) fun add_round_balance<T0, T1>(arg0: &mut Custodian<T0, T1>, arg1: u64, arg2: 0x2::balance::Balance<T1>) {
        assert!(0x2::table::contains<u64, 0x2::balance::Balance<T1>>(&arg0.rounds_balance, arg1), 200);
        0x2::balance::join<T1>(0x2::table::borrow_mut<u64, 0x2::balance::Balance<T1>>(&mut arg0.rounds_balance, arg1), arg2);
    }

    public(friend) fun add_treasury_balance<T0, T1>(arg0: &mut Custodian<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(&mut arg0.treasury_balance, arg1);
    }

    public fun get_treasury_value<T0, T1>(arg0: &Custodian<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.treasury_balance)
    }

    public(friend) fun new_round_balance<T0, T1>(arg0: &mut Custodian<T0, T1>, arg1: u64) {
        assert!(!0x2::table::contains<u64, 0x2::balance::Balance<T1>>(&arg0.rounds_balance, arg1), 200);
        0x2::table::add<u64, 0x2::balance::Balance<T1>>(&mut arg0.rounds_balance, arg1, 0x2::balance::zero<T1>());
    }

    public(friend) fun sub_round_balance<T0, T1>(arg0: &mut Custodian<T0, T1>, arg1: u64, arg2: u64) : 0x2::balance::Balance<T1> {
        assert!(0x2::table::contains<u64, 0x2::balance::Balance<T1>>(&arg0.rounds_balance, arg1), 200);
        0x2::balance::split<T1>(0x2::table::borrow_mut<u64, 0x2::balance::Balance<T1>>(&mut arg0.rounds_balance, arg1), arg2)
    }

    public(friend) fun sub_treasury_balance<T0, T1>(arg0: &mut Custodian<T0, T1>, arg1: u64) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T1>(&arg0.treasury_balance);
        assert!(v0 >= arg1, 201);
        0x2::balance::split<T1>(&mut arg0.treasury_balance, v0)
    }

    // decompiled from Move bytecode v6
}

