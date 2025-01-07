module 0x56f029d746b905c043d8b3ffc6ce6ef5cbb49932a882b59a4c3f30c7f4b28188::foxy {
    struct FOXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOXY>(arg0, 6, b"Foxy", b"BLUE FOXY", b"FOX ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3668_e3bf561b36.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOXY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

