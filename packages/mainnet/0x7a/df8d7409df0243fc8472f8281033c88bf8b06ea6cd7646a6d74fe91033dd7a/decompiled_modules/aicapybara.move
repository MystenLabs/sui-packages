module 0x7adf8d7409df0243fc8472f8281033c88bf8b06ea6cd7646a6d74fe91033dd7a::aicapybara {
    struct AICAPYBARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AICAPYBARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AICAPYBARA>(arg0, 9, b"AICAPYBARA", b"AICAPY", b"A Capy bara in Sui world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/94d47b05-5b30-469e-9cc2-2ca501b428cc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AICAPYBARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AICAPYBARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

