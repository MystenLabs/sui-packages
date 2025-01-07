module 0x569cf82e7ede28b6368b8580eca1b806969a951a96dfacab10b81d6e4639d177::moodep {
    struct MOODEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODEP>(arg0, 6, b"MOODEP", b"Moo Deng President", b"Our one true leader.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3333_8c4b8c57da.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOODEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

