module 0x22f8611ab5895e877e6f4d97d023462e3d5501d5675e3b6bf73a453cb9af7c1f::tazmania {
    struct TAZMANIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAZMANIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAZMANIA>(arg0, 6, b"Tazmania", b"Tazmaniamem", b"Tazmania mem on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009827_310f7dfa99.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAZMANIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAZMANIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

