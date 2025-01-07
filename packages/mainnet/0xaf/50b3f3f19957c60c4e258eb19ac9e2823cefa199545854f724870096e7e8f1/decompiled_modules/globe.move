module 0xaf50b3f3f19957c60c4e258eb19ac9e2823cefa199545854f724870096e7e8f1::globe {
    struct GLOBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOBE>(arg0, 6, b"GLOBE", b"Globe", b"Globe ($GLOBE): A revolutionary cryptocurrency driving global connectivity with secure, fast, and eco-friendly blockchain technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732942580356.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLOBE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOBE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

