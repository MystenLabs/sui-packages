module 0xfebc6999e3d330e36cbbcffbf8c5417527ca30e651dc1af0587ff8123ecc15ed::jmine {
    struct JMINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JMINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JMINE>(arg0, 9, b"JMINE", b"Jauwalmini", b"For birthday party celebrating", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5c12d426-6d92-49cd-b36b-8a39627bc07e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JMINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JMINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

