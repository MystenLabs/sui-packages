module 0x40bddb775578efb7858d0803fe8eab2a46713727d24410e2fc65c0bc2deebdc0::a_hello {
    struct Memo has store, key {
        id: 0x2::object::UID,
        text: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun new_memo(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Memo{
            id   : 0x2::object::new(arg0),
            text : 0x1::string::utf8(b""),
        };
        0x2::transfer::public_transfer<Memo>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun write2_memo(arg0: Memo, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.text = 0x1::string::utf8(arg1);
        0x2::transfer::public_transfer<Memo>(arg0, 0x2::tx_context::sender(arg2));
    }

    public entry fun write_memo(arg0: &mut Memo, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.text = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

