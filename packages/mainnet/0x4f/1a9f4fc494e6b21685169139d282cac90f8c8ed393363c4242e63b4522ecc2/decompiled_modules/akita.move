module 0x4f1a9f4fc494e6b21685169139d282cac90f8c8ed393363c4242e63b4522ecc2::akita {
    struct AKITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKITA>(arg0, 6, b"AKITA", b"AKITA on SUI", x"414b495441206f6e20535549f09f9095f09f9095f09f90950a54686520666972737420646f67206f6e20547572626f73", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731673110449.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AKITA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKITA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

