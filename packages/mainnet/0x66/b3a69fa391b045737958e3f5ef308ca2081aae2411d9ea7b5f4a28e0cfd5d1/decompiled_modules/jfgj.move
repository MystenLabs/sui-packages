module 0x66b3a69fa391b045737958e3f5ef308ca2081aae2411d9ea7b5f4a28e0cfd5d1::jfgj {
    struct JFGJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: JFGJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JFGJ>(arg0, 9, b"JFGJ", b"JFJ", b"DHDF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e5af475a-35ec-4a07-bf9e-6f25c0645e93.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JFGJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JFGJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

