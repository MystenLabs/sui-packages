module 0x4de7dabed7c4739b1b7bcc1b5ecab1426a0abc3cbde25040996417c513ea82c4::neko {
    struct NEKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEKO>(arg0, 6, b"NEKO", b"NANIEKO SUI", x"48657920446567656e73212049276d204e616e69652c20736f6c6f206d656d6520746f6b656e2063726561746f7220616e6420324420616e696d61746f722049206272696e6720746865206d616769630a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IXS_Ipt_Q5_400x400_1651733803.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

