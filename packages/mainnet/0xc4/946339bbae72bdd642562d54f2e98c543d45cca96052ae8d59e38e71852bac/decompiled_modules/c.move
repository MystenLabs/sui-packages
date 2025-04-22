module 0xc4946339bbae72bdd642562d54f2e98c543d45cca96052ae8d59e38e71852bac::c {
    struct CP has copy, drop {
        a: u64,
    }

    public fun d<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) : u64 {
        let v0 = 0x2::balance::value<T0>(arg0);
        assert!(v0 >= arg1, 333);
        let v1 = CP{a: v0};
        0x2::event::emit<CP>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

