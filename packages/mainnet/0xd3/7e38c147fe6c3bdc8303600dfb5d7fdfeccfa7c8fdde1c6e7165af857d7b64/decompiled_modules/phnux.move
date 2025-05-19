module 0xd37e38c147fe6c3bdc8303600dfb5d7fdfeccfa7c8fdde1c6e7165af857d7b64::phnux {
    struct PHNUX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHNUX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHNUX>(arg0, 6, b"PHNUX", b"Phnux Sui", b"Pushed from the nest but back for the crown. $PHNUX is the Sui's true symbol of resilience  with added rebellion.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibpupe373zclem2pnc76igvowjchpyxpb4f2fwl3yvrxskmuhxfd4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHNUX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PHNUX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

