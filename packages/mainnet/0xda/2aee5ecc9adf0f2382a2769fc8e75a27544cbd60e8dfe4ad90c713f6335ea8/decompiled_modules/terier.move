module 0xda2aee5ecc9adf0f2382a2769fc8e75a27544cbd60e8dfe4ad90c713f6335ea8::terier {
    struct TERIER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERIER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TERIER>(arg0, 6, b"TERIER", b"Terier Sui Dog", b"TERIER  The most famous Russian Terier Although the name contains terier this breed was actually developed as a working and guard dog not as a true terier", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeih2ms7xmsgkhyvipx2cerfousyli7yx25dr2cteaoeejh75jynbk4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERIER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TERIER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

