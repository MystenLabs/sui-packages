module 0x745c08aa82b2a4b4a46aa3676fcfaafd52a96ec4303b422a4a211cb2edac0892::rwt {
    struct RWT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RWT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RWT>(arg0, 6, b"RWT", b"Real World Tokens", b"RWT enables the tokenization and fractionalization of real-world assets through creation of DePins and onboarding via secure DIDs for enhanced identity verification while ensuring compliance for on and off ramp protocols for retail and institutions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736464557681.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RWT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RWT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

