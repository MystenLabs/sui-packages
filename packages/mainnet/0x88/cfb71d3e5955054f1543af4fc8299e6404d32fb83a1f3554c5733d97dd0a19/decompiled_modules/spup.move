module 0x88cfb71d3e5955054f1543af4fc8299e6404d32fb83a1f3554c5733d97dd0a19::spup {
    struct SPUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPUP>(arg0, 6, b"SPUP", b"SuiPuppys", b"SPUP represent the resilient, chaotic, and fun-loving energy of the crypto community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiam6nav27fm3bqn7oas6lyizysk3u3lwehbrgevn6v5r6ly6sw6qu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPUP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

