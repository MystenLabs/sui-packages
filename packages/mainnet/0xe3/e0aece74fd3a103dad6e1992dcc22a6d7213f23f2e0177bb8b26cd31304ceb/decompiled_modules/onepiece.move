module 0xe3e0aece74fd3a103dad6e1992dcc22a6d7213f23f2e0177bb8b26cd31304ceb::onepiece {
    struct ONEPIECE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONEPIECE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONEPIECE>(arg0, 6, b"Onepiece", b"onePiece on sui", b"ONE PIECE FAN COIN is an anime meme token created among a strong community of followers. The strength of the community is the foundation for $OPC to remain active in the crypto industry", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_08_13_00_52_22_156dcf7844.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONEPIECE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONEPIECE>>(v1);
    }

    // decompiled from Move bytecode v6
}

