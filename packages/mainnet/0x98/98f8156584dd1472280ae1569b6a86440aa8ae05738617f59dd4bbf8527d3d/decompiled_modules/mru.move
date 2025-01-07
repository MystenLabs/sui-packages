module 0x9898f8156584dd1472280ae1569b6a86440aa8ae05738617f59dd4bbf8527d3d::mru {
    struct MRU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRU>(arg0, 9, b"MRU", b"Marius", b"Marius queen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/12c3f18c-3106-4e6e-8056-a16dd42aaf82.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MRU>>(v1);
    }

    // decompiled from Move bytecode v6
}

