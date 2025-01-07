module 0xcd3b525b588ddf2a2a0640c8317c088aa913405ff6821fd993b9b632a0595c79::pink {
    struct PINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINK>(arg0, 6, b"PINK", b"First Pink Pepe on Sui", b"The most memeable memecoin in existence,but pink version", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_04_81f38ad05c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

