module 0xa19151943850da5fb2cb99d7c5eff5dad1560a5410b12d7a3dce16c67ca333fd::fu {
    struct FU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FU>(arg0, 6, b"FU", b"Fuck You", x"46552069732061206d656d65636f696e2077697468206e6f207574696c6974792c206e6f20726f61646d61702c20616e64206e6f206675636b7320676976656e2e0a427579206974206f72206675636b206f66662e0a4e6f2054656c656772616d2e0a4e6f20582e0a4e6f20776562736974652e0a4675636b20796f752e204920646f6e7420636172652e0a4e6f20776869746570617065722074616c6b2e0a4e6f20726f61646d6170207175657374696f6e732e0a4e6f20474d73206f6e6c79206675636b206f6666732e0a5765206d6164652074686973206a75737420746f2070697373206f66662070656f706c65206c696b6520796f752e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiezu7tw2uhidqr4saxutyxtbydzlyencowvomwfs7yujlbbfwctq4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

