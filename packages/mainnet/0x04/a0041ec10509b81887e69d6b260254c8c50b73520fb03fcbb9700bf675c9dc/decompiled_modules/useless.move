module 0x4a0041ec10509b81887e69d6b260254c8c50b73520fb03fcbb9700bf675c9dc::useless {
    struct USELESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: USELESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USELESS>(arg0, 9, b"USELESS", b"USELESS COIN", b"Dev was useless.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/Dz9mQ9NzkBcCsuGPFJ3r1bS4wgqKMHBPiVuniW8Mbonk.png?size=xl&key=67efb9")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USELESS>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USELESS>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USELESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

