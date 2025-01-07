module 0x40bddb775578efb7858d0803fe8eab2a46713727d24410e2fc65c0bc2deebdc0::c_thread {
    struct Memo has drop, store {
        text: 0x1::string::String,
    }

    struct Thread has store, key {
        id: 0x2::object::UID,
        memo_list: vector<Memo>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun new_thread(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Thread{
            id        : 0x2::object::new(arg0),
            memo_list : 0x1::vector::empty<Memo>(),
        };
        0x2::transfer::public_share_object<Thread>(v0);
    }

    public entry fun write_thread(arg0: &mut Thread, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Memo{text: 0x1::string::utf8(arg1)};
        0x1::vector::push_back<Memo>(&mut arg0.memo_list, v0);
    }

    // decompiled from Move bytecode v6
}

