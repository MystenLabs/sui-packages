module 0xf4906d555081515bf23b360dd1a6e8431261d59375a719d56439d2df4af3e86d::generics {
    struct White {
        dummy_field: bool,
    }

    struct Black {
        dummy_field: bool,
    }

    struct Blue {
        dummy_field: bool,
    }

    struct Red {
        dummy_field: bool,
    }

    struct Green {
        dummy_field: bool,
    }

    struct Box<phantom T0, T1: store> has key {
        id: 0x2::object::UID,
        content: T1,
    }

    struct Secret has store {
        value: u64,
    }

    public fun new<T0, T1: store>(arg0: T1, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Box<T0, T1>{
            id      : 0x2::object::new(arg1),
            content : arg0,
        };
        0x2::transfer::transfer<Box<T0, T1>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun new_secret(arg0: u64) : Secret {
        Secret{value: arg0}
    }

    // decompiled from Move bytecode v6
}

