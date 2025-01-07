module 0xc4a4292bcab3e1a058ab89a3e479951579a548be9640d88a12329c4f68cda0da::aplm {
    struct APLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: APLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APLM>(arg0, 9, b"APLM", b"Apolomax", b"token distribution ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/95953092-0b5a-4def-9c6b-3b98948c874c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

