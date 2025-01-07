module 0x4314910cb8ac52c320b717899418c273e888147e51bcaea9fa859dfd41e4d926::memo {
    struct MemoLog has copy, drop {
        memo: 0x1::string::String,
    }

    public entry fun memo(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MemoLog{memo: arg0};
        0x2::event::emit<MemoLog>(v0);
    }

    // decompiled from Move bytecode v6
}

