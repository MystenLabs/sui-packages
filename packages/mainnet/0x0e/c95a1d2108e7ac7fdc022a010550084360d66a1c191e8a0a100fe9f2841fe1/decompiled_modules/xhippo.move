module 0xec95a1d2108e7ac7fdc022a010550084360d66a1c191e8a0a100fe9f2841fe1::xhippo {
    struct XHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: XHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XHIPPO>(arg0, 9, b"XHIPPO", b"Santahippo", x"536561736f6e656420686970706f706f74616d757320f09fa69b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dfd89b6f-ae65-40fa-8bd3-64a67129f8eb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XHIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XHIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

