module 0xace758eb9e40c4e5ca404d3919ec695717a70bcba15f01d4d3c177be7478dd20::awawa {
    struct AWAWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWAWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWAWA>(arg0, 9, b"AWAWA", b"Screaming Hyrax", b"AWAWA - Screaming Hyrax on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/EXkLo2gj414TcicTum7ZseGTfaVFbJrQZntvTK8Tpump.png?size=xl&key=66abe0")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AWAWA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AWAWA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWAWA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

