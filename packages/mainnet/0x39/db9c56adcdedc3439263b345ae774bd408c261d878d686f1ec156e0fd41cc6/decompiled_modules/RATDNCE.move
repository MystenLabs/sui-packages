module 0x39db9c56adcdedc3439263b345ae774bd408c261d878d686f1ec156e0fd41cc6::RATDNCE {
    struct RATDNCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATDNCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATDNCE>(arg0, 6, b"Rat", b"RATDNCE", b"Rat dancing to the beat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ICoN_URL_STRING_PLACEHOLDER")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATDNCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RATDNCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

