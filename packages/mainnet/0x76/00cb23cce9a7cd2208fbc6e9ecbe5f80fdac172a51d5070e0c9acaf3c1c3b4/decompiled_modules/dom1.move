module 0x7600cb23cce9a7cd2208fbc6e9ecbe5f80fdac172a51d5070e0c9acaf3c1c3b4::dom1 {
    struct DOM1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOM1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOM1>(arg0, 9, b"DOM1", b"Dominion", b"Soccer game is my priority ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a6be391e-2bf0-4a76-9393-16cc1b0146e1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOM1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOM1>>(v1);
    }

    // decompiled from Move bytecode v6
}

