module 0x93049617811cb1d821da5cfbd23f0ddea501f27cc7d58ec999bac1d0b9d6f1b6::onyx {
    struct ONYX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONYX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONYX>(arg0, 9, b"ONYX", b"Onyx Game", b"Onyx crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/becb3c71-9f40-450a-972b-c0b5aeb3c9b4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONYX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONYX>>(v1);
    }

    // decompiled from Move bytecode v6
}

