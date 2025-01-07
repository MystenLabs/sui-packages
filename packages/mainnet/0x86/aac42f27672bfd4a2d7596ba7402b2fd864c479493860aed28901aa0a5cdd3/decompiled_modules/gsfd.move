module 0x86aac42f27672bfd4a2d7596ba7402b2fd864c479493860aed28901aa0a5cdd3::gsfd {
    struct GSFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GSFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GSFD>(arg0, 9, b"GSFD", b"FDHD", b"SCG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fcecfdc5-5d4c-4544-871a-9ccf0f3467ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GSFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GSFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

