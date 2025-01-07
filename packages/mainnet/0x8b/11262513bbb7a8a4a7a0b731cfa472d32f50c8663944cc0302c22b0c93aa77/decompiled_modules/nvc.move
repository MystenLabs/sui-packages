module 0x8b11262513bbb7a8a4a7a0b731cfa472d32f50c8663944cc0302c22b0c93aa77::nvc {
    struct NVC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NVC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NVC>(arg0, 9, b"NVC", b"RTHJ", b"CB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cd91ee8e-3212-493b-bba2-5c80a3fed3a4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NVC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NVC>>(v1);
    }

    // decompiled from Move bytecode v6
}

