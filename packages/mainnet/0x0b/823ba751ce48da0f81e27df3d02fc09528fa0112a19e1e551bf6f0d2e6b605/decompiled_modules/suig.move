module 0xb823ba751ce48da0f81e27df3d02fc09528fa0112a19e1e551bf6f0d2e6b605::suig {
    struct SUIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIG>(arg0, 9, b"SUIG", b"SUIGEM", x"53756920697320f09f928e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2a4c62b3-80e9-46e8-872a-48487ced90bf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

