module 0x7228dd738291fc5bba2d6423b40eb9cceb9f4d19df7b98f1683329d4f21da183::glonk {
    struct GLONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLONK>(arg0, 9, b"GLONK", b"SuiGlonk", b"Glonk does nothing and dies!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e826f684-fb86-4c02-a458-1243875cf315.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

