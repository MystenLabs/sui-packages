module 0x6ec3c62507008e36b4a64cb68f2b581a406a4c41d315bb581bfdbb025736ff6f::mrduck {
    struct MRDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRDUCK>(arg0, 9, b"MRDUCK", b"Yehor", b"this is a token for everyone who is kind at heart, pure in soul, and against violence and war in the world, let's make sure that we are heard", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/190b13c9-57cf-4130-b0e5-31f7e725f677.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MRDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

