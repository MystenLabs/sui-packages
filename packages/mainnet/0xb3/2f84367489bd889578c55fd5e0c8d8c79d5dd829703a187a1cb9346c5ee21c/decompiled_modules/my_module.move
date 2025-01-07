module 0xb32f84367489bd889578c55fd5e0c8d8c79d5dd829703a187a1cb9346c5ee21c::my_module {
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

