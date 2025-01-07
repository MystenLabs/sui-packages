module 0x9b00ef5f95f9fb267cc9ef43a83652f3cd3353723fd18a5e14b5cbdfc27c2582::sproto {
    struct SPROTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPROTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPROTO>(arg0, 9, b"SPROTO", b"Sproto", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x3333ae5f9a8e27923fa0648617b4c69d59b661f0.png?size=xl&key=b30fe4")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPROTO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPROTO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPROTO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

