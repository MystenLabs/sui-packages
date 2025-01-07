module 0xc6ea04d1579016558f89cc90666f64f988cd57d4680a1f0c5dc837c6133c4d8::jibson {
    struct JIBSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIBSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIBSON>(arg0, 9, b"JIBSON", b"Jibril", b"Gibson yoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/01932a80-99ed-4d6a-aba6-b177e1d95225.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIBSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JIBSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

