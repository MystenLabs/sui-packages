module 0x173e0e8f810ef1ce7c6c9dafea422a19f61c716f364e0c02fe84342889954681::sandy {
    struct SANDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANDY>(arg0, 6, b"SANDY", b"Sandy", b"An experiment, can squirrels survive in water?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734109335993.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SANDY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANDY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

