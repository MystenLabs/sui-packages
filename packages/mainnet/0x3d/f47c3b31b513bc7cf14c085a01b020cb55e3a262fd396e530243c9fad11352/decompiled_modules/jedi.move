module 0x3df47c3b31b513bc7cf14c085a01b020cb55e3a262fd396e530243c9fad11352::jedi {
    struct JEDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEDI>(arg0, 6, b"JEDI", b"Jedi Pepe", b"May The Pump Be With You!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3zor_e0d12e9635.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JEDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

