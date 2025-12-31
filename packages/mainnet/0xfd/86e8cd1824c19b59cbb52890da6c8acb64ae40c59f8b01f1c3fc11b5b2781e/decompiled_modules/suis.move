module 0xfd86e8cd1824c19b59cbb52890da6c8acb64ae40c59f8b01f1c3fc11b5b2781e::suis {
    struct SUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIS>(arg0, 6, b"SUIS", b"SUI SIREN", b"May this SUI siren bring joy to every owner! Happy New Year 2026 to the entire community!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiab4xndmn6obs56r2gicdd6gv6cxi5jbinz4eywdjjmawyoszbwme")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

