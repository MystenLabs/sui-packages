module 0x708c4957ff3e11e1bb09428fd843b944208d1c900e4ab8d42381d0c407477e1b::mystemon {
    struct Mystemon has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        generation: u64,
    }

    public entry fun create_mystemon(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Mystemon{
            id         : 0x2::object::new(arg1),
            name       : 0x1::string::utf8(arg0),
            generation : 1,
        };
        0x2::transfer::public_transfer<Mystemon>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

