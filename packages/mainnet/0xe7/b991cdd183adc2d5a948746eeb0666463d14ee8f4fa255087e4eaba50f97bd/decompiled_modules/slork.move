module 0xe7b991cdd183adc2d5a948746eeb0666463d14ee8f4fa255087e4eaba50f97bd::slork {
    struct SLORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLORK>(arg0, 6, b"Slork", b"Blue slork", b"Slork the father slerf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3813_0f80d72324.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

