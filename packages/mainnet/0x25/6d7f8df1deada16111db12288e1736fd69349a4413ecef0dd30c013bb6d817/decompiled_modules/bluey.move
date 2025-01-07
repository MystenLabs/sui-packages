module 0x256d7f8df1deada16111db12288e1736fd69349a4413ecef0dd30c013bb6d817::bluey {
    struct BLUEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEY>(arg0, 6, b"BLUEY", b"Bluey", x"426c7565792069732061206d656d65636f696e20696e7370697265642062792074686520706f70756c6172204175737472616c69616e20636172746f6f6e207468617420666f6c6c6f77732074686520616476656e7475726573206f6620426c7565792c206120636865657266756c20616e6420696d6167696e617469766520426c7565204865656c65722070757070792e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_ab6a3e0d3a_f5fb78eca1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

