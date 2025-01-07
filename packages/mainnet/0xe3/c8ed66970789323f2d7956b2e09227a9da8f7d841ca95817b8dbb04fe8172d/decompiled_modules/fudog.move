module 0xe3c8ed66970789323f2d7956b2e09227a9da8f7d841ca95817b8dbb04fe8172d::fudog {
    struct FUDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUDOG>(arg0, 6, b"FUDOG", b"FU DOG", x"596f7572204c696f6e20446f6720477561726469616e0a426f726e2066726f6d20746865206c6567656e6473206f6620616e6369656e74204368696e612c20467520446f67207374616e64732061732074686520756c74696d61746520677561726469616e2e0a0a636f6d6d756e6974792077696c6c20666f726d20616674657220626f6e64696e672077697468206465780a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_20_22_53_08_6847b61338.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

