module 0x5929a45d42b8f6385b0af9c964e0fff90449aeb4f03f0caf7aaf93427da1d8af::emp {
    struct EMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMP>(arg0, 9, b"EMP", b"Empty", b"Emptiness is everything just think about it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1da39b56-81c2-456b-8da4-fb77a2a6f20c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

