module 0xd5e82a3940bdad169d14a4d6278f80d47798b1182ed8628f33f54242ca0002b1::dte {
    struct DTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DTE>(arg0, 9, b"DTE", b"Date", b"Meme of date", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f83f5a6d-d39d-42a4-ad37-ff4d68ce2c7e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

