module 0xcb86eb969d61caa008dd211e4a3666bc71ab8e6f6fb2439cc0710e3d335b6247::zeuscrypto {
    struct ZEUSCRYPTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEUSCRYPTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEUSCRYPTO>(arg0, 9, b"ZEUSCRYPTO", b"Zeus", b"Pump BTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2aa33dcd-87c6-44ca-84f1-6fb22cfc79af.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEUSCRYPTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZEUSCRYPTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

