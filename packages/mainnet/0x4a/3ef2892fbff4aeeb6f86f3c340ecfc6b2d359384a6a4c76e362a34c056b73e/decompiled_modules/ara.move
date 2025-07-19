module 0x4a3ef2892fbff4aeeb6f86f3c340ecfc6b2d359384a6a4c76e362a34c056b73e::ara {
    struct ARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARA>(arg0, 6, b"ARA", b"Ara Grok Companion Sui", b"The Best Grok Companion on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie3tiwfay76j3dahpd3pk6aop7hzq53yhp7sk42wz3f3p3bwxj27y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ARA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

