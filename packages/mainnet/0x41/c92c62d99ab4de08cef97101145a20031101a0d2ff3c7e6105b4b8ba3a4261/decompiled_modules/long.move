module 0x41c92c62d99ab4de08cef97101145a20031101a0d2ff3c7e6105b4b8ba3a4261::long {
    struct LONG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LONG>, arg1: 0x2::coin::Coin<LONG>) {
        0x2::coin::burn<LONG>(arg0, arg1);
    }

    fun init(arg0: LONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LONG>(arg0, 4, b"LONG", b"LONG", b"LONG coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/BCzBBz5c6fCcRU7UjdJxszaECh7FdnU551MoQewpQv7L.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, 10000000000000000000, @0xaf5e0947b1d00c6f287becc210ab92f471c7cd8bba9f29f107179b535e6d4dd8, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LONG>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LONG>>(v2);
    }

    fun mint(arg0: &mut 0x2::coin::TreasuryCap<LONG>, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LONG>(arg0, (arg1 as u64), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

