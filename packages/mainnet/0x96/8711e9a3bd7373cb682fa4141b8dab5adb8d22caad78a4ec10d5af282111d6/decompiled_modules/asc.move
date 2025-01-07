module 0x968711e9a3bd7373cb682fa4141b8dab5adb8d22caad78a4ec10d5af282111d6::asc {
    struct ASC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASC>(arg0, 9, b"ASC", b"Ascend", b"Ascend (ASC) is a revolutionary cryptocurrency designed to empower individuals and businesses to reach new heights. Our token fuels a decentralized ecosystem that fosters innovation, collaboration, and financial inclusivity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9700d754-7c61-4617-97bd-efc919974b64.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASC>>(v1);
    }

    // decompiled from Move bytecode v6
}

