module 0x480b08da4605e6cb9a1168086c11873c3ff0c289e16cda247fe97bc9a2021d4c::hesold {
    struct HESOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HESOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HESOLD>(arg0, 6, b"HESOLD", b"Christmas Pumper", b"TOKEN_DESCRIPTION", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/G4ohVY5KmpsLeiD4bcJ7kfNKfpLYNzvf6owoh4k6pump.png?size=xl&key=69450e")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HESOLD>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HESOLD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HESOLD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

