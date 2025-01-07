module 0x829c2f3b8fb25f53c427e86b74d6d8bd15e2d8005d1d7477c935c144638026ac::apeds {
    struct APEDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: APEDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APEDS>(arg0, 6, b"Apeds", b"Aped Sui", b"Aped on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9211_959fb8fecd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APEDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APEDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

