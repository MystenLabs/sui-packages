module 0xcdc32386c982127f489c3b171066f4692edea8afd3d14b2bbb8b136b07332da6::hesold {
    struct HESOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HESOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HESOLD>(arg0, 6, b"HESOLD", b"Christmas Pumper", b"Christmas Pumper123", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/G4ohVY5KmpsLeiD4bcJ7kfNKfpLYNzvf6owoh4k6pump.png?size=xl&key=69450e")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HESOLD>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HESOLD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HESOLD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

