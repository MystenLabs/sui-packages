module 0x1e8c0a9fc714397ede24b0360cebf2641f2ad6275bd15561f19f5daf736e10b3::glonk {
    struct GLONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLONK>(arg0, 9, b"GLONK", b"SuiGlonk", b"Glonk does nothing and dies!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e9065edb-3371-4c0a-a36e-466647903b0d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

