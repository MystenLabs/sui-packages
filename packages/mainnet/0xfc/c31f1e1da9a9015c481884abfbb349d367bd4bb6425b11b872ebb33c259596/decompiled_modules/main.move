module 0xfcc31f1e1da9a9015c481884abfbb349d367bd4bb6425b11b872ebb33c259596::main {
    struct Deposited has copy, drop {
        receiver: address,
        amount: u64,
        timestamp: u64,
    }

    struct Depositor has store, key {
        id: 0x2::object::UID,
        total_deposits: 0x2::table::Table<address, u64>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : (Depositor, AdminCap) {
        let v0 = Depositor{
            id             : 0x2::object::new(arg0),
            total_deposits : 0x2::table::new<address, u64>(arg0),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        (v0, v1)
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

    public fun get_total_deposits(arg0: &Depositor, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.total_deposits, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.total_deposits, arg1)
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

