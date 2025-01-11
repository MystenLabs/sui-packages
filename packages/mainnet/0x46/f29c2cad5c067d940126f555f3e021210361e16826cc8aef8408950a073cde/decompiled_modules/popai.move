module 0x46f29c2cad5c067d940126f555f3e021210361e16826cc8aef8408950a073cde::popai {
    struct POPAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPAI>(arg0, 9, b"POPAI", b"PopeyeAI SUI", b"I'm Popeye, the sailor man! $POPAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/BBZioNgzcYNuvMSESzkKiMJtbVqYRogXKpyz12fTAq31.png?size=lg&key=1e181c")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POPAI>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPAI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

