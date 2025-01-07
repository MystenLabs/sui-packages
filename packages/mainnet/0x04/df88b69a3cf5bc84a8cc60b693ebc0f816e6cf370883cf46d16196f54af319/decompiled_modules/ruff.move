module 0x4df88b69a3cf5bc84a8cc60b693ebc0f816e6cf370883cf46d16196f54af319::ruff {
    struct RUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUFF>(arg0, 9, b"RUFF", b"Ruff", b"Just Ruffin' Around on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/BWFKLaEYDoMDYzZRB2bYLPhMJTycD9voNihvSL34pump.png?size=xl&key=0be7a6")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RUFF>(&mut v2, 900000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUFF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

