module 0xc773d718b48c6f9d78b29fc9d47c5d9331a2a0c3ca6d62737681ff1c81bde1f9::bdc {
    struct BDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDC>(arg0, 9, b"BDC", b"Beo", b"Hold and Rich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fbe52e30-fd7d-4c46-a259-733b01a85350.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

