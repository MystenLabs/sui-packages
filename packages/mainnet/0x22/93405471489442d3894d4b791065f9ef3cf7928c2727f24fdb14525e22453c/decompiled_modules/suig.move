module 0x2293405471489442d3894d4b791065f9ef3cf7928c2727f24fdb14525e22453c::suig {
    struct SUIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIG>(arg0, 9, b"SUIG", b"SUIGEM", x"53756920697320f09f928e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c6b668e2-f341-4c5d-a9b4-0563a0c2a340.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

