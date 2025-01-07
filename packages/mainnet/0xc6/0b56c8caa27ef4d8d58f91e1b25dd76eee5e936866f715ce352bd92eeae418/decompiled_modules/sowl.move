module 0xc60b56c8caa27ef4d8d58f91e1b25dd76eee5e936866f715ce352bd92eeae418::sowl {
    struct SOWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOWL>(arg0, 6, b"SOWL", b"Sowl", b"The first owl on sui - The greatest meme bird on sui will be the first sending to moon - $SOWL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_22_01_59_a30aac92c0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOWL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOWL>>(v1);
    }

    // decompiled from Move bytecode v6
}

