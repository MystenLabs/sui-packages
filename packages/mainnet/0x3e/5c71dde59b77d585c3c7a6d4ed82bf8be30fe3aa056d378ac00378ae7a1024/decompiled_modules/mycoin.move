module 0x3e5c71dde59b77d585c3c7a6d4ed82bf8be30fe3aa056d378ac00378ae7a1024::mycoin {
    struct MYCOIN has drop {
        dummy_field: bool,
    }

    struct Counter has store, key {
        id: 0x2::object::UID,
        calls: vector<0x1::string::String>,
    }

    struct Admincap has key {
        id: 0x2::object::UID,
    }

    struct Myevent has copy, drop {
        name: 0x1::string::String,
        age: u8,
    }

    struct SomeEvent has copy, drop {
        name: 0x1::string::String,
        type_of_coin: 0x1::type_name::TypeName,
    }

    public fun check<T0>(arg0: u64) {
        let v0 = SomeEvent{
            name         : 0x1::string::utf8(b"sui"),
            type_of_coin : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<SomeEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

