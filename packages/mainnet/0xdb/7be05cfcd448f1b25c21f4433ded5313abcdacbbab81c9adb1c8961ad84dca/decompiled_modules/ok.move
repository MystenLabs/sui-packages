module 0xdb7be05cfcd448f1b25c21f4433ded5313abcdacbbab81c9adb1c8961ad84dca::ok {
    struct Check<T0> has store, key {
        id: 0x2::object::UID,
        amountu8: u8,
        amountu64: u64,
    }

    struct Alpha has drop, store {
        dummy_field: bool,
    }

    struct Beta has drop, store {
        dummy_field: bool,
    }

    public fun specify<T0: store>(arg0: u8, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Check<T0>{
            id        : 0x2::object::new(arg2),
            amountu8  : arg0,
            amountu64 : arg1,
        };
        0x2::transfer::public_share_object<Check<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

