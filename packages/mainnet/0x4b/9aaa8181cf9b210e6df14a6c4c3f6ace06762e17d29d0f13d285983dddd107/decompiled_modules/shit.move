module 0x4b9aaa8181cf9b210e6df14a6c4c3f6ace06762e17d29d0f13d285983dddd107::shit {
    struct SHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIT>(arg0, 6, b"SHIT", b"FartShit coin", x"24534849542049532041204e455720455241204f462046415254494e472e20412046415254205354524149474854204f5554204f462054484520534849542e205348495420495320544845204f4e4c592057415920544f2053484f57205448452056414c5545204f46204d4f4e45592e204d4f4e455920495320534849542c2053484954204953204d4f4e455920200a4a4f494e2054484953205348495420434f4d4d554e49545920414e44204c45542753204641525420544f4745544845522e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_28_03_09_50_b835d65167.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

