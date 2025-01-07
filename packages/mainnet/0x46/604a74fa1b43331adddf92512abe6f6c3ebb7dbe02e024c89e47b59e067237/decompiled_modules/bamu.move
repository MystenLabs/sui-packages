module 0x46604a74fa1b43331adddf92512abe6f6c3ebb7dbe02e024c89e47b59e067237::bamu {
    struct BAMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAMU>(arg0, 6, b"BAMU", b"BANANA MOON DUCK", x"57656c636f6d6520746f207468652077696c6420776f726c64206f66202442414d55212020412062616e616e612d6c6f76696e67206475636b20666c79696e6720746f20746865206d6f6f6e202e204a6f696e2074686973206372617a7920726964652066756c6c206f662066756e2c206d656d65732c20616e6420706f74656e7469616c206d6f6f6e73686f74206761696e732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Vycq9_Mu_Q_400x400_bfaf51d6d6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

