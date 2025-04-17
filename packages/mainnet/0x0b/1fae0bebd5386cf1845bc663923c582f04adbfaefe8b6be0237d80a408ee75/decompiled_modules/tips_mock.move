module 0xb1fae0bebd5386cf1845bc663923c582f04adbfaefe8b6be0237d80a408ee75::tips_mock {
    struct GlobalState has key {
        id: 0x2::object::UID,
        tips: u64,
    }

    public entry fun compete(arg0: &mut GlobalState, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.tips = arg1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalState{
            id   : 0x2::object::new(arg0),
            tips : 0,
        };
        0x2::transfer::share_object<GlobalState>(v0);
    }

    // decompiled from Move bytecode v6
}

