module 0x5cb85c02c9b113a7439d2a8a9504e1ce45ec3b01b8184c8cd23fbaa9d248c79c::jda {
    struct JDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: JDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JDA>(arg0, 9, b"JDA", b"Jidan", b"memme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dc503a22-8809-4794-b6ec-cb3139d5e099.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

