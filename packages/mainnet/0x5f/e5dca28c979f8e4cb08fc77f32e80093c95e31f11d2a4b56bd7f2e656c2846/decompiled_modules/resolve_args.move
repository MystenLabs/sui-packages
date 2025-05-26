module 0x5fe5dca28c979f8e4cb08fc77f32e80093c95e31f11d2a4b56bd7f2e656c2846::resolve_args {
    struct Foo has key {
        id: 0x2::object::UID,
    }

    public fun foo(arg0: &mut Foo, arg1: vector<Foo>, arg2: vector<u8>, arg3: u64, arg4: u8, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

