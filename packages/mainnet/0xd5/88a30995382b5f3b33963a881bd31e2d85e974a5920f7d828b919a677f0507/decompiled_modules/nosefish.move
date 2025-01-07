module 0xd588a30995382b5f3b33963a881bd31e2d85e974a5920f7d828b919a677f0507::nosefish {
    struct NOSEFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOSEFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOSEFISH>(arg0, 6, b"Nosefish", b"Yellow_Dick_Nick", b"Party hard with little Nicky and tape your junk for art or tape it to your taint and act like a woman.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5875_d5766e6407.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOSEFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOSEFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

