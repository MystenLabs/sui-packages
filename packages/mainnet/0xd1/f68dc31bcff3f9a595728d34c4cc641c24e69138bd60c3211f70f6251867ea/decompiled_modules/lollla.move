module 0xd1f68dc31bcff3f9a595728d34c4cc641c24e69138bd60c3211f70f6251867ea::lollla {
    struct LOLLLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLLLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLLLA>(arg0, 9, b"LOLLLA", b"LOA", b"lollaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d375e3d8-64f3-4986-8aff-617b70f7b697.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLLLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOLLLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

