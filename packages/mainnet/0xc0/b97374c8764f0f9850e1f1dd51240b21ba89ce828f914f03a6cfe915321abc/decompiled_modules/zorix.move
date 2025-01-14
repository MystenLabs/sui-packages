module 0xc0b97374c8764f0f9850e1f1dd51240b21ba89ce828f914f03a6cfe915321abc::zorix {
    struct ZORIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZORIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZORIX>(arg0, 6, b"ZORIX", b"ZORIX AI", b"NEXT AI LAUNCHPAD ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/small_logo_cfdb26a3d0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZORIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZORIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

