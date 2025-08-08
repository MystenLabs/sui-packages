module 0xbe6067d5296af6847c28b4333a374acb55eb0701e1d7903fafab93cc985fda5::test {
    struct TestObject has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        value: u64,
    }

    public fun create_test_object(arg0: 0x1::string::String, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = TestObject{
            id    : 0x2::object::new(arg2),
            name  : arg0,
            value : arg1,
        };
        0x2::transfer::public_transfer<TestObject>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun get_value(arg0: &TestObject) : u64 {
        arg0.value
    }

    public fun update_value(arg0: &mut TestObject, arg1: u64) {
        arg0.value = arg1;
    }

    // decompiled from Move bytecode v6
}

