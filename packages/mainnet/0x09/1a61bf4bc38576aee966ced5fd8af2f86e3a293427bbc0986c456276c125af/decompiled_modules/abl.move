module 0x91a61bf4bc38576aee966ced5fd8af2f86e3a293427bbc0986c456276c125af::abl {
    struct ABL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABL>(arg0, 9, b"ABL", b"ALBA", b"BOUTIC ALBA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4336e939-3099-4df6-98de-ec65b4989a93.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABL>>(v1);
    }

    // decompiled from Move bytecode v6
}

