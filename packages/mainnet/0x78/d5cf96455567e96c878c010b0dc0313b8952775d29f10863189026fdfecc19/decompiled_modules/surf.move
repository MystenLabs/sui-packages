module 0x78d5cf96455567e96c878c010b0dc0313b8952775d29f10863189026fdfecc19::surf {
    struct SURF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURF>(arg0, 6, b"SURF", b"Big Fish Surf", b"Big Fish Surf,  a legendary big fish caught by a skilled surfer.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/z5829274453783_3347beb11f1cc6409e5d5e8a50c916ef_2c3a39ef20.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SURF>>(v1);
    }

    // decompiled from Move bytecode v6
}

