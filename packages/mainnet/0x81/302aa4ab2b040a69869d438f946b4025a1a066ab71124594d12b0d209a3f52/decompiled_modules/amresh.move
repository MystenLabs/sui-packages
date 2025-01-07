module 0x81302aa4ab2b040a69869d438f946b4025a1a066ab71124594d12b0d209a3f52::amresh {
    struct AMRESH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMRESH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMRESH>(arg0, 9, b"AMRESH", b"Amresh", b"Infusion pump ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/787ab2f4-5e2f-49c7-b4b8-f6c6a7b40803.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMRESH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMRESH>>(v1);
    }

    // decompiled from Move bytecode v6
}

