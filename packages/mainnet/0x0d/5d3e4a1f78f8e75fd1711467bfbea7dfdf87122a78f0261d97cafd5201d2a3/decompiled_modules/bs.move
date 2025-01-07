module 0xd5d3e4a1f78f8e75fd1711467bfbea7dfdf87122a78f0261d97cafd5201d2a3::bs {
    struct BS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BS>(arg0, 9, b"BS", b"BlackSheep", x"53696e676c65206d65206f75742c2049e280996d2074686520426c61636b205368656570", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c7ea157f-3295-4c65-b1c7-f615b6820167.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BS>>(v1);
    }

    // decompiled from Move bytecode v6
}

