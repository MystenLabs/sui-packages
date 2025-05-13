module 0x75558e97a0a0971a7b4ee08760906015a42fd5eb1bd379c8654722eebbaea15e::bbm {
    struct BBM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBM>(arg0, 6, b"BBM", b"Bring Back Movepump", x"4e6f20696e766573746f72732e204e6f20696e7369646572732e4e6f206561726c79206163636573732e0a496620796f757220636f696e207375636b732c20697420646965732e20496620697420736c6170732c20697420666c6965732e204272696e67204261636b204d6f766570756d70", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014808_b12dba9970.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBM>>(v1);
    }

    // decompiled from Move bytecode v6
}

