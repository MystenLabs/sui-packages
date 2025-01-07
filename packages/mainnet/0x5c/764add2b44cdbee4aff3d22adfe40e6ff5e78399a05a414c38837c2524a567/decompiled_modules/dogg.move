module 0x5c764add2b44cdbee4aff3d22adfe40e6ff5e78399a05a414c38837c2524a567::dogg {
    struct DOGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGG>(arg0, 6, b"DOGG", b"Selfie Dogg", b"Greetings from...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Projekt_bez_nazwy_6_c55e4f2934.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

