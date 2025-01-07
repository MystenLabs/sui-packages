module 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::custodian {
    struct CustodianKey<phantom T0> has copy, drop, store {
        coin_type: 0x1::string::String,
    }

    struct Custodian<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        treasury_balance: 0x2::balance::Balance<T1>,
        rounds_balance: 0x2::table::Table<u64, 0x2::balance::Balance<T1>>,
    }

    public(friend) fun new<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) : Custodian<T0, T1> {
        Custodian<T0, T1>{
            id               : 0x2::object::new(arg0),
            treasury_balance : 0x2::balance::zero<T1>(),
            rounds_balance   : 0x2::table::new<u64, 0x2::balance::Balance<T1>>(arg0),
        }
    }

    public(friend) fun add_round_balance<T0, T1>(arg0: &mut Custodian<T0, T1>, arg1: u64, arg2: 0x2::balance::Balance<T1>) {
        if (!0x2::table::contains<u64, 0x2::balance::Balance<T1>>(&arg0.rounds_balance, arg1)) {
            0x2::table::add<u64, 0x2::balance::Balance<T1>>(&mut arg0.rounds_balance, arg1, arg2);
        } else {
            0x2::balance::join<T1>(0x2::table::borrow_mut<u64, 0x2::balance::Balance<T1>>(&mut arg0.rounds_balance, arg1), arg2);
        };
    }

    public(friend) fun add_treasury_balance<T0, T1>(arg0: &mut Custodian<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(&mut arg0.treasury_balance, arg1);
    }

    public fun contains_treasury_balance<T0, T1>(arg0: &mut Custodian<T0, T1>, arg1: u64) : bool {
        0x2::table::contains<u64, 0x2::balance::Balance<T1>>(&arg0.rounds_balance, arg1)
    }

    public(friend) fun new_custodian_key<T0, T1>() : CustodianKey<T0> {
        CustodianKey<T0>{coin_type: 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::utils::get_type<T1>()}
    }

    public(friend) fun sub_round_balance<T0, T1>(arg0: &mut Custodian<T0, T1>, arg1: u64, arg2: u64) : 0x2::balance::Balance<T1> {
        assert!(0x2::table::contains<u64, 0x2::balance::Balance<T1>>(&arg0.rounds_balance, arg1), 1);
        0x2::balance::split<T1>(0x2::table::borrow_mut<u64, 0x2::balance::Balance<T1>>(&mut arg0.rounds_balance, arg1), arg2)
    }

    public(friend) fun sub_treasury_balance<T0, T1>(arg0: &mut Custodian<T0, T1>, arg1: u64) : 0x2::balance::Balance<T1> {
        0x2::balance::split<T1>(&mut arg0.treasury_balance, arg1)
    }

    public fun treasury_amount<T0, T1>(arg0: &Custodian<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.treasury_balance)
    }

    // decompiled from Move bytecode v6
}

