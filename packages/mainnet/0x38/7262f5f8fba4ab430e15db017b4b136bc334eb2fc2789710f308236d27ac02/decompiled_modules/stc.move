module 0x387262f5f8fba4ab430e15db017b4b136bc334eb2fc2789710f308236d27ac02::stc {
    struct STC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STC>(arg0, 9, b"STC", b"Starkcoin", b"I want to make great change in crypto world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7aa267e9-3148-4106-8c58-adbd8772f8b8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STC>>(v1);
    }

    // decompiled from Move bytecode v6
}

