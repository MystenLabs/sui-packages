module 0x500f69a88f4fe0223dc6d15351d95ffc55578afe1d80426cc2211f78a2f31b6a::a {
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

