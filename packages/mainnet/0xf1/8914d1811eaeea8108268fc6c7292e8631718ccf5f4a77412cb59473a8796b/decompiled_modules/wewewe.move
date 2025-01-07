module 0xf18914d1811eaeea8108268fc6c7292e8631718ccf5f4a77412cb59473a8796b::wewewe {
    struct WEWEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWEWE>(arg0, 9, b"WEWEWE", x"4dc3aa6d6d656e65", b"Nxnxjxjxnjx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f6b5b00f-4606-47e6-aaf4-bafe339fe3be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

