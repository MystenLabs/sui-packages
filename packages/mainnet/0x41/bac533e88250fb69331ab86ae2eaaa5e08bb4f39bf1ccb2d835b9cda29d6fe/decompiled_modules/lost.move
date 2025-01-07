module 0x41bac533e88250fb69331ab86ae2eaaa5e08bb4f39bf1ccb2d835b9cda29d6fe::lost {
    struct LOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOST>(arg0, 9, b"LOST", b"ZOR", b"Who?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/30e5e6bc-4918-4f8c-a92f-ae9da24df3f1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOST>>(v1);
    }

    // decompiled from Move bytecode v6
}

