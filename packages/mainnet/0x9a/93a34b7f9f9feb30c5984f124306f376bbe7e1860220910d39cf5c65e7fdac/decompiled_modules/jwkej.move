module 0x9a93a34b7f9f9feb30c5984f124306f376bbe7e1860220910d39cf5c65e7fdac::jwkej {
    struct JWKEJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: JWKEJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JWKEJ>(arg0, 9, b"JWKEJ", b"jeneb", b"shjsjw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/06fc53df-ca14-4255-9dbc-2a1e7f2c1b6a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JWKEJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JWKEJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

