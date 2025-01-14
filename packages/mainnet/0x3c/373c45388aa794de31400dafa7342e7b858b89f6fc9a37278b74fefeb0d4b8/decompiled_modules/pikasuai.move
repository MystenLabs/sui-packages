module 0x3c373c45388aa794de31400dafa7342e7b858b89f6fc9a37278b74fefeb0d4b8::pikasuai {
    struct PIKASUAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKASUAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKASUAI>(arg0, 6, b"Pikasuai", b"Pikachu on SUII", b"Pikasuai has arrived here to win by force", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pikachu_profil_534664430f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKASUAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIKASUAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

