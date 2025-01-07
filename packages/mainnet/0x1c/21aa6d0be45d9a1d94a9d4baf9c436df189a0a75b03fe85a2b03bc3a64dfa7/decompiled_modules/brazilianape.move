module 0x1c21aa6d0be45d9a1d94a9d4baf9c436df189a0a75b03fe85a2b03bc3a64dfa7::brazilianape {
    struct BRAZILIANAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAZILIANAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRAZILIANAPE>(arg0, 6, b"BRAZILIANAPE", b"BRAZILIAN APE CLUB", b"BRAZILIAN APE CLUB FOR SUI DEGENS THAT KNOW THAT SUI IS THE FUTURE AND WE LIKE BIG BOOTY BRAZILIANS!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BAPECLUB_09d9845b79.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAZILIANAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRAZILIANAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

