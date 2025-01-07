module 0x32f4d6c2c5046e7363e20f991e22e1098c0bb4b01c169dc71c08630f8e470d4a::akita {
    struct AKITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKITA>(arg0, 6, b"AKITA", b"AKITA on SUI", x"414b495441206f6e20535549f09f9095f09f9095f09f90950a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731757586476.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AKITA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKITA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

