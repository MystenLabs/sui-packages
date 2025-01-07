module 0xbc178836dcdd89b4ac7b6d24c66ad9d39795485936bb5353b7b6a4de3d0f71c2::grums {
    struct GRUMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRUMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRUMS>(arg0, 6, b"GRUMS", b"GRUMS SUI", b"ONLY GRUMS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7125_e7e3fe6d43.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRUMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRUMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

