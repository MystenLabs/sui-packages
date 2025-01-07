module 0xc11575fa6c1c60b12cd01d87c27ecc2fab48a98e439679a3d7e4c96bdd14e7dd::glonk {
    struct GLONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLONK>(arg0, 9, b"GLONK", b"SuiGlonk", b"Glonk does nothing and dies!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5f6c98dc-a644-48f8-9ef5-0ebe564ae2d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

