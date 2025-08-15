module 0x8473a2ee4f687cb0627d43827920b7be5f23d4c847036e532ba4b0b7eb20eb11::sdduck {
    struct SDDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDDUCK>(arg0, 6, b"SDDUCK", b"SuiDiDuck ", b"Welcome to the pond, where memes take flight and ducks aim for the moon. SuiDiDuck is a community-driven meme coin built on the powerful Sui Network, designed to combine humor, creativity, and blockchain technology into one unstoppable flock.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1755268179035.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDDUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDDUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

