module 0x58e59d70f9c5132632bc87c97e7fd3fa390f29e4e30d736a6a2eedc7e70df77f::treasury {
    struct TREASURY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREASURY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREASURY>(arg0, 6, b"TREASURY", b"treasury", b"treasury", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TREASURY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TREASURY>>(0x2::coin::mint<TREASURY>(&mut v2, 210000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREASURY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

