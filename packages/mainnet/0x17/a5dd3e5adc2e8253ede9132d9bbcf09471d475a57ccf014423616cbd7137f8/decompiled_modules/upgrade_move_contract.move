module 0x17a5dd3e5adc2e8253ede9132d9bbcf09471d475a57ccf014423616cbd7137f8::upgrade_move_contract {
    struct Count has key {
        id: 0x2::object::UID,
        num: u64,
    }

    public fun inc(arg0: &mut Count) {
        arg0.num = arg0.num + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Count{
            id  : 0x2::object::new(arg0),
            num : 0,
        };
        0x2::transfer::share_object<Count>(v0);
    }

    // decompiled from Move bytecode v6
}

