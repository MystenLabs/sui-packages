module 0xda34da0cfd5d609c775461ad1884525db8463dcc56c905eb126c47ad0bceedcd::orange {
    struct ORANGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORANGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORANGE>(arg0, 6, b"Orange", b"Florida Man", b"Wildest guy in Florida, doing crazy stuff daily.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/56_FBE_519_226_F_4026_9_FBA_AE_99_EEB_9_F191_a92a713ee8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORANGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORANGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

