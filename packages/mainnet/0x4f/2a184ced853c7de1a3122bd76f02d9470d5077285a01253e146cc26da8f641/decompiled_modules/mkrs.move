module 0x4f2a184ced853c7de1a3122bd76f02d9470d5077285a01253e146cc26da8f641::mkrs {
    struct MKRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MKRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MKRS>(arg0, 6, b"MKRS", b"Monkey Red Sui", x"5374657020696e746f20746865204b696e67646f6d206f6620746865204d6f6e6b6579204b696e672c20776865726520647265616d732069676e6974652e0a0a466f7274756e657320726973652c20616e64207468652050554d5021212120697320756e73746f707061626c65212020456d627261636520746865206a6f75726e657920616e6420776174636820746865206d6167696320756e666f6c6421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_b0596aeeaa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MKRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MKRS>>(v1);
    }

    // decompiled from Move bytecode v6
}

