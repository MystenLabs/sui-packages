module 0xed0fa00ae8e690c3d266f264e8f2fd3165e36340638feda91cd50a2ab5af7466::mnc {
    struct MNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNC>(arg0, 6, b"MNC", b"MacNCheese", x"57656c636f6d6520746f2061206368656573792070726f6a656374206469726563746c792066726f6d207468652063686565737920646570746873206f662074686520537569204e6574776f726b2e0a0a596f2120204a6f696e207468652054656c656772616d212068747470733a2f2f742e6d652f6d61636e6368656573655f7375690a4a6f696e206f7572207477697474657221202068747470733a2f2f782e636f6d2f6d61636e6368656573657375690a416e6420636865636b206f7574206f7572207765627369746521202068747470733a2f2f6d61636e6368656573657375692e63617272642e636f2f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_8a025ac610.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MNC>>(v1);
    }

    // decompiled from Move bytecode v6
}

