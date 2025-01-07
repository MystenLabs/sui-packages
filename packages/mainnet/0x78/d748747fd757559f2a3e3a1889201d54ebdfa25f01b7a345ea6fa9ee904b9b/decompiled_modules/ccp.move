module 0x78d748747fd757559f2a3e3a1889201d54ebdfa25f01b7a345ea6fa9ee904b9b::ccp {
    struct CCP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCP>(arg0, 2, b"CCP", b"CCP Token", b"Token for the CCP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://nfo7fxz6gzhx2tizcfa5cyyphafuzgkrcuvizjgaounljsmbm6rq.arweave.net/aV3y3z42T31NGRFB0WMPOAtMmVEVKoykwHUatMmBZ6M")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CCP>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CCP>>(0x2::coin::mint<CCP>(&mut v2, 10000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

