module 0xe85f67c0d998cff84a54f1c3da98d4cec6e78df3287dd9f62bd4b97b4016b7f5::syn {
    struct SYN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYN>(arg0, 9, b"SYN", b"sync", b"SYN2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ea217acb-1492-4436-aab1-bd3aa1563710.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SYN>>(v1);
    }

    // decompiled from Move bytecode v6
}

