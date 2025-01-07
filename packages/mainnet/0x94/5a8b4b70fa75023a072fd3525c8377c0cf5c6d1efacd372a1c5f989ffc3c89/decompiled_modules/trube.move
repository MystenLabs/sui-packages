module 0x945a8b4b70fa75023a072fd3525c8377c0cf5c6d1efacd372a1c5f989ffc3c89::trube {
    struct TRUBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUBE>(arg0, 6, b"TRUBE", b"TRUMP BEAR", b"TRUBE on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956123177.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUBE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUBE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

