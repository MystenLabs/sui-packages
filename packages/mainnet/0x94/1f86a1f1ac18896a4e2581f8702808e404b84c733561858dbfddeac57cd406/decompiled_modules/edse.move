module 0x941f86a1f1ac18896a4e2581f8702808e404b84c733561858dbfddeac57cd406::edse {
    struct EDSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDSE>(arg0, 6, b"EDSE", b"Eddie Seal", b"$EDSE is a token not just a regular memecoin, we are divers capable of reaching the bottom of the ocean  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049922_c1d245e8ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EDSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

