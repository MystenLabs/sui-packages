module 0x7470d77110731623eac249bbb463dec50e6fede0d2bc363eede5288f5a6fd08d::eter {
    struct ETER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETER>(arg0, 6, b"ETER", b"eternauta on sui", b"Do you dare to accompany this character throughout the entire series? Follow him on Netflix and discover this great adventure.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_2_b1bde1f0a9.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETER>>(v1);
    }

    // decompiled from Move bytecode v6
}

