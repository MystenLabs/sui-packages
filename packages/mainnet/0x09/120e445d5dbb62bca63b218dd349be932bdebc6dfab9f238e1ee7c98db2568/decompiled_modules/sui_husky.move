module 0x9120e445d5dbb62bca63b218dd349be932bdebc6dfab9f238e1ee7c98db2568::sui_husky {
    struct SUI_HUSKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_HUSKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_HUSKY>(arg0, 9, b"Sui Husky", b"SHUSKY", x"537569206875736b792069732074686520666972737420616e64206f6e6c79206875736b79206f6e2074686520537569206e6574776f726b20f09f9095e2808df09fa6ba204b6e6f776e20666f722068697320667269656e646c7920616e6420706c617966756c206e61747572652c20537569206875736b7920697320612073796d626f6c206f6620636f6d6d756e69747920616e6420746f6765746865726e65737320f09fa49d204865e2809973206e6f74206865726520746f2072616365", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1840376256275345408/DigmV9nh.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_HUSKY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_HUSKY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_HUSKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

