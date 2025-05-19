module 0xf24cc98b99a80457eea1f07ee573137e7fb527517a141ac5a625ae4a0e52d26d::ditto {
    struct DITTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DITTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DITTO>(arg0, 6, b"DITTO", b"DITTO on Sui", b"Let's Lick Tits. DITTO ON SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicuv77i6qz5xjhmcxbe4znwm2xrmhhgkychufm3q625gboheyq2hu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DITTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DITTO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

