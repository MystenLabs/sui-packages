module 0xcbe9d16b555b8062ffcbcb8066b7a88f8aebb949d26ff89abb56764342bb43be::boximal {
    struct BOXIMAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOXIMAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOXIMAL>(arg0, 9, b"BOXIMAL", b"Boximal", b"HOLD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/CoT6H16LdXCK4dX9J94ioVGMziKQCemkar7V6H5qpump.png?size=xl&key=aa5ee6")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOXIMAL>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOXIMAL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOXIMAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

