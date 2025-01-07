module 0xf42fb756f0fcddf6fe8affa9f5dd883640becaae6e427ffdd5784123127f5fbc::tardd {
    struct TARDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARDD>(arg0, 9, b"TARDD", b"TARD", b"TARDS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6221259d-139a-4c9d-b4dc-1f3772ee08e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TARDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

