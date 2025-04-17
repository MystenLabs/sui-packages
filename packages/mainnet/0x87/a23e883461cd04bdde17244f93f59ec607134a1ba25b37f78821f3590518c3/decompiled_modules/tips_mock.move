module 0x87a23e883461cd04bdde17244f93f59ec607134a1ba25b37f78821f3590518c3::tips_mock {
    struct GlobalState has key {
        id: 0x2::object::UID,
        tips: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalState{
            id   : 0x2::object::new(arg0),
            tips : 0,
        };
        0x2::transfer::share_object<GlobalState>(v0);
    }

    public entry fun send_tips(arg0: &mut GlobalState, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.tips = arg1;
    }

    // decompiled from Move bytecode v6
}

