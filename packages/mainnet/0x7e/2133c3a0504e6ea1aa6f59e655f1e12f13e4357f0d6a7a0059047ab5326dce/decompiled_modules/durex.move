module 0x7e2133c3a0504e6ea1aa6f59e655f1e12f13e4357f0d6a7a0059047ab5326dce::durex {
    struct DUREX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUREX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUREX>(arg0, 9, b"DUREX", b"CONDOM", b"CONDOM for everyone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b28ef2d1-9b96-466e-a462-93181e43a516.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUREX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUREX>>(v1);
    }

    // decompiled from Move bytecode v6
}

