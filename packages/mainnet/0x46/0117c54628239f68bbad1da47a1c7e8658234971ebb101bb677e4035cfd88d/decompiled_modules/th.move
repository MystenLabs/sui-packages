module 0x460117c54628239f68bbad1da47a1c7e8658234971ebb101bb677e4035cfd88d::th {
    struct TH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TH>(arg0, 9, b"TH", b"Thorns", b"Heretics Wallet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8565bf64-8aa8-4aa9-a2c7-938c0b83df67.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TH>>(v1);
    }

    // decompiled from Move bytecode v6
}

