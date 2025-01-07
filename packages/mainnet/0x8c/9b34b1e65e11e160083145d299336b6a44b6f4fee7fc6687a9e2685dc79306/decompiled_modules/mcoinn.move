module 0x8c9b34b1e65e11e160083145d299336b6a44b6f4fee7fc6687a9e2685dc79306::mcoinn {
    struct MCOINN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCOINN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCOINN>(arg0, 9, b"MCOINN", b"Mcoin", b"Mcoin trading", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3299be56-806d-49a4-be11-045eaed20641.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCOINN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCOINN>>(v1);
    }

    // decompiled from Move bytecode v6
}

