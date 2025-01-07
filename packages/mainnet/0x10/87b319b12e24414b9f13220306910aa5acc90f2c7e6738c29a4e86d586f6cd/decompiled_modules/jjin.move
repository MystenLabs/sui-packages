module 0x1087b319b12e24414b9f13220306910aa5acc90f2c7e6738c29a4e86d586f6cd::jjin {
    struct JJIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JJIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JJIN>(arg0, 6, b"JJin", b"JinJin on sui", b"$JinJin The Golden Cat ||", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_Jy6c9p_W_400x400_0cd8ba688b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JJIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JJIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

