module 0x70f48e2223414dbba45fe632c6ab5d622f77d21a95618187afce7c311a42ddee::pocket {
    struct POCKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: POCKET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POCKET>(arg0, 6, b"POCKET", b"Pussy Rocket", x"546869732069732061205075737379206f6e206120526f636b65742e20546865207469636b657220697320504f434b45540a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_3_7c653db592.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POCKET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POCKET>>(v1);
    }

    // decompiled from Move bytecode v6
}

