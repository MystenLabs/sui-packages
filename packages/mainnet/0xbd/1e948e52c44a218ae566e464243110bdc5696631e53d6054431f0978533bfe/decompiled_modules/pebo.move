module 0xbd1e948e52c44a218ae566e464243110bdc5696631e53d6054431f0978533bfe::pebo {
    struct PEBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEBO>(arg0, 6, b"PEBO", b"Pepe Boss", b"PEBO  the memecoin Pepe Boss, is tired of whales controlling the crypto markets. So he creates his own army  the PEBO army!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_7f5c8563c5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

