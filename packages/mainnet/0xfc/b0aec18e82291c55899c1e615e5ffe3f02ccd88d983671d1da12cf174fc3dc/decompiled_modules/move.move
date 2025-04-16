module 0xfcb0aec18e82291c55899c1e615e5ffe3f02ccd88d983671d1da12cf174fc3dc::move {
    struct MOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVE>(arg0, 6, b"MOVE", b"Movepump", b"the first unofficial unique coin from movepump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000058777_5f6b60ae48.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

