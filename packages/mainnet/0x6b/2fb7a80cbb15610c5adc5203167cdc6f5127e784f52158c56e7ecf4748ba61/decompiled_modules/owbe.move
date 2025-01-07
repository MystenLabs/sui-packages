module 0x6b2fb7a80cbb15610c5adc5203167cdc6f5127e784f52158c56e7ecf4748ba61::owbe {
    struct OWBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWBE>(arg0, 9, b"OWBE", b"bdjd", b"bdbd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cc267731-f804-4bc1-accd-56ad50d29e74.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

