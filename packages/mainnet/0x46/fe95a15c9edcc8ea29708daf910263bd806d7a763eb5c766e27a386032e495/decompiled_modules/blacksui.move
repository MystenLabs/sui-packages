module 0x46fe95a15c9edcc8ea29708daf910263bd806d7a763eb5c766e27a386032e495::blacksui {
    struct BLACKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACKSUI>(arg0, 9, b"BLACKSUI", b"BLACK SUI", b"SUI Black Edition. Shadow of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d35b02c5-5046-4a87-92b8-ccfb3c9db57d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLACKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

