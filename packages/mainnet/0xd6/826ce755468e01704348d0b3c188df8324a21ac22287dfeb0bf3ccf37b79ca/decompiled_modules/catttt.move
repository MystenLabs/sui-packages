module 0xd6826ce755468e01704348d0b3c188df8324a21ac22287dfeb0bf3ccf37b79ca::catttt {
    struct CATTTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATTTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATTTT>(arg0, 9, b"CATTTT", b"CATTT", b"Cattt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4f09683e-af86-4421-b233-197144c3a6bf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATTTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATTTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

