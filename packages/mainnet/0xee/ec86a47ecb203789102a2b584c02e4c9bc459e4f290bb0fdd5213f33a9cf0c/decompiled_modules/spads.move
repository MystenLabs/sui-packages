module 0xeeec86a47ecb203789102a2b584c02e4c9bc459e4f290bb0fdd5213f33a9cf0c::spads {
    struct SPADS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPADS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPADS>(arg0, 9, b"SPADS", b"Suipads", b"Sui launchpad for fair-launch memecoins Launch  Build  Trade1% fee  0.7% Dev  0.3% Platform", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipads.fun/api/files/suipump/logos/0x159ca760875b2e1713b7132559e0f50bc9e29a4e310816bc0683ab425ea814ce/363127b2-a575-4168-a016-7e0c0abb1d05.jpeg")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPADS>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPADS>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

