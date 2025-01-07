module 0xd67366f03dbfe7f00e0da76be69fd910d50ba83a25e837b16bc3ce8639dcc063::drop {
    struct Drop has store, key {
        id: 0x2::object::UID,
        color: 0x1::option::Option<u64>,
    }

    public fun create_drop(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Drop{
            id    : 0x2::object::new(arg0),
            color : 0x1::option::none<u64>(),
        };
        0x2::transfer::transfer<Drop>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

