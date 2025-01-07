module 0xb51a0576222d1919a16164d00e3cfd19c6ba7e7532ed722b81a73cde958d7fce::preme {
    struct PREME has drop {
        dummy_field: bool,
    }

    fun init(arg0: PREME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PREME>(arg0, 6, b"PREME", b"SUIPREME", b"Culture On Blockchain | $SUI $PREME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D09_AB_158_375_C_41_A9_B724_869_A07_D4595_C_cfb7ff8f12.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PREME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PREME>>(v1);
    }

    // decompiled from Move bytecode v6
}

