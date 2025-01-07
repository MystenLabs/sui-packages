module 0x5333597ab8f0f9a544bd360ab725a81dd62f91986722649a3f2de76e73c3dd17::mewns {
    struct MEWNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEWNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEWNS>(arg0, 6, b"MEWNS", b"MEWNSUI", b"Once upon a time, memes desired to go to the MEWN. The journey was long and fraught with difficulties and danger. Thus only some memes made it there. Now they are happily living on the MEWN in a MEWNBASE they built for themselves and are waiting for other memes to join them.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dgde_ESLX_400x400_2f020e791f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEWNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEWNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

