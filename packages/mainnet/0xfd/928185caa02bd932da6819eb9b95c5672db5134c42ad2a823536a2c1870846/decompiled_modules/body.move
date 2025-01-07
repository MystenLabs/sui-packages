module 0xfd928185caa02bd932da6819eb9b95c5672db5134c42ad2a823536a2c1870846::body {
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

    public fun add_child<T0: store + key>(arg0: &mut Body, arg1: T0, arg2: u64) {
        0x1::vector::insert<0x2::object::ID>(&mut arg0.children, 0x2::object::id<T0>(&arg1), arg2);
        0x2::transfer::public_transfer<T0>(arg1, 0x2::object::uid_to_address(&arg0.id));
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : Body {
        Body{
            id       : 0x2::object::new(arg0),
            children : 0x1::vector::empty<0x2::object::ID>(),
        }
    }

    public fun swap_child(arg0: &mut Body, arg1: u64, arg2: u64) {
        0x1::vector::swap<0x2::object::ID>(&mut arg0.children, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

