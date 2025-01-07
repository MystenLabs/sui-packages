module 0x5629d5f3f71f0d8074524ecb51a13d629d463bf4241dded1fa594ae5af489736::blake {
    struct BLAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAKE>(arg0, 6, b"BLAKE", b"BLAKE ON SUI", b"BLAKE is a popular Matt Furie character who doesn't really give a fuck about anything", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/avatar_1_a5a80fa39e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

