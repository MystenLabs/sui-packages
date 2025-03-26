module 0xae646236d718a4a8b83da338c0280c1754a5f02e6243e6a20d7474e7c5e1e266::pibit {
    struct PIBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIBIT>(arg0, 9, b"PIBIT", b"pinkRabbit", b"FOLLOW THE PINK RABBIT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bb02c7b6-f789-4ca3-b28d-59bd8cfdedfc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIBIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

