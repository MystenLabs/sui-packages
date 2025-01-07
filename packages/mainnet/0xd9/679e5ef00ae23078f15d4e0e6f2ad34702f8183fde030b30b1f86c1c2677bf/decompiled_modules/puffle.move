module 0xd9679e5ef00ae23078f15d4e0e6f2ad34702f8183fde030b30b1f86c1c2677bf::puffle {
    struct PUFFLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFLE>(arg0, 6, b"PUFFLE", b"PUFFLE SUI", b"Puffle on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_19_11_27_52_51e4552287.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFFLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

