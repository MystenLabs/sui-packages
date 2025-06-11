module 0x3f0aff34decb9ef348656c51c9d97603e130584024f76082080f68a53d8b9d90::bcs_test {
    struct TestStruct has store, key {
        id: 0x2::object::UID,
        a: u64,
        b: vector<u8>,
        c: 0x1::string::String,
        d: 0x1::string::String,
    }

    struct TestEvent has copy, drop {
        binary_data: vector<u8>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TestStruct{
            id : 0x2::object::new(arg0),
            a  : 42,
            b  : 0x1::vector::empty<u8>(),
            c  : 0x1::string::utf8(b"Hello, Move!"),
            d  : 0x1::string::utf8(b"Goodbye, Move!"),
        };
        let v1 = TestEvent{binary_data: serialize_test_struct(&v0)};
        0x2::event::emit<TestEvent>(v1);
        0x2::transfer::public_transfer<TestStruct>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun serialize_test_struct(arg0: &TestStruct) : vector<u8> {
        0x2::bcs::to_bytes<TestStruct>(arg0)
    }

    // decompiled from Move bytecode v6
}

