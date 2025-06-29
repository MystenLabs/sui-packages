module 0xc3790b91daf3221f5c21e946004a9b16b70cd8b430e91e17dd80e16c63cb0f39::homer {
    struct HOMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOMER>(arg0, 6, b"HOMER", b"Homer Simpson", b"Homer Simpson is going to shake the water chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid4ki6ydw77uen2aihb4sr4f2t4rt3nxhpcm5k3n5ydqavhz45auy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HOMER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

