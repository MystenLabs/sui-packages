module 0xc4458b54e5777cc7c9b8b90d2e70c2fb462f4a34714aec0b1b481c0d0d2813b6::tma {
    struct TMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMA>(arg0, 9, b"TMA", b"TMA Soluti", b"TMA Solutions", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d9e185d4-f43f-43d6-bc1b-f984bfa6630c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

