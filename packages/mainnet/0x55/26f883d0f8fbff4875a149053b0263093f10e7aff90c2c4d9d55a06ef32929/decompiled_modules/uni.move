module 0x5526f883d0f8fbff4875a149053b0263093f10e7aff90c2c4d9d55a06ef32929::uni {
    struct UNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNI>(arg0, 6, b"UNI", b"Uni.sui", b"The dog of SUI co-founder @Evanweb3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730958081834.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

