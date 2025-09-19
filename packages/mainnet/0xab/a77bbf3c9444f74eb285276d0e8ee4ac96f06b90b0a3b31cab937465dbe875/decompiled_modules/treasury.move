module 0xaba77bbf3c9444f74eb285276d0e8ee4ac96f06b90b0a3b31cab937465dbe875::treasury {
    struct Treasury<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    public fun balance<T0>(arg0: &Treasury<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun create_treasury<T0>(arg0: &0xaba77bbf3c9444f74eb285276d0e8ee4ac96f06b90b0a3b31cab937465dbe875::admin_cap::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Treasury<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::coin::Coin<T0>) {
        deposit_balance<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
    }

    public(friend) fun deposit_balance<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
    }

    public fun withdraw<T0>(arg0: &0xaba77bbf3c9444f74eb285276d0e8ee4ac96f06b90b0a3b31cab937465dbe875::admin_cap::AdminCap, arg1: &mut Treasury<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(withdraw_balance<T0>(arg1, arg2), arg4), arg3);
    }

    public(friend) fun withdraw_balance<T0>(arg0: &mut Treasury<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        if (arg1 <= 0) {
            abort 0
        };
        if (0x2::balance::value<T0>(&arg0.balance) < arg1) {
            abort 1
        };
        0x2::balance::split<T0>(&mut arg0.balance, arg1)
    }

    // decompiled from Move bytecode v6
}

