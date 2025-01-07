module 0x51ddcc1e7e7003cfb7790e2778ab0582e29ab3430c8cc89d9678154e94c5c149::mycoin {
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

    public fun check<T0>() {
        let v0 = SomeEvent{
            name         : 0x1::string::utf8(b"sui"),
            type_of_coin : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<SomeEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

