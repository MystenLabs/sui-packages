module 0x4b6b032fe3ebeb75972fafe372a909f0ee45444d2ed8f07d6ec9c665f84df678::cro {
    struct CRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRO>(arg0, 6, b"CRO", b"crocodile on sui", b"crocodile", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730954997219.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

