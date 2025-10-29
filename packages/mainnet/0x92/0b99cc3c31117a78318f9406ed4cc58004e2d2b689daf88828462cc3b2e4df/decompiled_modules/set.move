module 0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::set {
    struct Set<phantom T0: copy + drop + store> has store {
        inner: 0x2::table::Table<T0, bool>,
    }

    public(friend) fun length<T0: copy + drop + store>(arg0: &Set<T0>) : u64 {
        0x2::table::length<T0, bool>(&arg0.inner)
    }

    public(friend) fun add<T0: copy + drop + store>(arg0: &mut Set<T0>, arg1: T0) {
        if (!0x2::table::contains<T0, bool>(&arg0.inner, arg1)) {
            0x2::table::add<T0, bool>(&mut arg0.inner, arg1, true);
        };
    }

    public(friend) fun contains<T0: copy + drop + store>(arg0: &Set<T0>, arg1: T0) : bool {
        0x2::table::contains<T0, bool>(&arg0.inner, arg1)
    }

    public(friend) fun new<T0: copy + drop + store>(arg0: &mut 0x2::tx_context::TxContext) : Set<T0> {
        Set<T0>{inner: 0x2::table::new<T0, bool>(arg0)}
    }

    public(friend) fun remove<T0: copy + drop + store>(arg0: &mut Set<T0>, arg1: T0) {
        0x2::table::remove<T0, bool>(&mut arg0.inner, arg1);
    }

    // decompiled from Move bytecode v6
}

