module 0x397b6be544253481bc842307fd7de7d749445b57ecb2567bf6566eb9fbbe6ba2::rdqn {
    struct RDQN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RDQN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RDQN>(arg0, 9, b"RDQN", b"RedQueen", b"RED QUEEN WANTS YOU TO BUY IT !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f8441f50-ac02-48e0-9f91-4e5ce3a0a0c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RDQN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RDQN>>(v1);
    }

    // decompiled from Move bytecode v6
}

