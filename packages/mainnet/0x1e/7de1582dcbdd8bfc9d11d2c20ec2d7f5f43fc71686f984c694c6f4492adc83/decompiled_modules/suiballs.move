module 0x1e7de1582dcbdd8bfc9d11d2c20ec2d7f5f43fc71686f984c694c6f4492adc83::suiballs {
    struct SUIBALLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBALLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBALLS>(arg0, 6, b"SUIBALLS", b"TESTICLES OF SUI", b"$SUIBALLS is a bold and cheeky token on Sui, inspired by testicles. It brings humor and attitude to the crypto world, standing strong as a symbol of confidence and daring moves. Hold $SUIBALLS and show you're not afraid to make a big impact on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIBALLS_2a2fa3b5a0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBALLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBALLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

