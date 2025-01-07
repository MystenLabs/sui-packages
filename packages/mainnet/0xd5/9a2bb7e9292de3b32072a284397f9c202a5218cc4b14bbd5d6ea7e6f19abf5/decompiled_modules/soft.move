module 0xd59a2bb7e9292de3b32072a284397f9c202a5218cc4b14bbd5d6ea7e6f19abf5::soft {
    struct SOFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOFT>(arg0, 9, b"SOFT", b"Sliper", b"Sploosh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/84852d39-8a9f-478e-93f3-2db23df8323a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

