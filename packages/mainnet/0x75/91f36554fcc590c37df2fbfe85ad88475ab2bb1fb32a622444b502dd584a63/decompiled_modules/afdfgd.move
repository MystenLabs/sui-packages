module 0x7591f36554fcc590c37df2fbfe85ad88475ab2bb1fb32a622444b502dd584a63::afdfgd {
    struct AFDFGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFDFGD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFDFGD>(arg0, 9, b"AFDFGD", b"hfgh", b"fgfg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fdfdbe7e-de82-428a-9af6-9aa2b84e6ed9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFDFGD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AFDFGD>>(v1);
    }

    // decompiled from Move bytecode v6
}

