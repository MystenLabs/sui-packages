module 0xcfa02bfdf8e031321b949027401c18caf18909fa7bf021153695863a0bb65ea7::emergency_savings {
    struct EmergencySavings<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        balance: 0x2::balance::Balance<T0>,
    }

    public fun create_fund<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = EmergencySavings<T0>{
            id      : 0x2::object::new(arg0),
            owner   : 0x2::tx_context::sender(arg0),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::transfer<EmergencySavings<T0>>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun deposit<T0>(arg0: &mut EmergencySavings<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun get_balance<T0>(arg0: &EmergencySavings<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_owner<T0>(arg0: &EmergencySavings<T0>) : address {
        arg0.owner
    }

    public fun is_withdrawal_day(arg0: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg0) / 86400000 % 7 == 1
    }

    public fun withdraw<T0>(arg0: &mut EmergencySavings<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        assert!(is_withdrawal_day(arg2), 1);
        assert!(arg1 > 0, 2);
        assert!(arg1 <= 0x2::balance::value<T0>(&arg0.balance), 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

