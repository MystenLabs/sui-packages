module 0x6fd90cf2ca126d0e556ba31664b8546c4b5f1f55add6da9cb4991f5851b3cd6b::mvrs {
    struct MVRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MVRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MVRS>(arg0, 9, b"MVRS", b"Magaverse", b"MVRS - Magaverse, new meme token on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/6dk9H7RD5m8JtRuUErNztwhBbr5ynzWvzPTusLpxpump.png?size=xl&key=ecbc4e")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MVRS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MVRS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MVRS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

