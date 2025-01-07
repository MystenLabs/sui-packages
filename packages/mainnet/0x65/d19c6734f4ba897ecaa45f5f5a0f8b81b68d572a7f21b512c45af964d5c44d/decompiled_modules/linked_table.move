module 0x65d19c6734f4ba897ecaa45f5f5a0f8b81b68d572a7f21b512c45af964d5c44d::linked_table {
    struct LinkedTable<T0: copy + drop + store, phantom T1: store> has store, key {
        id: 0x2::object::UID,
        head: 0x1::option::Option<T0>,
        tail: 0x1::option::Option<T0>,
        size: u64,
    }

    // decompiled from Move bytecode v6
}

