module 0x9fc7a135bc94984603d8e8d470a64a065ea9dd437c71f521035655a7b52e4e1::dood {
    struct DOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOOD>(arg0, 9, b"DOOD", b"Doodles", b"ntroducing $DOOD, the official token of Doodles.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/NY3C7zH6Cy3LuuBbny4ZJRR5HrpXL3b1NDM1Axxpump.png?size=xl&key=d02d90")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOOD>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOD>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

