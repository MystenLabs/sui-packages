module 0x145bb2b959fb65ae2bdb340c8d906bc19df72a4b70ef6b489c0163585f86e9ee::classic {
    struct CLASSIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLASSIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLASSIC>(arg0, 6, b"Classic", b"Sui Classic", b"Time to go back to our roots. The classic edition of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1787689897147.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLASSIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLASSIC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

