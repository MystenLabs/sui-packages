module 0x81a7cfc2def9ebcee81e2e01a2457e64634dda6c50a0e9ec00b94423c9233a8c::saphia {
    struct SAPHIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAPHIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAPHIA>(arg0, 9, b"SAPHIA", b"owsaphia", b"Muamuaqua", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ddd96441-7e1c-4bcd-9c32-f24dc4da8d7d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAPHIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAPHIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

