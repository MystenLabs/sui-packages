module 0x196c536121a9a7604f241e2892060e5f95874b1db2a55551afc7b7ea1dbbd0b8::dd {
    struct DD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DD>(arg0, 6, b"DD", b"faa", b"h", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiexzz3wk2vd6rfjybx2is6kqetl24uw6ge42pd6f3tgge2s4imcjq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

