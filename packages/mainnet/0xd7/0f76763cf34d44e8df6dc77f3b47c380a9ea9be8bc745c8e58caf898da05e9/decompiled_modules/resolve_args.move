module 0xd70f76763cf34d44e8df6dc77f3b47c380a9ea9be8bc745c8e58caf898da05e9::resolve_args {
    struct Foo has key {
        id: 0x2::object::UID,
    }

    public fun foo(arg0: &mut Foo, arg1: vector<Foo>, arg2: vector<u8>, arg3: u64, arg4: u8, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

