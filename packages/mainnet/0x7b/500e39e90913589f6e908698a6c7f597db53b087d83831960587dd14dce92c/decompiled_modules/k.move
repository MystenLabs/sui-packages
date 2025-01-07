module 0x7b500e39e90913589f6e908698a6c7f597db53b087d83831960587dd14dce92c::k {
    struct K has drop {
        dummy_field: bool,
    }

    fun init(arg0: K, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<K>(arg0, 9, b"K", b"Kinto", x"5468657265e2809973207374696c6c2074696d6520746f20706172746963697061746520696e204b696e746fe28099732066697273742074726164696e6720636f6d7065746974696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c6350a93-2d32-4883-8523-1372473b43a3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<K>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<K>>(v1);
    }

    // decompiled from Move bytecode v6
}

