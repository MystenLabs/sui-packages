module 0x21c6960a67c1dee4f92f25200002a1b1cc5b99cf80afeade466520462a72b279::husky {
    struct HUSKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUSKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUSKY>(arg0, 9, b"HUSKY", b"SuiHusky", x"426875736b792069732074686520666972737420616e64206f6e6c79206875736b79206f6e2074686520537569206e6574776f726b20f09f9095e2808df09fa6ba204b6e6f776e20666f722068697320667269656e646c7920616e6420706c617966756c206e61747572652c20426875736b7920697320612073796d626f6c206f6620636f6d6d756e69747920616e6420746f6765746865726e65737320f09fa49d204865e2809973206e6f74206865726520746f2072616365e280946865e2809973206865726520746f206272696e672070656f706c6520746f6765746865722c206d616b696e672063727970746f2061206d6f726520656e6a6f7961626c6520616e642072656c617461626c6520657870657269656e636520f09f9881", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x20895e16d5ae9d6e0ca127ed093a7cbe65dcb018.png?size=xl&key=49ef30")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HUSKY>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUSKY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUSKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

