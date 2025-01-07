module 0xe93d2cc472732bd42c10c031d28f15f525b3f98ab4eceee9490a820c313e36c8::huiCoin {
    struct HUICOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUICOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUICOIN>(arg0, 8, b"HUICOIN", b"HUICOIN", b"this is huiCoin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUICOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUICOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

