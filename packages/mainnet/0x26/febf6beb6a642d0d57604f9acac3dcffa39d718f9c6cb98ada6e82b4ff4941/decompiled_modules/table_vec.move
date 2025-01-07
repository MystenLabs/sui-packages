module 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::table_vec {
    struct TableVec<phantom T0: store> has store {
        contents: 0x2::table::Table<u64, T0>,
    }

    public fun empty<T0: store>(arg0: &mut 0x2::tx_context::TxContext) : TableVec<T0> {
        TableVec<T0>{contents: 0x2::table::new<u64, T0>(arg0)}
    }

    public fun length<T0: store>(arg0: &TableVec<T0>) : u64 {
        0x2::table::length<u64, T0>(&arg0.contents)
    }

    public fun borrow<T0: store>(arg0: &TableVec<T0>, arg1: u64) : &T0 {
        assert!(length<T0>(arg0) > arg1, 0);
        0x2::table::borrow<u64, T0>(&arg0.contents, arg1)
    }

    public fun push_back<T0: store>(arg0: &mut TableVec<T0>, arg1: T0) {
        0x2::table::add<u64, T0>(&mut arg0.contents, length<T0>(arg0), arg1);
    }

    public fun borrow_mut<T0: store>(arg0: &mut TableVec<T0>, arg1: u64) : &mut T0 {
        assert!(length<T0>(arg0) > arg1, 0);
        0x2::table::borrow_mut<u64, T0>(&mut arg0.contents, arg1)
    }

    public fun pop_back<T0: store>(arg0: &mut TableVec<T0>) : T0 {
        let v0 = length<T0>(arg0);
        assert!(v0 > 0, 0);
        0x2::table::remove<u64, T0>(&mut arg0.contents, v0 - 1)
    }

    public fun destroy_empty<T0: store>(arg0: TableVec<T0>) {
        assert!(length<T0>(&arg0) == 0, 1);
        let TableVec { contents: v0 } = arg0;
        0x2::table::destroy_empty<u64, T0>(v0);
    }

    public fun swap<T0: store>(arg0: &mut TableVec<T0>, arg1: u64, arg2: u64) {
        assert!(length<T0>(arg0) > arg1, 0);
        assert!(length<T0>(arg0) > arg2, 0);
        0x2::table::add<u64, T0>(&mut arg0.contents, arg2, 0x2::table::remove<u64, T0>(&mut arg0.contents, arg1));
        0x2::table::add<u64, T0>(&mut arg0.contents, arg1, 0x2::table::remove<u64, T0>(&mut arg0.contents, arg2));
    }

    public fun drop<T0: drop + store>(arg0: TableVec<T0>) {
        let TableVec { contents: v0 } = arg0;
        0x2::table::drop<u64, T0>(v0);
    }

    public fun is_empty<T0: store>(arg0: &TableVec<T0>) : bool {
        length<T0>(arg0) == 0
    }

    public fun singleton<T0: store>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : TableVec<T0> {
        let v0 = empty<T0>(arg1);
        let v1 = &mut v0;
        push_back<T0>(v1, arg0);
        v0
    }

    // decompiled from Move bytecode v6
}

