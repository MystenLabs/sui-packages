module 0xf21de2c0d015d6a2313b3ddebfcf6b3b5ea7b2681f58ac0e20ced47cd62db664::tnkl {
    struct TNKL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TNKL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TNKL>(arg0, 6, b"TNKL", b"TINKLE On Sui", b"TNKL - The Sound of Water on Sui. Soon to be #1 Meme on Sui. Have a tinkle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tinkle_1cb28bc6ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TNKL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TNKL>>(v1);
    }

    // decompiled from Move bytecode v6
}

