module 0x44da34a776723c4f3ba1fb6557e636430a55359a720f13645ccf2f8976ad3e15::gg {
    struct GG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GG>(arg0, 9, b"GG", b"Ggh", b"Hhh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7034d510-bc9a-4b46-b9e9-739c910a6190.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GG>>(v1);
    }

    // decompiled from Move bytecode v6
}

