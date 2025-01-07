module 0x6fe0dcace4b5421cc809dbc014bdc6d00ff0c0d2f6014e9a7a044263c7a2b76::gpepe {
    struct GPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GPEPE>(arg0, 6, b"GPEPE", b"Gundam Pepe", b"Gundam Pepe is a decentralized cryptocurrency born from the cosmic collision of two iconic forces: the legendary mecha anime, Gundam, and the mischievous meme lord, Pepe the Frog. We're a community-driven project fueled by the spirit of rebellion and the power of memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gundam_head_logo_01_a72a810a06.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

