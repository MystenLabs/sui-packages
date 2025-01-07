module 0xb8fd75d032490c0255f6c804b06ccddde18f36d03d614ea2341e37374c86dd81::artcoins {
    struct ARTCOINS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARTCOINS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARTCOINS>(arg0, 9, b"ARTCOINS", b"Art Coins", b"Art Coins (ARTCOINS) Open-source on-chain generative AI art protocol, built on Solana", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/FR59EeWjYHoTNXEZ4VqDvLr3NBEah3ThPpqQqWXapump.png?size=xl&key=225e97")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ARTCOINS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARTCOINS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARTCOINS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

