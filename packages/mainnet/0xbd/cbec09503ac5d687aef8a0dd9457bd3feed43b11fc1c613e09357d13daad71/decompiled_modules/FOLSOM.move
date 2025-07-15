module 0xbdcbec09503ac5d687aef8a0dd9457bd3feed43b11fc1c613e09357d13daad71::FOLSOM {
    struct FOLSOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOLSOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOLSOM>(arg0, 6, b"1015 FOLSOMMMM", b"FOLSOM", x"496e2072656d656d6272616e6365206f6620616c6c207468652066756e2077652068616420696e2053460a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ICoN_URL_STRING_PLACEHOLDER")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOLSOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOLSOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

