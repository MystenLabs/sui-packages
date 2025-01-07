module 0xab63c971568b7779346cac57db0326201fdc8f2abc13907db2f3a7a3377a78b1::wfu {
    struct WFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: WFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WFU>(arg0, 9, b"WFU", b"WAIFU", b"Dfh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ed1b9270-c08c-402b-bf3c-81812951bbc6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WFU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WFU>>(v1);
    }

    // decompiled from Move bytecode v6
}

