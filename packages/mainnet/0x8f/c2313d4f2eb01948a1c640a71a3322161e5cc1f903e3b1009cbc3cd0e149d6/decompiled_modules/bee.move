module 0x8fc2313d4f2eb01948a1c640a71a3322161e5cc1f903e3b1009cbc3cd0e149d6::bee {
    struct BEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEE>(arg0, 6, b"BEE", b"BEE ON SUI", x"46697273742024424545206f6e20547572626f730a0a54686520737765657465737420746f6b656e206f6e205375692e204f757220636f6d6d756e69747920697320626f6e6420746f676574686572207769746820686f6e65792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730994976789.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

