module 0x8ce9e6adf4cf7d296d8ea4e1dd5b7d7442db03d63ad2a75a522d5bcbde80f85::wfu {
    struct WFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: WFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WFU>(arg0, 9, b"WFU", b"WAIFU", b"Dfh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/226e8e95-d821-4bcd-9682-b47c2f7b7039.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WFU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WFU>>(v1);
    }

    // decompiled from Move bytecode v6
}

