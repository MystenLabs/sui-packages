module 0xa522ce43ed8c5c89adee8a485a6de33b89a80ebeeddeb164a3526042449d79cd::suibag {
    struct SUIBAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBAG>(arg0, 6, b"SUIBAG", b"Mo Shaik's Sui Bag", b"The Sui bag of the Sultan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747062047239.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBAG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBAG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

