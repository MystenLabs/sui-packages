module 0xa5f96421c2e767b3fe35a0d89265442478c2e6f465bd358703a9e5257e436c6::person {
    struct Person has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        items: vector<0x1::string::String>,
    }

    public entry fun create_person1(arg0: vector<0x1::string::String>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Person{
            id    : 0x2::object::new(arg1),
            name  : 0x1::string::utf8(b"mike"),
            items : arg0,
        };
        0x2::transfer::transfer<Person>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun create_person2(arg0: vector<vector<u8>>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        while (0x1::vector::length<vector<u8>>(&arg0) > 0) {
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(0x1::vector::remove<vector<u8>>(&mut arg0, 0)));
        };
        let v1 = Person{
            id    : 0x2::object::new(arg1),
            name  : 0x1::string::utf8(b"mike"),
            items : v0,
        };
        0x2::transfer::transfer<Person>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

