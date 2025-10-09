module 0x62d122110cbf69a60920e253b08ddb131d5d8148ffe0d0e4dfa6a929ab32ce90::upgrade_move_contract {
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

