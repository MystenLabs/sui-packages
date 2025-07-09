module 0x6091acf28cbf22d63042deb0e467cd923fa68683fe57fb2dd4a8d9ebb77c546a::phani {
    struct PHANI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHANI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHANI>(arg0, 6, b"Phani", b"PoohNani", x"e2809c57696e6e69652074686520506f6f68e2809d206772616e646d6f7468657221205468697320746f6b656e20697320696e7370697265642066726f6d206120646164e2809973206a6f6b6520616e64206973206372656174656420746f206272696e672066756e20696e746f207468652063727970746f20737061636520616e642070757420736d696c6573206f6e20616c6c206d656d6520646567656e73206f75742074686572652e205468657265206973206e6f20582c6e6f2054656c656772616d2c20776562736974652e20496e20746865206675747572652d77686f206b6e6f77733f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1752068002727.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PHANI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHANI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

