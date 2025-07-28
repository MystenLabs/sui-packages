module 0x42839bbc0cd56ed66729d728ac3ee8bebeb1be595194be01be556ae999d7d96::sch {
    struct SCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCH>(arg0, 6, b"SCH", b"SuiCheems", b"Where Cheems meets the SUI chain -- fast, derpy, and unstoppable.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig23t5v22chqenayrem32l7lpirekds4dlducd7onsxfc63h5tdqu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SCH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

