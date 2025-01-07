module 0xc98649dca314c4fd291cc6e2d480aa12f732b849d5877d41bde8a80df81af832::whuile {
    struct WHUILE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHUILE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHUILE>(arg0, 6, b"WHUILE", b"Whuile", b"Maving waves on Sui! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_09_17_at_6_03_18_PM_eb9bb67501.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHUILE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHUILE>>(v1);
    }

    // decompiled from Move bytecode v6
}

