module 0x85cb4e57e0eda23d28b5891dd8f756326c67e149177846a9a573d9d5927282a2::mg {
    struct MG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MG>(arg0, 9, b"MG", b"Mirage", b"DEFYING LAWS, BENDING REALITY! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a82fc9e0-8807-4cfe-9f0e-952f98a8d1d3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MG>>(v1);
    }

    // decompiled from Move bytecode v6
}

