module 0x1196357ebfc6182b4661e10c276c705ccf03de934e0026d8f038401bda75d76::marvin {
    struct MARVIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARVIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARVIN>(arg0, 6, b"MARVIN", b"Marvin", b"Elon Musk's special baby puppy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_99387d630d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARVIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARVIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

