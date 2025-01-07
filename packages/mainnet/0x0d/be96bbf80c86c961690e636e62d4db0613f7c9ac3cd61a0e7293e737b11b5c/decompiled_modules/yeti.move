module 0xdbe96bbf80c86c961690e636e62d4db0613f7c9ac3cd61a0e7293e737b11b5c::yeti {
    struct YETI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YETI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YETI>(arg0, 6, b"YETI", b"YETI ON SUI", x"59657469206973206120626f6c6420616476656e74757265722c206c656164696e67206120636861726765207468726f7567682074686520696379207265616c6d73206f662063727970746f2c2063617276696e672061207061746820666f722074686520636f6d6d756e69747920746f207269736520616e6420636f6e717565722e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/j_H85_Cegq_400x400_6679c1db04.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YETI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YETI>>(v1);
    }

    // decompiled from Move bytecode v6
}

