module 0x9d4bd6106750c1dde6c5d5834ee525053b8ade246d46328b2e1c3ff84c202967::gtv {
    struct GTV has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTV>(arg0, 6, b"GTV", b"GUNTHER VI", x"47756e7468657220564920697320746865207269636865737420646f67200a696e2074686520776f726c642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_14_Aq2v_Q_Jvp26il_Klx_G_94dbd3c07c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GTV>>(v1);
    }

    // decompiled from Move bytecode v6
}

