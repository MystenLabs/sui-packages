module 0x7845eb01c5ed1348cab116fd8cdd29c98ce87d9d082addac343c8592187892f8::seal {
    struct SEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAL>(arg0, 6, b"SEAL", b"SEALION", b"cute sealion", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidwxvu72q4wye6ikzl3jodyycchhzmkteiwbbpoz3yvtntsamcx7m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SEAL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

