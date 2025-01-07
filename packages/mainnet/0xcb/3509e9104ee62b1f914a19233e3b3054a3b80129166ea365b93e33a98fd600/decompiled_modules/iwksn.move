module 0xcb3509e9104ee62b1f914a19233e3b3054a3b80129166ea365b93e33a98fd600::iwksn {
    struct IWKSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: IWKSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IWKSN>(arg0, 9, b"IWKSN", b"dnnsb", b"adqv ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ed649b8b-4465-4c1c-8570-887ca61c2cab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IWKSN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IWKSN>>(v1);
    }

    // decompiled from Move bytecode v6
}

