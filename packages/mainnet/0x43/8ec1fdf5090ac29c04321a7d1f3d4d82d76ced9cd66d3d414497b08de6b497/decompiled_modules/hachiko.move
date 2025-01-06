module 0x438ec1fdf5090ac29c04321a7d1f3d4d82d76ced9cd66d3d414497b08de6b497::hachiko {
    struct HACHIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HACHIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HACHIKO>(arg0, 6, b"HACHIKO", b"Hachiko Sui", x"48616368696b6f205761697473206279204c65736c61204e65776d616e2069732061206368696c6472656e277320626f6f6b2061626f757420746865206c6f79616c20416b6974612c2048616368696b6f2c20746f6c64207468726f756768207468652065796573206f66206120626f79206e616d6564204b656e7461726f2e0a0a576562736974653a2068747470733a2f2f68616368696b6f7375692e776562736974650a547769747465723a2068747470733a2f2f782e636f6d2f48616368696b6f5375690a54656c656772616d3a2068747470733a2f2f742e6d652f48616368696b6f537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250107_010358_166_eb9fac017e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HACHIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HACHIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

