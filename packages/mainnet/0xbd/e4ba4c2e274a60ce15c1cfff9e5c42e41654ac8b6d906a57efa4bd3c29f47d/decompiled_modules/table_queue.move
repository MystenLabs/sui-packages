module 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue {
    struct TableQueue<phantom T0: store> has store {
        head: u64,
        tail: u64,
        contents: 0x2::table::Table<u64, T0>,
    }

    public fun empty<T0: store>(arg0: &mut 0x2::tx_context::TxContext) : TableQueue<T0> {
        TableQueue<T0>{
            head     : 0,
            tail     : 0,
            contents : 0x2::table::new<u64, T0>(arg0),
        }
    }

    public fun length<T0: store>(arg0: &TableQueue<T0>) : u64 {
        0x2::table::length<u64, T0>(&arg0.contents)
    }

    public fun borrow<T0: store>(arg0: &TableQueue<T0>, arg1: u64) : &T0 {
        assert!(length<T0>(arg0) > 0, 0);
        assert!(arg1 >= arg0.head && arg1 < arg0.tail, 0);
        0x2::table::borrow<u64, T0>(&arg0.contents, arg1)
    }

    public fun push_back<T0: store>(arg0: &mut TableQueue<T0>, arg1: T0) {
        arg0.tail = arg0.tail + 1;
        0x2::table::add<u64, T0>(&mut arg0.contents, arg0.tail, arg1);
    }

    public fun borrow_mut<T0: store>(arg0: &mut TableQueue<T0>, arg1: u64) : &mut T0 {
        assert!(length<T0>(arg0) > 0, 0);
        assert!(arg1 >= arg0.head && arg1 < arg0.tail, 0);
        0x2::table::borrow_mut<u64, T0>(&mut arg0.contents, arg1)
    }

    public fun destroy_empty<T0: store>(arg0: TableQueue<T0>) {
        assert!(length<T0>(&arg0) == 0, 1);
        let TableQueue {
            head     : _,
            tail     : _,
            contents : v2,
        } = arg0;
        0x2::table::destroy_empty<u64, T0>(v2);
    }

    public fun borrow_front<T0: store>(arg0: &TableQueue<T0>) : &T0 {
        assert!(length<T0>(arg0) > 0, 0);
        0x2::table::borrow<u64, T0>(&arg0.contents, arg0.head)
    }

    public fun borrow_front_mut<T0: store>(arg0: &mut TableQueue<T0>) : &mut T0 {
        assert!(length<T0>(arg0) > 0, 0);
        0x2::table::borrow_mut<u64, T0>(&mut arg0.contents, arg0.head)
    }

    public fun head<T0: store>(arg0: &TableQueue<T0>) : u64 {
        assert!(length<T0>(arg0) > 0, 0);
        arg0.head
    }

    public fun is_empty<T0: store>(arg0: &TableQueue<T0>) : bool {
        length<T0>(arg0) == 0
    }

    public fun pop_front<T0: store>(arg0: &mut TableQueue<T0>) : T0 {
        assert!(length<T0>(arg0) > 0, 0);
        arg0.head = arg0.head + 1;
        0x2::table::remove<u64, T0>(&mut arg0.contents, arg0.head)
    }

    public fun tail<T0: store>(arg0: &TableQueue<T0>) : u64 {
        assert!(length<T0>(arg0) > 0, 0);
        arg0.tail
    }

    // decompiled from Move bytecode v6
}

