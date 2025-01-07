module 0xcfc33397b31f501d57e7b4c2ad3bf8aa2d033d0f265ef0bae83bf16d0442156e::spl_wrn {
    struct SPL_WRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPL_WRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPL_WRN>(arg0, 9, b"SPL_WRN", b"Wavern ", b"Simple wavern simple meme simple flow ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c25fcec7-7cce-4f0e-9db9-0eccf713f2bc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPL_WRN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPL_WRN>>(v1);
    }

    // decompiled from Move bytecode v6
}

