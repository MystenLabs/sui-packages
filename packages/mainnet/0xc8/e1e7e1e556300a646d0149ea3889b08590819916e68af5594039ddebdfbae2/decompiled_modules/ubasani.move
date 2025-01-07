module 0xc8e1e7e1e556300a646d0149ea3889b08590819916e68af5594039ddebdfbae2::ubasani {
    struct UBASANI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UBASANI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UBASANI>(arg0, 9, b"UBASANI", b"Uba", b"Crypto ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0f634d76-fec0-460b-a498-7c4c90aaf5f9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UBASANI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UBASANI>>(v1);
    }

    // decompiled from Move bytecode v6
}

