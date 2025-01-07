module 0x5382315f4f7258c68e046454aabcfa81fc483cf1183af78f0662a63eee2f9423::nner {
    struct NNER has drop {
        dummy_field: bool,
    }

    fun init(arg0: NNER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NNER>(arg0, 9, b"NNER", b"NN", b"NERDS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bd7bcca8-7ccb-4233-889c-1b7f40214d83.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NNER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NNER>>(v1);
    }

    // decompiled from Move bytecode v6
}

