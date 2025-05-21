module 0x844686d54502d0c62b7434dfdf69f1c643cbd32ce037f1dde68ed68fe0d23aff::golduck {
    struct GOLDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDUCK>(arg0, 6, b"Golduck", b"Golduck Pokemon", b"The Most Dangerous Duck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeied227rot2hjfeufa5637kqeohd242xntznv7r5ykrngyajt3247m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GOLDUCK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

