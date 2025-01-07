module 0xc841b2291cbcb861744616f4f1f9f55e4c212f893ce70245c742514a3a6353c5::ydyf {
    struct YDYF has drop {
        dummy_field: bool,
    }

    fun init(arg0: YDYF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YDYF>(arg0, 9, b"YDYF", b"Hhchv", b"Jvnvhf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1beeb79e-f48d-4713-a48c-73b3d81e99b9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YDYF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YDYF>>(v1);
    }

    // decompiled from Move bytecode v6
}

