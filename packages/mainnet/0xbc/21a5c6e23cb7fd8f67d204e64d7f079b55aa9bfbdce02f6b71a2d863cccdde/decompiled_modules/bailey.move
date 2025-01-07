module 0xbc21a5c6e23cb7fd8f67d204e64d7f079b55aa9bfbdce02f6b71a2d863cccdde::bailey {
    struct BAILEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAILEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAILEY>(arg0, 6, b"BAILEY", b"Bailey Sui", x"244261696c65792049730a4e6f77204f6e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000432_9b4b496be1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAILEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAILEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

