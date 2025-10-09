module 0x6df105f0eb2d255c14d62d910fc2b648fb6ee65e4070f3b4e7e0298167f8d8c::upgrade_move_contract {
    struct Count has key {
        id: 0x2::object::UID,
        num: u64,
    }

    public fun inc(arg0: &mut Count) {
        arg0.num = arg0.num - 1;
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

