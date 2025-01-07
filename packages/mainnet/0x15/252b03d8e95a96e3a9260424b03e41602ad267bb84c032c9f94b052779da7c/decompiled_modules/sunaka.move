module 0x15252b03d8e95a96e3a9260424b03e41602ad267bb84c032c9f94b052779da7c::sunaka {
    struct SUNAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNAKA>(arg0, 6, b"SUNAKA", b"Sui Nakamigos", x"224e616b616d69676f7327732061206d656d6520746f6b656e206261736564206f6e20746865204e616b616d69676f73204e465420636f6c6c656374696f6e2063726561746564206f6e2053554920436861696e220a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_01_03_19_26_07_6455db723f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNAKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNAKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

