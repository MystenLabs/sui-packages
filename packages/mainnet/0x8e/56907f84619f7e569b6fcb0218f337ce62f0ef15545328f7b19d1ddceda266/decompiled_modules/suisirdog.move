module 0x8e56907f84619f7e569b6fcb0218f337ce62f0ef15545328f7b19d1ddceda266::suisirdog {
    struct SUISIRDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISIRDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISIRDOG>(arg0, 6, b"SUISIRDOG", b"Suisirdog", b"I am a suisirdog with the appearance of a dog person and superman, we help investors to become rich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052346_59e44760b8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISIRDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISIRDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

