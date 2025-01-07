module 0xa71b7f6d7779866bd4c96d145a4074d17c9c0e2ba228aa13b7d3acfe4bbfad46::pen {
    struct PEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEN>(arg0, 6, b"PEN", b"Peng", x"48692c2049e280996d2050454e47212050656f706c652074656c6c206d652049206c6f6f6b206c696b6520506570652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730952871702.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

