module 0x243c0f2b4c53e57d6109e07d217867262217418c391e8e8b00ed87f613cc56b6::my_module {
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

