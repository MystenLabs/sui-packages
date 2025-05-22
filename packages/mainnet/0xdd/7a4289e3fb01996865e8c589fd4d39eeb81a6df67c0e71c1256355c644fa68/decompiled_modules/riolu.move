module 0xdd7a4289e3fb01996865e8c589fd4d39eeb81a6df67c0e71c1256355c644fa68::riolu {
    struct RIOLU has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIOLU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIOLU>(arg0, 6, b"RIOLU", b"Riolu Pokemon", b"$RIOLU symbolizes the boundless Sui Aura energy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidm6qlb26spwh4nzk3b7csotkrlpcxkul5fqqqmcvpr7l7kf4ji5y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIOLU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RIOLU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

