module 0x99295fb1c54c4e3173e77c899f08b4a99dd97aabc4f60f0521b320f4566286ce::zss {
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

