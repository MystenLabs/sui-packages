module 0x430a3b0fc73bc20caf44ef1352f6e0b3a680b3085c7c142b03a870ad23d069e8::rugman {
    struct RUGMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUGMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUGMAN>(arg0, 6, b"RUGMAN", b"RUG MAN ON SUI", b"I'm RUGMAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_O_Tw1_T0r_400x400_fdc4023f0b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUGMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUGMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

