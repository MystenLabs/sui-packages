module 0x5a89cb2d91900ca9ccb69080b1d91796710feb192319d289be8cf3d3daa0b655::snk {
    struct SNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNK>(arg0, 6, b"SNK", b"SuiNeko", b"She's fast. She's fluffy. She farms memes like a ninja and claws her way to the top.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigmbn53z5lddds2ai4cmyebiuo2dgz67slup2rnhdjp7zotwte2cu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

