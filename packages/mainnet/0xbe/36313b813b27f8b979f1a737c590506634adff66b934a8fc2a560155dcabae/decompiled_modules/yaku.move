module 0xbe36313b813b27f8b979f1a737c590506634adff66b934a8fc2a560155dcabae::yaku {
    struct YAKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAKU>(arg0, 6, b"YAKU", b"SUIYAKU", b"The cursed guardian of lost memecoins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiffuk3nczkasrm23spx3adyxfhrtiwp3hxit7p6ddtgnsnw5idpzq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YAKU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

