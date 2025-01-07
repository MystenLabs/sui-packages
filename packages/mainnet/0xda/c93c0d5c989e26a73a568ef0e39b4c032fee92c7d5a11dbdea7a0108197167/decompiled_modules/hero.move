module 0xdac93c0d5c989e26a73a568ef0e39b4c032fee92c7d5a11dbdea7a0108197167::hero {
    struct HERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HERO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HERO>(arg0, 6, b"HERO", b"SUPER DOG", b"I am here to save the CRYPTO WORLD OF SUIII!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Super_07e28fc387.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HERO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HERO>>(v1);
    }

    // decompiled from Move bytecode v6
}

