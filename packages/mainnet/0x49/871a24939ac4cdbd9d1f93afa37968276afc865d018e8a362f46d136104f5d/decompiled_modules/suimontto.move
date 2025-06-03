module 0x49871a24939ac4cdbd9d1f93afa37968276afc865d018e8a362f46d136104f5d::suimontto {
    struct SUIMONTTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMONTTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMONTTO>(arg0, 6, b"SUIMONTTO", b"SUIMON SUI", b"suimon tto on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidk4di5nhezjjg2zdv5agkkw4fodctqaunyrkdg56qqqfdk4p2ake")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMONTTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIMONTTO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

