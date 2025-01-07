module 0xa224b61f06b588c68a8c222d0449b918ee2afe8d8fcb05090dda71f1e8da3df::linked_table {
    struct LinkedTable<T0: copy + drop + store, phantom T1: store> has store, key {
        id: 0x2::object::UID,
        head: 0x1::option::Option<T0>,
        tail: 0x1::option::Option<T0>,
        size: u64,
    }

    // decompiled from Move bytecode v6
}

