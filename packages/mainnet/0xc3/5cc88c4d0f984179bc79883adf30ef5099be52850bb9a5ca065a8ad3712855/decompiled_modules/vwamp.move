module 0xc35cc88c4d0f984179bc79883adf30ef5099be52850bb9a5ca065a8ad3712855::vwamp {
    struct VWAMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: VWAMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VWAMP>(arg0, 6, b"VWAMP", b"The Vwampire", x"4d656574205657414d502c2074686520626c6f6f64207375636b696e672063617373616e6f7661206f662050756d7073796c76616e69612e0a54656c656772616d203a2068747470733a2f2f742e6d652f5677616d7069726543480a58203a2068747470733a2f2f782e636f6d2f5657414d505355490a576562203a2068747470733a2f2f6261736564736b756c6c67616d65732e636f6d2f7677616d70697265", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241210_015133_53be4da8e4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VWAMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VWAMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

