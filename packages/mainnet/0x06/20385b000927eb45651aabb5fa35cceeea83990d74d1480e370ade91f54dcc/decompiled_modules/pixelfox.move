module 0x620385b000927eb45651aabb5fa35cceeea83990d74d1480e370ade91f54dcc::pixelfox {
    struct PIXELFOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIXELFOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIXELFOX>(arg0, 6, b"PIXELFOX", b"Pixel Fox", x"5374696c6c20776f6e646572696e6720776861742074686520666f7820736179733f0a0a504958454c464f58206973206865726520746f20616e737765722e20200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gk_G8_Y3_NWQAAN_Jh_X_b196638880.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIXELFOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIXELFOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

