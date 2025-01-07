module 0xef3e11293b23912041e983481ce3d2a74f010ad3510cde3f25a46b3f04eda9fc::ggpanda {
    struct GGPANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGPANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGPANDA>(arg0, 9, b"GGPANDA", b"GiglePanda", x"5761726e696e673a0a4769676c6550616e6461206973206120707572656c79206d656d652d62617365642063727970746f63757272656e6379206372656174656420666f7220656e7465727461696e6d656e7420707572706f7365732e20497420686173206e6f206f6666696369616c2070726f6a6563742c207465616d2c206f7220726f61646d61702e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/37875e4d-27fa-4b94-bd6d-654c9a804a60.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGPANDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GGPANDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

