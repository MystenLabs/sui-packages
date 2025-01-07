module 0x964101fcef576e7587b49e7a3e1c4dcbeaa53febbd3fe52e42b447b826453f4a::khong {
    struct KHONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHONG>(arg0, 6, b"KHONG", b"Khong Gua", x"4b484f4e47206973206d656d6520746f6b656e0a225a65726f20746f204865726f2e220a43616e206974207265616c6c792068617070656e3f204c657427732070726f766520697420746f6765746865722021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_22_at_05_31_01_0352f8a4da.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KHONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KHONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

