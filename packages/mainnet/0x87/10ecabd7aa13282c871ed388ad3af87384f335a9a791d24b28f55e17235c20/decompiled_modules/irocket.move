module 0x8710ecabd7aa13282c871ed388ad3af87384f335a9a791d24b28f55e17235c20::irocket {
    struct IROCKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: IROCKET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IROCKET>(arg0, 6, b"IRocket", b"Iranian Rocket", b"Allah hu Akbar ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_02_at_12_59_04_57b1d4ac04.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IROCKET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IROCKET>>(v1);
    }

    // decompiled from Move bytecode v6
}

