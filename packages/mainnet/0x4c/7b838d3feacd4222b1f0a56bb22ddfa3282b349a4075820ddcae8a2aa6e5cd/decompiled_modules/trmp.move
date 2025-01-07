module 0x4c7b838d3feacd4222b1f0a56bb22ddfa3282b349a4075820ddcae8a2aa6e5cd::trmp {
    struct TRMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRMP>(arg0, 9, b"TRMP", b"TRUMP", b"Build community of Trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f6d892fa-07ce-4bf6-abb7-d6f6e4ed0038.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

