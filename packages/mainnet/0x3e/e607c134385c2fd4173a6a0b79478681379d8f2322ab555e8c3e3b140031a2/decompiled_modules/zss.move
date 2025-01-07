module 0x3ee607c134385c2fd4173a6a0b79478681379d8f2322ab555e8c3e3b140031a2::zss {
    struct ZSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZSS>(arg0, 6, b"Zss", b"AlexBecker", b"If you want to be truly great. Your max potential.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_09_28_18_05_28_234e24cdd4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

