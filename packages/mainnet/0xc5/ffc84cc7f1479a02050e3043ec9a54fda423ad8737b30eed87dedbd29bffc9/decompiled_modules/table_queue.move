module 0xc5ffc84cc7f1479a02050e3043ec9a54fda423ad8737b30eed87dedbd29bffc9::table_queue {
    struct TableQueue<phantom T0: store> has store {
        table: 0x2::table::Table<u64, T0>,
        head: u64,
        tail: u64,
    }

    public fun length<T0: store>(arg0: &TableQueue<T0>) : u64 {
        0x2::table::length<u64, T0>(&arg0.table)
    }

    public fun borrow<T0: store>(arg0: &TableQueue<T0>, arg1: u64) : &T0 {
        assert!(arg1 >= arg0.head && arg1 < arg0.tail, 0);
        assert!(0x2::table::contains<u64, T0>(&arg0.table, arg1), 0);
        0x2::table::borrow<u64, T0>(&arg0.table, arg1)
    }

    public fun push_back<T0: store>(arg0: &mut TableQueue<T0>, arg1: T0) {
        0x2::table::add<u64, T0>(&mut arg0.table, arg0.tail, arg1);
        arg0.tail = arg0.tail + 1;
    }

    public fun borrow_mut<T0: store>(arg0: &mut TableQueue<T0>, arg1: u64) : &mut T0 {
        assert!(arg1 >= arg0.head && arg1 < arg0.tail, 0);
        assert!(0x2::table::contains<u64, T0>(&mut arg0.table, arg1), 0);
        0x2::table::borrow_mut<u64, T0>(&mut arg0.table, arg1)
    }

    public fun destroy_empty<T0: store>(arg0: TableQueue<T0>) : (u64, u64) {
        assert!(length<T0>(&arg0) == 0, 0);
        let TableQueue {
            table : v0,
            head  : v1,
            tail  : v2,
        } = arg0;
        0x2::table::destroy_empty<u64, T0>(v0);
        (v1, v2)
    }

    public fun new<T0: store>(arg0: &mut 0x2::tx_context::TxContext) : TableQueue<T0> {
        TableQueue<T0>{
            table : 0x2::table::new<u64, T0>(arg0),
            head  : 0,
            tail  : 0,
        }
    }

    public fun borrow_front<T0: store>(arg0: &TableQueue<T0>) : &T0 {
        assert!(length<T0>(arg0) > 0, 0);
        0x2::table::borrow<u64, T0>(&arg0.table, arg0.head)
    }

    public fun borrow_front_mut<T0: store>(arg0: &mut TableQueue<T0>) : &mut T0 {
        assert!(length<T0>(arg0) > 0, 0);
        0x2::table::borrow_mut<u64, T0>(&mut arg0.table, arg0.head)
    }

    public fun borrow_tail<T0: store>(arg0: &TableQueue<T0>) : &T0 {
        assert!(length<T0>(arg0) > 0, 0);
        0x2::table::borrow<u64, T0>(&arg0.table, arg0.tail - 1)
    }

    public fun borrow_tail_mut<T0: store>(arg0: &mut TableQueue<T0>) : &mut T0 {
        assert!(length<T0>(arg0) > 0, 0);
        0x2::table::borrow_mut<u64, T0>(&mut arg0.table, arg0.tail - 1)
    }

    public fun head<T0: store>(arg0: &TableQueue<T0>) : u64 {
        arg0.head
    }

    public fun is_empty<T0: store>(arg0: &TableQueue<T0>) : bool {
        length<T0>(arg0) == 0
    }

    public fun pop_from_tail<T0: store>(arg0: &mut TableQueue<T0>) : T0 {
        assert!(length<T0>(arg0) > 0, 0);
        arg0.tail = arg0.tail - 1;
        0x2::table::remove<u64, T0>(&mut arg0.table, arg0.tail - 1)
    }

    public fun tail<T0: store>(arg0: &TableQueue<T0>) : u64 {
        arg0.tail
    }

    // decompiled from Move bytecode v6
}

