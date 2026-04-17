module 0xddd1a7378847cb31ca8f5919a23f2d97cba2cea1300a89eda2d60fef77c1b872::aion_nft {
    struct Aion has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        metadata_url: 0x1::string::String,
    }

    public fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Aion{
            id           : 0x2::object::new(arg3),
            name         : 0x1::string::utf8(arg0),
            description  : 0x1::string::utf8(arg1),
            metadata_url : 0x1::string::utf8(arg2),
        };
        0x2::transfer::public_transfer<Aion>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

