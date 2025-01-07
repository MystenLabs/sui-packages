module 0xb51e206be7dfba9aeac5c9846794b1f63f061a331016cc54e652facf3819632d::tea {
    struct TEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEA>(arg0, 9, b"TEA", b"1teaglass", b"Soothing and invigorating", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6970ec48-fd3f-4ef5-b166-ceb1cc3c88a4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

