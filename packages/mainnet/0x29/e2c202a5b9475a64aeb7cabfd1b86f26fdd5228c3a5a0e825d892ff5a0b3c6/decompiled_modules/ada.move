module 0x29e2c202a5b9475a64aeb7cabfd1b86f26fdd5228c3a5a0e825d892ff5a0b3c6::ada {
    struct ADA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADA>(arg0, 6, b"ADA", b"Cardano", b"meme cardano", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/f76206b1-74e3-4af8-b9e2-7373915234c6.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

