module 0x829f778887aed19073eaeadd20765c56bd188e74cfbeb07ed4e7a48d5860b51b::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 9, b"SUI", b"$MATRIX", b"soon we will launch $matrix coin on sui network, stay tuned", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/20e676c9-7406-4a7d-a9c5-eafa36a1bcf1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

