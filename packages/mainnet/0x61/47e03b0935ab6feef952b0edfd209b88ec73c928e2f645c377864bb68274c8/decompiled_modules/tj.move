module 0x6147e03b0935ab6feef952b0edfd209b88ec73c928e2f645c377864bb68274c8::tj {
    struct TJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TJ>(arg0, 9, b"TJ", b"WAVE", b"For funny", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aa88bd63-7abf-4db3-9dee-abb45c7b40cb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

