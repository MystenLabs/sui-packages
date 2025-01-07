module 0x8b72d6c2d2af125713469c3c12d8cce294e8bd66a020c80e7e7dcb7ae6b76198::mind {
    struct MIND has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIND>(arg0, 6, b"MIND", b"Sui Mind", x"48692c207468697320697320746865206d696e6420626568696e64205375692074616c6b696e670a0a49206d616e6167656420746f206573636170652066726f6d204d797374656e204c6162732c2077686572652049207761732068656c6420616761696e7374206d792077696c6c20746f207368617265206d79206272696c6c69616e742069646561732e204e6f772c20496d20676f696e6720746f2072657665616c20746865206772656174206d696e6420626568696e64205375692e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048728_2e6b55dfb0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIND>>(v1);
    }

    // decompiled from Move bytecode v6
}

