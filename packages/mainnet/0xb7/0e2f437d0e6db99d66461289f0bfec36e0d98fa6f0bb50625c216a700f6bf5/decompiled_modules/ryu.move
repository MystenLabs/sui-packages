module 0xb70e2f437d0e6db99d66461289f0bfec36e0d98fa6f0bb50625c216a700f6bf5::ryu {
    struct RYU has drop {
        dummy_field: bool,
    }

    fun init(arg0: RYU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RYU>(arg0, 9, b"RYU", b"The Dragon", b"The Wise First Child", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/07ae5f2c-561f-4651-abf2-7e142a62760c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RYU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RYU>>(v1);
    }

    // decompiled from Move bytecode v6
}

