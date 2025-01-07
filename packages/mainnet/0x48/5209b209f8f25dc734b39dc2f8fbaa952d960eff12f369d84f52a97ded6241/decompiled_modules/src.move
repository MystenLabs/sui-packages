module 0x485209b209f8f25dc734b39dc2f8fbaa952d960eff12f369d84f52a97ded6241::src {
    struct SRC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRC>(arg0, 6, b"SRC", b"Sui Rabbit Coin", b"Sui Rabbit Coin is a fair launch Token 50% of the tokens and 100 Sui coins have been provided as liquidity on DEXes on Sui  and the LP has been burnt by sent to the DEAD Wallet. The other 50% of the tokens has been sent dead wallet. Trust no one check all these info by looking on chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.freepik.com/premium-photo/cute-animal-little-pretty-blue-rabbit-portrait-from-splash-watercolor-illustration_169356-493.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SRC>(&mut v2, 18000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRC>>(v1);
    }

    // decompiled from Move bytecode v6
}

