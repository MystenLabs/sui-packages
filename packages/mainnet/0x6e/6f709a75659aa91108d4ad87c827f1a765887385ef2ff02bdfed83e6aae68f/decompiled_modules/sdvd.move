module 0x6e6f709a75659aa91108d4ad87c827f1a765887385ef2ff02bdfed83e6aae68f::sdvd {
    struct SDVD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDVD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDVD>(arg0, 6, b"SDVD", b"Stimulation Clicker DVD", b"Click me for stimulation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_ef826abf0e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDVD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDVD>>(v1);
    }

    // decompiled from Move bytecode v6
}

