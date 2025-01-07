module 0xd5d71ef0e6a3438fc3b8276ac1ef336e93105fe5328c9755b98d04c8b952469::my_module {
    struct MyObject has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    public fun create(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MyObject{
            id    : 0x2::object::new(arg1),
            value : arg0,
        };
        0x2::transfer::transfer<MyObject>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun update_value(arg0: &mut MyObject, arg1: u64) {
        arg0.value = arg1;
    }

    // decompiled from Move bytecode v6
}

