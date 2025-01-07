module 0xf572687baf3694577dc6da13b81a5ad4bee5795f6b3e012166ba4c69fe3a5340::tommy {
    struct TOMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMMY>(arg0, 9, b"TOMMY", b"TOMMY", b"My dog on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/FiBSKnRpjNHChN1BANpr3dsVFQuuHhETMen4xUDgpump.png?size=lg&key=d53a3e")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOMMY>(&mut v2, 111111111000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMMY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOMMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

