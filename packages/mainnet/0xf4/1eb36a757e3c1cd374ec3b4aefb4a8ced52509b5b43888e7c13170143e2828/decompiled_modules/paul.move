module 0xf41eb36a757e3c1cd374ec3b4aefb4a8ced52509b5b43888e7c13170143e2828::paul {
    struct PAUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAUL>(arg0, 9, b"PAUL", b"Nyoman", b"Penyanyi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ccfed6da-5311-46af-905e-6abe67785a21.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

