module 0xc78d750a84999b6dc8d8f835369425281a577496485264fbd370653a3686e116::reflection {
    struct SimpleToken has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SimpleToken{
            id     : 0x2::object::new(arg0),
            name   : 0x1::string::utf8(b"WILLY"),
            symbol : 0x1::string::utf8(b"WONKA"),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SimpleToken>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SimpleToken{
            id     : 0x2::object::new(arg1),
            name   : 0x1::string::utf8(b"WILLY"),
            symbol : 0x1::string::utf8(b"WONKA"),
        };
        0x2::transfer::transfer<SimpleToken>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

