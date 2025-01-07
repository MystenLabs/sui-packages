module 0x282f8e45c42733fcd345bf4702a6dc52ca67915620eda7b48e091bd6bf0a723a::sheep {
    struct SHEEP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHEEP>, arg1: 0x2::coin::Coin<SHEEP>) {
        0x2::coin::burn<SHEEP>(arg0, arg1);
    }

    fun init(arg0: SHEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEEP>(arg0, 4, b"SHEEP", b"SHEEP", b"SHEEP coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/BCzBBz5c6fCcRU7UjdJxszaECh7FdnU551MoQewpQv7L.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, 10000000000000000000, @0xaf5e0947b1d00c6f287becc210ab92f471c7cd8bba9f29f107179b535e6d4dd8, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHEEP>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SHEEP>>(v2);
    }

    fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHEEP>, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SHEEP>(arg0, (arg1 as u64), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

