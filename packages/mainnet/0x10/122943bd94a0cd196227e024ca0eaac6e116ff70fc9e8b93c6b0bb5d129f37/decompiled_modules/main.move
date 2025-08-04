module 0x10122943bd94a0cd196227e024ca0eaac6e116ff70fc9e8b93c6b0bb5d129f37::main {
    struct Deposited has copy, drop {
        receiver: address,
        amount: u64,
        timestamp: u64,
    }

    struct Depositor has key {
        id: 0x2::object::UID,
        deposit_index: 0x2::table::Table<address, u64>,
        deposit_history: 0x2::table::Table<u64, u64>,
        total_deposits: 0x2::table::Table<address, u64>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : (Depositor, AdminCap) {
        let v0 = Depositor{
            id              : 0x2::object::new(arg0),
            deposit_index   : 0x2::table::new<address, u64>(arg0),
            deposit_history : 0x2::table::new<u64, u64>(arg0),
            total_deposits  : 0x2::table::new<address, u64>(arg0),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        (v0, v1)
    }

    public fun deposit_to<T0>(arg0: &mut Depositor, arg1: &mut 0x2::coin::Coin<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(arg1);
        assert!(v0 > 0, 0);
        let v1 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg1, v0, arg3), arg2);
        if (0x2::table::contains<address, u64>(&arg0.deposit_index, v1)) {
            let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg0.deposit_index, v1);
            *v2 = *v2 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.deposit_index, v1, 1);
        };
        0x2::table::add<u64, u64>(&mut arg0.deposit_history, *0x2::table::borrow<address, u64>(&arg0.deposit_index, v1), v0);
        if (0x2::table::contains<address, u64>(&arg0.total_deposits, v1)) {
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.total_deposits, v1);
            *v3 = *v3 + v0;
        } else {
            0x2::table::add<address, u64>(&mut arg0.total_deposits, v1, v0);
        };
        let v4 = Deposited{
            receiver  : arg2,
            amount    : v0,
            timestamp : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<Deposited>(v4);
    }

    public fun get_deposit_by_index(arg0: &Depositor, arg1: u64) : 0x1::option::Option<u64> {
        if (0x2::table::contains<u64, u64>(&arg0.deposit_history, arg1)) {
            0x1::option::some<u64>(*0x2::table::borrow<u64, u64>(&arg0.deposit_history, arg1))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun get_deposit_index(arg0: &Depositor, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.deposit_index, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.deposit_index, arg1)
        } else {
            0
        }
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

