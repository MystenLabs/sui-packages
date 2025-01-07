module 0x894baf890efd8232df6904ec9f978ee7ea22b6c3aec4ab7db7ababe60722efd1::mome {
    struct MOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOME>(arg0, 6, b"MOME", b"Mother Of Meme", b"MOME is the mother of all memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000011650_5a2b61354c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOME>>(v1);
    }

    // decompiled from Move bytecode v6
}

