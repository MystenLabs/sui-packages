module 0xf545a28f240cd110ed48f660db3651beb22ee63cad10a7370694bd5639d0c9e3::trbs {
    struct TRBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRBS>(arg0, 6, b"TRBS", b"Turbo on Sui", x"4665656c696e67204c656674204f7574206f66207468652043727970746f20487970653f0a446f6e2774204c657420536c6f77205472616e73616374696f6e732046727573747261746520596f752e0a4d697373696e67206f7574206f6e206469676974616c2063757272656e6379206f70706f7274756e69746965732064756520746f2068696768206665657320616e642064656c6179733f204a6f696e206f757220636f6d6d756e69747920776865726520666173742c206c6f772d636f7374207472616e73616374696f6e732061726520746865206e6f726d2c20616e642066756e206973206e6576657220636f6d70726f6d697365642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/unnamed_removebg_preview_6f12807f03.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

