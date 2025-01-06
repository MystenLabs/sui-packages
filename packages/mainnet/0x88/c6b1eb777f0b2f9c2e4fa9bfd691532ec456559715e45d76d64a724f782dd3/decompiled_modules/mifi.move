module 0x88c6b1eb777f0b2f9c2e4fa9bfd691532ec456559715e45d76d64a724f782dd3::mifi {
    struct MIFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIFI>(arg0, 6, b"MIFI", b"Mifi on Sui", x"244d49464920474f542043544f454420425920534f4d45204348414453202c204954275320544845204e455854204d49434849204f4620535549200a0a7765623a2068747470733a2f2f6d6966696f6e7375692e66756e0a0a74673a2068747470733a2f2f742e6d652f6d6966696f6e7375690a0a783a2068747470733a2f2f782e636f6d2f6d6966696f6e737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250106_233603_830_49a913b0a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

