module 0xc7f9a8f0497699cea6bb20c41ede7887dcb0323196729327841333b9e8eee9bd::shjsnd {
    struct SHJSND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHJSND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHJSND>(arg0, 9, b"SHJSND", b"Wujwjw", b"Snwmakjfmf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2a1bc663-094f-4cdf-a004-803c7a2fd1d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHJSND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHJSND>>(v1);
    }

    // decompiled from Move bytecode v6
}

