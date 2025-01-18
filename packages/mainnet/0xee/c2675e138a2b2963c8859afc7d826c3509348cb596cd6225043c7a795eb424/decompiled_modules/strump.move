module 0xeec2675e138a2b2963c8859afc7d826c3509348cb596cd6225043c7a795eb424::strump {
    struct STRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRUMP>(arg0, 6, b"STRUMP", b"Seal Trump", b"King of the seeea of the US", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/openart_image_yv_X_Cw_Ay_F_1737242255103_raw_33b3c0db17.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

