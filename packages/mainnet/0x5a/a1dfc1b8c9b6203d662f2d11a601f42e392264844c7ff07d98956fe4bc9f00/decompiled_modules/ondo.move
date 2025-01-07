module 0x5aa1dfc1b8c9b6203d662f2d11a601f42e392264844c7ff07d98956fe4bc9f00::ondo {
    struct ONDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONDO>(arg0, 6, b"ONDO", b"Ondo on Sui", x"5468652031737420244f6e646f206465706c6f796564206f6e205375692c20636f6d6d756e6974792d6d616e616765642e0a5468652068656972206170706172656e74202e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/O_O_O_U_U_O_U_3_fc89abba79.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

