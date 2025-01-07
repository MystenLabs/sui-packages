module 0x17656852c38a6562283adf57adb5447ac4b57510085cbd2ed259f54cc461456d::adog {
    struct ADOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADOG>(arg0, 6, b"ADOG", b"Adeniyi'dog", b"SUI Official Mascot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731868173778.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

