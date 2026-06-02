module 0x4456878343a1312f2f4419ebe201ab5ebcc638d36a7efa0c08c0e2523114829::nami {
    struct NAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAMI>(arg0, 6, b"NAMI", b"SuiNami ", x"202020202020202041206d6173736976652077617665206f662061646f7074696f6e2e0a546865205375694e616d69207761736865642061776179207765616b2068616e647320616e6420636172726965642062656c69657665727320746f7761726420746865204d6f6f6e20526565662e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1780407671986.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAMI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAMI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

