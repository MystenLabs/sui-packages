module 0x1f6bc9ddfa4bdea52e01d5ba59a091360a55855f2f592d499ebfe32d01520b92::mac {
    struct MAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAC>(arg0, 6, b"MAC", b"MacNCheese", x"4d616320262043686565736520206973206e6f77206f6e202353554920234d4f564550554d50204a6f696e206f75722054656c656772616d203a2068747470733a2f2f742e6d652f4d4e435355490a436865636b206f7574206f75722077656273697465212068747470733a2f2f6d61636e6368656573657375692e63617272642e636f2f0a547769747465723a2068747470733a2f2f782e636f6d2f6d61636e636865657365737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/665675_0821b46c09.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

