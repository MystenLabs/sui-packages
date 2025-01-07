module 0x3985112e448fed962dbc64234056354cd8a1bbde8ac7727e3a8721c85269cf66::dmn {
    struct DMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMN>(arg0, 9, b"DMN", b"Demon", b"Demon token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3879e2b5-e05f-4376-b883-55673a474a23.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

