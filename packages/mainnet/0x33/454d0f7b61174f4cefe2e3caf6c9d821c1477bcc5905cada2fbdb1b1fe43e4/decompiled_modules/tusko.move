module 0x33454d0f7b61174f4cefe2e3caf6c9d821c1477bcc5905cada2fbdb1b1fe43e4::tusko {
    struct TUSKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUSKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUSKO>(arg0, 6, b"Tusko", b"Tusko su", b"Tusko sui sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/qw66_CEQI_9_Tes_Itehp_R_Ibe_NL_35r4_a186c23f6d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUSKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUSKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

