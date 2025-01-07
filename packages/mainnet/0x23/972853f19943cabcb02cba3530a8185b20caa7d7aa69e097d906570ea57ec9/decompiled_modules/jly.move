module 0x23972853f19943cabcb02cba3530a8185b20caa7d7aa69e097d906570ea57ec9::jly {
    struct JLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JLY>(arg0, 9, b"JLY", b"Jelly ", b"Jelly are the cutest animals in the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9506483a-fdd5-4378-85c0-2c4603d2923e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

