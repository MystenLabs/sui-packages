module 0xae5f094b86e17dd39539289ecc753d0fa04b43a26ae5c15dfc418e71cdf1788d::musktrump {
    struct MUSKTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSKTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSKTRUMP>(arg0, 9, b"MUSKTRUMP", b"MuskTrump", b"MuskTrumpCoin is a distinctive memecoin that blends the fame of two controversial figures, Elon Musk and Donald Trump. It provides financial value while fostering a fun community for sharing humorous memes, news, and content related to both personalities.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/536775e2-4922-4272-89be-a922d03f1a3c-b3fe8130-a3d4-464f-a6be-1253f914296a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSKTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUSKTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

