module 0xdae8d3692ee83d84eef0869c061825300dbd217f00c800580741dd9493190725::a {
    struct A has store, key {
        id: 0x2::object::UID,
        content: 0x1::string::String,
        download: bool,
        href: 0x1::string::String,
        rel: 0x1::option::Option<0x1::string::String>,
        title: 0x1::option::Option<0x1::string::String>,
        _type: 0x1::option::Option<0x1::string::String>,
    }

    public fun create(arg0: 0x1::string::String, arg1: bool, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<0x1::string::String>, arg6: &mut 0x2::tx_context::TxContext) : A {
        A{
            id       : 0x2::object::new(arg6),
            content  : arg0,
            download : arg1,
            href     : arg2,
            rel      : arg3,
            title    : arg4,
            _type    : arg5,
        }
    }

    // decompiled from Move bytecode v6
}

