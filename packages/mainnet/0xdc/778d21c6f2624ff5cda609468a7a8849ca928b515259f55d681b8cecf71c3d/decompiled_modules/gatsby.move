module 0xdc778d21c6f2624ff5cda609468a7a8849ca928b515259f55d681b8cecf71c3d::gatsby {
    struct GATSBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GATSBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GATSBY>(arg0, 6, b"GATSBY", b"Elon's First Dog", x"456c6f6e7320466972737420446f670a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_30_00_36_35_82a45adb88.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GATSBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GATSBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

