module 0x89b475f2fc5b7573d4e4c8c12744bbfd669d713cb1a0558fea3241dc8b24974f::shusky {
    struct SHUSKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUSKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUSKY>(arg0, 9, b"SHUSKY", b"Sui Husky", x"536875736b792069732074686520666972737420616e64206f6e6c79206875736b79206f6e2074686520537569206e6574776f726b20f09f9095e2808df09fa6ba204b6e6f776e20666f722068697320667269656e646c7920616e6420706c617966756c206e61747572652c20536875736b7920697320612073796d626f6c206f6620636f6d6d756e69747920616e6420746f6765746865726e65737320f09fa49d204865e2809973206e6f74206865726520746f2072616365", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1840376256275345408/DigmV9nh.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHUSKY>(&mut v2, 345000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUSKY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHUSKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

