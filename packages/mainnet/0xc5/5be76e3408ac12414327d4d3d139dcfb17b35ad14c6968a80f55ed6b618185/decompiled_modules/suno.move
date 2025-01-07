module 0xc55be76e3408ac12414327d4d3d139dcfb17b35ad14c6968a80f55ed6b618185::suno {
    struct SUNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNO>(arg0, 6, b"SUNO", b"Sui UNO", x"2453554e4f202d20466972737420636172642067616d65206f6e205375692e0a446f6e74206d697373206f7574206f6e20796f7572206368616e636520746f20706c617920616e64206561726e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_677d3433c5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNO>>(v1);
    }

    // decompiled from Move bytecode v6
}

