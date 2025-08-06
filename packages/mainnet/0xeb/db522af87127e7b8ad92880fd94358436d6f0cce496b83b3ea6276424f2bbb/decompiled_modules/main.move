module 0xebdb522af87127e7b8ad92880fd94358436d6f0cce496b83b3ea6276424f2bbb::main {
    struct Deposited has copy, drop {
        receiver: address,
        amount: u64,
        timestamp: u64,
    }

    struct Depositor has key {
        id: 0x2::object::UID,
        total_deposits: 0x2::table::Table<address, u64>,
    }

    public fun deposit_to<T0>(arg0: &mut Depositor, arg1: &mut 0x2::coin::Coin<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(arg1);
        assert!(v0 > 0, 0);
        let v1 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg1, v0, arg3), arg2);
        if (0x2::table::contains<address, u64>(&arg0.total_deposits, v1)) {
            let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg0.total_deposits, v1);
            *v2 = *v2 + v0;
        } else {
            0x2::table::add<address, u64>(&mut arg0.total_deposits, v1, v0);
        };
        let v3 = Deposited{
            receiver  : arg2,
            amount    : v0,
            timestamp : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<Deposited>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Depositor{
            id             : 0x2::object::new(arg0),
            total_deposits : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<Depositor>(v0);
    }

    // decompiled from Move bytecode v6
}

