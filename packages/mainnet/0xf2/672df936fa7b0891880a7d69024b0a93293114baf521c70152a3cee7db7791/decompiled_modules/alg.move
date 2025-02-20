module 0xf2672df936fa7b0891880a7d69024b0a93293114baf521c70152a3cee7db7791::alg {
    struct ALG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALG>(arg0, 6, b"ALG", b"Algario", b"The blockchain-powered multiplayer cell eating game on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3105_755832a0fb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALG>>(v1);
    }

    // decompiled from Move bytecode v6
}

