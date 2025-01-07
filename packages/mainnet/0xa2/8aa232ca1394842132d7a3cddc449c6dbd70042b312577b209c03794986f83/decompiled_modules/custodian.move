module 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::custodian {
    struct Custodian<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasury_balance: 0x2::balance::Balance<T0>,
    }

    public(friend) fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Custodian<T0>{
            id               : 0x2::object::new(arg0),
            treasury_balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::public_share_object<Custodian<T0>>(v0);
    }

    public(friend) fun add_treasury_balance<T0>(arg0: &mut Custodian<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.treasury_balance, arg1);
    }

    public(friend) fun sub_treasury_balance<T0>(arg0: &mut Custodian<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.treasury_balance, arg1)
    }

    public fun treasury_balance<T0>(arg0: &mut Custodian<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.treasury_balance)
    }

    // decompiled from Move bytecode v6
}

