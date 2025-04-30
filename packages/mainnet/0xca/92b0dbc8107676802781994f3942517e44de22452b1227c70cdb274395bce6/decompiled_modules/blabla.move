module 0xca92b0dbc8107676802781994f3942517e44de22452b1227c70cdb274395bce6::blabla {
    struct BLABLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLABLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLABLA>(arg0, 6, b"BLABLA", b"BlaBla Sui", b"BlaBla a ultimate memecoin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250430_234543_db097fe3d2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLABLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLABLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

