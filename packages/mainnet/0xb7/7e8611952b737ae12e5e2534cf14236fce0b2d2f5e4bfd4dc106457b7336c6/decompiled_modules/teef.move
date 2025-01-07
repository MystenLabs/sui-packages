module 0xb77e8611952b737ae12e5e2534cf14236fce0b2d2f5e4bfd4dc106457b7336c6::teef {
    struct TEEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEEF>(arg0, 6, b"TEEF", b"Teef", b"big teef lolz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/teef_5a00690373.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEEF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEEF>>(v1);
    }

    // decompiled from Move bytecode v6
}

