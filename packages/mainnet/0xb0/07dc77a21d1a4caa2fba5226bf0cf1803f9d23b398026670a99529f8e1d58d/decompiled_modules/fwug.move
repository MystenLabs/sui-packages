module 0xb007dc77a21d1a4caa2fba5226bf0cf1803f9d23b398026670a99529f8e1d58d::fwug {
    struct FWUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWUG>(arg0, 6, b"FWUG", b"FWUGtoken", b"TherealFWUG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/r30_K5oz_V_400x400_5b51f1a099.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

