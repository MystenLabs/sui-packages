module 0x7493674b83ab66046f46cc859e48c619fc0803c441e2ed5d7d5a978474b55b2f::mrowww {
    struct MROWWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MROWWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MROWWW>(arg0, 6, b"MROWWW", b"MEOWMROW", x"546869732063617420646f65736e2774206d656f772c206974206d726f7773206f6e205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3494_4dae6fa4ed.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MROWWW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MROWWW>>(v1);
    }

    // decompiled from Move bytecode v6
}

