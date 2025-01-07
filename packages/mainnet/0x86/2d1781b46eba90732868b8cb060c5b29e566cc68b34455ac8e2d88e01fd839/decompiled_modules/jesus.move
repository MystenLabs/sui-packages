module 0x862d1781b46eba90732868b8cb060c5b29e566cc68b34455ac8e2d88e01fd839::jesus {
    struct JESUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JESUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JESUS>(arg0, 6, b"Jesus", b"Jesus On Sui", b"The mission of $JesusOnSui is to influence culture and bring light into dark places on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_07_at_22_38_26_e407262724.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JESUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JESUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

