module 0x61f4788761b1595bb281eba06690ce7d6d3e06ffb3587d69612d5ef38701be20::brain {
    struct BRAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRAIN>(arg0, 6, b"BRAIN", b"brainlet", x"6a75737420616e6f7468657220627261696e6c6574206f6e2073756920212073656e642069742121210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20241005_225356_5eb2e69112.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

