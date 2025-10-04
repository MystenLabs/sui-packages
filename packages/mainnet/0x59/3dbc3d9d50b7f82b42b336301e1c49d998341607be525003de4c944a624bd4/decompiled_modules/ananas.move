module 0x593dbc3d9d50b7f82b42b336301e1c49d998341607be525003de4c944a624bd4::ananas {
    struct Pineapple has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun mint(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Pineapple{
            id   : 0x2::object::new(arg1),
            name : 0x1::string::utf8(arg0),
        };
        0x2::transfer::public_transfer<Pineapple>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

