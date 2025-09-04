module 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::queue {
    struct Queue<phantom T0: store> has store, key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<u64, T0>,
        head: u64,
        tail: u64,
    }

    public fun new<T0: store>(arg0: &mut 0x2::tx_context::TxContext) : Queue<T0> {
        Queue<T0>{
            id    : 0x2::object::new(arg0),
            table : 0x2::table::new<u64, T0>(arg0),
            head  : 0,
            tail  : 0,
        }
    }

    public fun dequeue<T0: store>(arg0: &mut Queue<T0>) : T0 {
        assert!(arg0.head < arg0.tail, 0);
        arg0.head = arg0.head + 1;
        if (is_empty<T0>(arg0)) {
            arg0.head = 0;
            arg0.tail = 0;
        };
        0x2::table::remove<u64, T0>(&mut arg0.table, arg0.head)
    }

    public fun enqueue<T0: store>(arg0: &mut Queue<T0>, arg1: T0) {
        0x2::table::add<u64, T0>(&mut arg0.table, arg0.tail, arg1);
        arg0.tail = arg0.tail + 1;
    }

    public fun is_empty<T0: store>(arg0: &Queue<T0>) : bool {
        arg0.head == arg0.tail
    }

    public fun len<T0: store>(arg0: &Queue<T0>) : u64 {
        arg0.tail - arg0.head
    }

    public fun peek<T0: store>(arg0: &Queue<T0>) : &T0 {
        assert!(arg0.head < arg0.tail, 0);
        0x2::table::borrow<u64, T0>(&arg0.table, arg0.head)
    }

    // decompiled from Move bytecode v6
}

