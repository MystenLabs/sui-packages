module 0x8e0c58286c5d2ab14f57a6c377f9e1c8dd922d803607d4c9015d626f65932c9e::collins {
    struct COLLINS has drop {
        dummy_field: bool,
    }

    fun init(arg0: COLLINS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COLLINS>(arg0, 6, b"COLLINS", b"SUIssudio", b"Der's this girl dat's been on my mind...SUIsusudio oh oh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Capture_fde3cc026e.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COLLINS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COLLINS>>(v1);
    }

    // decompiled from Move bytecode v6
}

