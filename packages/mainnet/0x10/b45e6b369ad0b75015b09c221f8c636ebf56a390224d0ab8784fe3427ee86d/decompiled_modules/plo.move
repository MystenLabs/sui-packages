module 0x10b45e6b369ad0b75015b09c221f8c636ebf56a390224d0ab8784fe3427ee86d::plo {
    struct PLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLO>(arg0, 9, b"PLO", b"PLANTY", b"PLANETY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/11c4190d-64b6-47f9-83b5-de79d462aa5b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

