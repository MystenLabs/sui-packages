module 0xc3bfba60f919cff3dca29e811b88e4fa608194e51d59b33c7b7598b89a761da9::dddcf {
    struct DDDCF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDDCF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDDCF>(arg0, 9, b"DDDCF", b"Dinhdong", b"Bao xin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6a59d7a0-5ed2-4a2e-9765-b1165a16e320.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDDCF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DDDCF>>(v1);
    }

    // decompiled from Move bytecode v6
}

