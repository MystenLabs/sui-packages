module 0xfedf26a900001af6a299b2970e3033cfe03f779c0df11529adcd7e74cfa2d4ed::sasa {
    struct SASA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASA>(arg0, 6, b"SASA", b"SARDINE", b"Sardines symbolize unity, and were about to turn $SASA into something huge. Welcome to the Sardine Era, are you ready to ride the hype wave?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUISARDENE_3b036823a5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SASA>>(v1);
    }

    // decompiled from Move bytecode v6
}

