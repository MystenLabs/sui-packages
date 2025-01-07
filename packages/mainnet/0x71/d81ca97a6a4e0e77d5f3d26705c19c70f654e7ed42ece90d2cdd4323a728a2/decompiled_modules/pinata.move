module 0x71d81ca97a6a4e0e77d5f3d26705c19c70f654e7ed42ece90d2cdd4323a728a2::pinata {
    struct PINATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINATA>(arg0, 6, b"PINATA", b"Pinata Bot", b"Telegram bot to manage assets on Sui network - token now live.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/26_Tm_Hqv_J_400x400_094d045178.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINATA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINATA>>(v1);
    }

    // decompiled from Move bytecode v6
}

