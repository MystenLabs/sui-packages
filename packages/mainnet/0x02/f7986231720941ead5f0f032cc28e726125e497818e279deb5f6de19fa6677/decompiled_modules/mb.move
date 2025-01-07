module 0x2f7986231720941ead5f0f032cc28e726125e497818e279deb5f6de19fa6677::mb {
    struct MB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MB>(arg0, 9, b"MB", b"Mabuu", b"MABUU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d36043a6-f367-4a50-a2c9-09134f89461f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MB>>(v1);
    }

    // decompiled from Move bytecode v6
}

