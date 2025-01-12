module 0x106fa8a220f1a3d792fb05df9107cffc2a2b7d21d352d62da0bc3c4cf15a209b::mystery {
    struct MYSTERY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYSTERY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYSTERY>(arg0, 9, b"MYSTERY", b"Mystery", b"The frog before Pepe, by Matt Furie in \"The nightriders\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUoj3XNEwAhaQfw7pcSdPSZN2WwDgM4rmaxc443k8rF5o")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MYSTERY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYSTERY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYSTERY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

