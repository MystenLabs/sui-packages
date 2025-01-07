module 0x3f3fff85a4a55f9556ce1b9a65534b0e36e1011d93efbc7e41a7513c7c1255bb::hero {
    struct Hero has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    public fun new(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : Hero {
        Hero{
            id   : 0x2::object::new(arg1),
            name : arg0,
        }
    }

    public fun set_name(arg0: &mut Hero, arg1: 0x1::string::String) {
        arg0.name = arg1;
    }

    // decompiled from Move bytecode v6
}

