module 0x8d2873b6ce7d812d13e88f7ffabe5baa3bbe67119a39add5c11fb96b6f38b625::mxpr {
    struct MXPR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MXPR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MXPR>(arg0, 9, b"MXPR", b"MaxPro", b"Maximum Proffesional token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/07e1cfef-28db-4aec-95f4-5e8498f03d80.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MXPR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MXPR>>(v1);
    }

    // decompiled from Move bytecode v6
}

