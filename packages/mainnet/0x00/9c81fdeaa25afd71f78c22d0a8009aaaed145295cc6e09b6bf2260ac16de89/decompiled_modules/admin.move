module 0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

