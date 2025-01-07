module 0x6aebdc65ead1ce775a9f1ab252b398ef549833bb4ac28aa411fb4e6d7c68a928::bluppy {
    struct BLUPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUPPY>(arg0, 6, b"BLUPPY", b"Bluppy", b"Bluppy, the cheerful blue mascot, is always ready to bring waves of joy and fun to every beach day!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731054107139.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUPPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUPPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

