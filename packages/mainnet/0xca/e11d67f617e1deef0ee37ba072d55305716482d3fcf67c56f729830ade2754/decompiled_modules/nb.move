module 0xcae11d67f617e1deef0ee37ba072d55305716482d3fcf67c56f729830ade2754::nb {
    struct NB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NB>(arg0, 9, b"NB", b"DOGES", b"TGE, flash, player", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fd606900-f9a9-457d-8b5e-306c9b2fa627.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NB>>(v1);
    }

    // decompiled from Move bytecode v6
}

