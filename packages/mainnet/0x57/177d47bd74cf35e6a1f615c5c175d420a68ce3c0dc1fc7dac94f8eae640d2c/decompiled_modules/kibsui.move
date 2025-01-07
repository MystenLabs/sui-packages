module 0x57177d47bd74cf35e6a1f615c5c175d420a68ce3c0dc1fc7dac94f8eae640d2c::kibsui {
    struct KIBSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIBSUI>(arg0, 6, b"KIBSUI", b"KIBOSUI", b"KIBOSHIB on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7330_06e9f02c21.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIBSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIBSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

