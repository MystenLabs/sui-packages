module 0xb88442e575843f6b6fe71ae03108df09b0249dc0f347acb6a6a1c9dac3872cc5::anns {
    struct ANNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANNS>(arg0, 9, b"ANNS", b"annaclothi", b"ANNAXCFF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b2090f21-4d78-485c-9d5a-8839dd16630e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

