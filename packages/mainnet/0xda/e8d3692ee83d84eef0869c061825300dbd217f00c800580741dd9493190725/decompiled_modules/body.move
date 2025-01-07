module 0xdae8d3692ee83d84eef0869c061825300dbd217f00c800580741dd9493190725::body {
    struct A has store, key {
        id: 0x2::object::UID,
        content: 0x1::string::String,
        download: bool,
        href: 0x1::string::String,
        rel: 0x1::option::Option<0x1::string::String>,
        title: 0x1::option::Option<0x1::string::String>,
        _type: 0x1::option::Option<0x1::string::String>,
    }

    struct Body has store, key {
        id: 0x2::object::UID,
        children: vector<0x2::object::ID>,
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : Body {
        Body{
            id       : 0x2::object::new(arg0),
            children : 0x1::vector::empty<0x2::object::ID>(),
        }
    }

    // decompiled from Move bytecode v6
}

