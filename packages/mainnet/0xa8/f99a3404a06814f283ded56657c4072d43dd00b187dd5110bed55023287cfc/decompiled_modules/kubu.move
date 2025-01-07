module 0xa8f99a3404a06814f283ded56657c4072d43dd00b187dd5110bed55023287cfc::kubu {
    struct KUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUBU>(arg0, 9, b"KUBU", b"KucingAbu", b"Vvc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ef3ddfb2-ca60-478f-922c-1f88913593d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KUBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

