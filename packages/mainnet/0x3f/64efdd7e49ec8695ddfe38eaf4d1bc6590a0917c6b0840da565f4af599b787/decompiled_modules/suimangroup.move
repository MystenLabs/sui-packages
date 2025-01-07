module 0x3f64efdd7e49ec8695ddfe38eaf4d1bc6590a0917c6b0840da565f4af599b787::suimangroup {
    struct SUIMANGROUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMANGROUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMANGROUP>(arg0, 6, b"SUIMANGROUP", b"Sui Man Group", x"4d656574207468652069636f6e696320426c7565204d616e2047726f75702c20245355494d414e47524f5550206272696e67732072687974686d2c20637265617469766974792c20616e6420616e206f74686572776f726c646c79207669626520746f2074686520537569204e6574776f726b2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_11_08_at_20_04_30_8f0bfeb01f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMANGROUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMANGROUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

