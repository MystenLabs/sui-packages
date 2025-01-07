module 0x4728f98cde3eefd96d3bcc3b7f01eb9367aecfaf17c63bfb315f031bdb3c14fd::tyke {
    struct TYKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYKE>(arg0, 6, b"TYKE", b"First Type on Sui", b"First Type on Sui: https://www.tykeonsui.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_2_15_8dabcba866.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TYKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

