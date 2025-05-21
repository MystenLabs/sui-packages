module 0xe639e6d3a0e5c0f5d3392944bf191818a180770653db4578a4dfebf72f23a5e3::seel {
    struct SEEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEEL>(arg0, 6, b"SEEL", b"Seel on Sui", x"5468652063757465737420506f6bc3a96d6f6e207365616c206f6e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreialdn3aq64zbqtrildpgfyqmawa33izy5yxrwjapyuzrjgrxfpfum")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SEEL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

