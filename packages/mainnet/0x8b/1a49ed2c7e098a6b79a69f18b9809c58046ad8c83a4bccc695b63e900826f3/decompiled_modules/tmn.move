module 0x8b1a49ed2c7e098a6b79a69f18b9809c58046ad8c83a4bccc695b63e900826f3::tmn {
    struct TMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMN>(arg0, 9, b"TMN", b"TIMNAS", b"Persatuan sepak bola indonesia yg selalu akan berkembang.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/22e2788b-1f47-4a56-9301-ff5a00f552fc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

