module 0x4e0afac3271e843b0a798daa676fff5a9cb1c82c1a17dc082ed54981145dfafb::resolve_args {
    struct Foo has key {
        id: 0x2::object::UID,
    }

    public fun foo(arg0: &mut Foo, arg1: vector<Foo>, arg2: vector<u8>, arg3: u64, arg4: u8, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

