module 0xa200b8430ea1354de9f6a853cfb5cf1fb8312bc3da8a94a0f53cc87735d4f440::seven {
    struct SEVEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEVEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEVEN>(arg0, 9, b"SEVEN", b"777", b"A selected number 777", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f6241874-af13-473f-83e7-4945dc4d1b91.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEVEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEVEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

