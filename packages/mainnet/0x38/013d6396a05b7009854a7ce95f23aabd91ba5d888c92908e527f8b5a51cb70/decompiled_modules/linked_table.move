module 0x38013d6396a05b7009854a7ce95f23aabd91ba5d888c92908e527f8b5a51cb70::linked_table {
    struct LinkedTable<T0: copy + drop + store, phantom T1: store> has store, key {
        id: 0x2::object::UID,
        head: 0x1::option::Option<T0>,
        tail: 0x1::option::Option<T0>,
        size: u64,
    }

    // decompiled from Move bytecode v6
}

