module 0x58f2e7877d75881c1bc8a4c7194e626bcb43fabd052872d44e20c8cdce374854::eye {
    struct EYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EYE>(arg0, 9, b"EYE", b"My Eye", b"mot doi mat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d054bf2-853c-4d98-9b3a-89db0700ac16.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

