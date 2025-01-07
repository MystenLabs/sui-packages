module 0xc2d8ab1b9561d59eaf03491e9d24876fbdb8e34ff779be4f7e1e26a73c78ede::morud {
    struct MORUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORUD>(arg0, 6, b"Morud", b"Murad Meme jesus", b"Morud the memecoin jesus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3064_b092f7ecad.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MORUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

