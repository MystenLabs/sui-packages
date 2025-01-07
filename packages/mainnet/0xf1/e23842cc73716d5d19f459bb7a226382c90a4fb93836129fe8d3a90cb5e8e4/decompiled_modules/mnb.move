module 0xf1e23842cc73716d5d19f459bb7a226382c90a4fb93836129fe8d3a90cb5e8e4::mnb {
    struct MNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNB>(arg0, 9, b"MNB", b"MVB", b"FDH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a5d9a67c-d28a-42da-bd62-b00ef313cf72.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MNB>>(v1);
    }

    // decompiled from Move bytecode v6
}

