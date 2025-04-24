module 0x598a501abafebcecf5da1d15a2208348eb10e8fb868c825fc2814e7858865276::somi {
    struct SOMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOMI>(arg0, 6, b"SOMI", b"Soon our make it", b"Hey everyone, $SOMI is the embodiment of depression and belief for meme coins! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000061639_38432ff335.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

