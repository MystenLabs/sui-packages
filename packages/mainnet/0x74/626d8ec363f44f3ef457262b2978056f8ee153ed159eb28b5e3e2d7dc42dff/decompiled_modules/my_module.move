module 0x74626d8ec363f44f3ef457262b2978056f8ee153ed159eb28b5e3e2d7dc42dff::my_module {
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

