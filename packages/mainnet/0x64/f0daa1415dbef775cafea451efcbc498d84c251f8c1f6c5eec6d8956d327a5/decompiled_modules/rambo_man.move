module 0x64f0daa1415dbef775cafea451efcbc498d84c251f8c1f6c5eec6d8956d327a5::rambo_man {
    struct RAMBO_MAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAMBO_MAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAMBO_MAN>(arg0, 9, b"rambo", b"rambo man", b"he's a rambo man", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/2d9a838d-783c-4af3-a3fc-0cd6b12a8a5a.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAMBO_MAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAMBO_MAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

