module 0x308e6fe1ad83f1a731eaef4c54cfee856aa2e95155186645adb0b1d2834c0c98::aquewater {
    struct AQUEWATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUEWATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUEWATER>(arg0, 6, b"Aquewater", b"aqua", b"waterrrr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/justin_sun_d337d43364.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUEWATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQUEWATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

