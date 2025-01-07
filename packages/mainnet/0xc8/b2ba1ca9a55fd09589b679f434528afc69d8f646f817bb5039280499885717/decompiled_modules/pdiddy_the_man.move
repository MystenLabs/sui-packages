module 0xc8b2ba1ca9a55fd09589b679f434528afc69d8f646f817bb5039280499885717::pdiddy_the_man {
    struct PDIDDY_THE_MAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDIDDY_THE_MAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDIDDY_THE_MAN>(arg0, 9, b"PDIDDY THE MAN", b"PUFF DADDY", b"sean combs is my hero", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PDIDDY_THE_MAN>(&mut v2, 3000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDIDDY_THE_MAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PDIDDY_THE_MAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

