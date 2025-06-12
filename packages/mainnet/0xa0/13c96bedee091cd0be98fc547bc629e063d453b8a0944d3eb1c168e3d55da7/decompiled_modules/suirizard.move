module 0xa013c96bedee091cd0be98fc547bc629e063d453b8a0944d3eb1c168e3d55da7::suirizard {
    struct SUIRIZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRIZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRIZARD>(arg0, 6, b"SUIRIZARD", b"Sui Charizard", b"Suirizard on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiby73sq34krd5i32byzczggadacd3eavowsf7dnyurdc2qzywqgom")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRIZARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIRIZARD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

