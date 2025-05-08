module 0x447c5d4ac71d7089e92902f672f35717597060562c5c5c13a00b3f98cc34bafd::gigant {
    struct GIGANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIGANT>(arg0, 9, b"GIGANT", b"GIGANT", b"GIGANT GIGANT GIGANT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/GS1ufkaGWe2SVbkmUqp5dCPtWdDumDcjoyJFPJmSpump.png?size=xl&key=4aee0b")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GIGANT>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGANT>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIGANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

