module 0xdcf3a719e5e0ac053dde42d5a9cbbea7148915aca7d0e8a6234ced7e36193552::MIZURA {
    struct MIZURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIZURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIZURA>(arg0, 9, b"MIZURA", b"Mizura Girl", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/2E12VC6aKdcDj4oHNukm6LSERMZUo1DzmVkd68v7pump.png?size=xl&key=1d90a0")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIZURA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MIZURA>>(0x2::coin::mint<MIZURA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MIZURA>>(v2);
    }

    // decompiled from Move bytecode v6
}

