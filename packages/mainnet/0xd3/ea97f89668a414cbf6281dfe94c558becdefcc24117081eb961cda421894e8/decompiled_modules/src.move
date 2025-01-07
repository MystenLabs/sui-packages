module 0xd3ea97f89668a414cbf6281dfe94c558becdefcc24117081eb961cda421894e8::src {
    struct SRC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRC>(arg0, 6, b"SRC", b"Sui Rabbit Coin", x"436f6d6d756e69747920546f6b656e202d204e6f20666f756e646572202d204e6f74206d656d650a526f616420746f20314d204d432078313030", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ob_Vc_XRT_400x400_0b7302a07f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRC>>(v1);
    }

    // decompiled from Move bytecode v6
}

