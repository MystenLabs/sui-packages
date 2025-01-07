module 0xffcfc804e1bc18069eb89b2f268de82db2268b8a2cbe02b2b9f54cf382118425::evildead {
    struct EVILDEAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVILDEAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVILDEAD>(arg0, 6, b"EvilDead", b"ASH", b"We all love ASH.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/output_c64b784b01.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVILDEAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EVILDEAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

