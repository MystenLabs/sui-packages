module 0x1501e46d2f086becfc287bc8b66d228b75275cba9b1aede360d9b94886846c3b::tesla {
    struct TESLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESLA>(arg0, 6, b"TESLA", b"Tesla", b"tesla", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731807849718.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESLA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESLA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

