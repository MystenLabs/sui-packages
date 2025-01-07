module 0x46f5fe3c7cb008d65f52271df930b4fdb2cc2627f17aec25772b4682cff94ee7::elm {
    struct ELM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELM>(arg0, 9, b"ELM", b"Elon Musk", b"Elon Musk token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9afd323c-fb6b-4bd8-b06c-d73ff1acf4e6-1632268224_8-kartinkin-net-p-ilon-mask-art-krasivo-9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELM>>(v1);
    }

    // decompiled from Move bytecode v6
}

