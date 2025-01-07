module 0x11f036a275e42d7746480f900a015e8b558b017d68188c2a23039ac91389283f::bgbgbg {
    struct BGBGBG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BGBGBG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BGBGBG>(arg0, 9, b"BGBGBG", b"GBBGBG", b"BGBGBGBGBG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cd91fcb6-618e-40bb-90db-50962827a010.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BGBGBG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BGBGBG>>(v1);
    }

    // decompiled from Move bytecode v6
}

