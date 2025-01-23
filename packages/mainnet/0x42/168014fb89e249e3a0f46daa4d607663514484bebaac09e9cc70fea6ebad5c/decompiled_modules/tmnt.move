module 0x42168014fb89e249e3a0f46daa4d607663514484bebaac09e9cc70fea6ebad5c::tmnt {
    struct TMNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMNT>(arg0, 6, b"TMNT", b"TMNT on Sui", x"4765742072656164792c20547572746c65732066616e73210a4a6f696e204c656f6e6172646f2c204d696368656c616e67656c6f2c20446f6e6174656c6c6f2c20616e64205261706861656c2061732074686579206272696e67207468656972206e696e6a6120736b696c6c7320616e642070697a7a612d6c6f76696e6720616e7469637320746f207468652073756920626c6f636b636861696e2e200a544d4e5420697320746865207469636b657221204368616473206275696c64696e67206f6e205375692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737596405395.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TMNT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMNT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

