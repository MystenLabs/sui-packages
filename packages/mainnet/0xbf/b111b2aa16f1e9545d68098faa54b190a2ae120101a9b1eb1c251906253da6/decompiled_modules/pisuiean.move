module 0xbfb111b2aa16f1e9545d68098faa54b190a2ae120101a9b1eb1c251906253da6::pisuiean {
    struct PISUIEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PISUIEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PISUIEAN>(arg0, 6, b"PISUIEAN", b"Pisuiean", b"Dreamy, mystical Pisces swimming in the SUI waves", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PISC_943276d3f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PISUIEAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PISUIEAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

