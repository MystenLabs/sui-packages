module 0xcfd605af852481aa74c2f6267b2600e92b0821e5f351f19c86904ca662ffe0d3::cave {
    struct CAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAVE>(arg0, 9, b"CAVE", b"Cave", b"meme cave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a6e3df44-6429-40ce-9508-31d665c6e8c8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

