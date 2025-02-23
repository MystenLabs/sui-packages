module 0xcf301cdc8452551ab7e3e7b803cb6abf953a807fd00930816a615c013a3fa9ac::br {
    struct FrontRunEvent has copy, drop {
        label: 0x1::string::String,
    }

    public fun frontrun_label(arg0: 0x1::string::String) {
        let v0 = FrontRunEvent{label: arg0};
        0x2::event::emit<FrontRunEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

