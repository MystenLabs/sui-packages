module 0x2dbd4b2189544508622dafca47593580e89440c91ad954fdcf5951227b035b3d::sniperout {
    struct SNIPEROUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNIPEROUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNIPEROUT>(arg0, 6, b"SniperOut", b"FUCKK", b"FUCK SNIPER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d_Wt_Rf_Os0_400x400_50f1390b9b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNIPEROUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNIPEROUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

