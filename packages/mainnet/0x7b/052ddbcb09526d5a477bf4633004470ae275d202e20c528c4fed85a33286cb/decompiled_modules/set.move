module 0x7b052ddbcb09526d5a477bf4633004470ae275d202e20c528c4fed85a33286cb::set {
    struct Set<phantom T0: copy + drop + store> has store {
        inner: 0x2::table::Table<T0, bool>,
        len: u64,
    }

    public(friend) fun length<T0: copy + drop + store>(arg0: &Set<T0>) : u64 {
        arg0.len
    }

    public(friend) fun contains<T0: copy + drop + store>(arg0: &Set<T0>, arg1: T0) : bool {
        0x2::table::contains<T0, bool>(&arg0.inner, arg1)
    }

    public(friend) fun new<T0: copy + drop + store>(arg0: &mut 0x2::tx_context::TxContext) : Set<T0> {
        Set<T0>{
            inner : 0x2::table::new<T0, bool>(arg0),
            len   : 0,
        }
    }

    public(friend) fun remove<T0: copy + drop + store>(arg0: &mut Set<T0>, arg1: T0) : bool {
        if (!0x2::table::contains<T0, bool>(&arg0.inner, arg1)) {
            false
        } else {
            0x2::table::remove<T0, bool>(&mut arg0.inner, arg1);
            arg0.len = arg0.len - 1;
            true
        }
    }

    public(friend) fun insert<T0: copy + drop + store>(arg0: &mut Set<T0>, arg1: T0) : bool {
        if (0x2::table::contains<T0, bool>(&arg0.inner, arg1)) {
            false
        } else {
            0x2::table::add<T0, bool>(&mut arg0.inner, arg1, true);
            arg0.len = arg0.len + 1;
            true
        }
    }

    public(friend) fun is_empty<T0: copy + drop + store>(arg0: &Set<T0>) : bool {
        arg0.len == 0
    }

    // decompiled from Move bytecode v6
}

