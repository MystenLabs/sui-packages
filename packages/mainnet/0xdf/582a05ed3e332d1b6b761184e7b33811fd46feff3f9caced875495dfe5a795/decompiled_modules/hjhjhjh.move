module 0xdf582a05ed3e332d1b6b761184e7b33811fd46feff3f9caced875495dfe5a795::hjhjhjh {
    struct HJHJHJH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HJHJHJH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HJHJHJH>(arg0, 9, b"HJHJHJH", b"HJHJHJ", b"JHJHJHJH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/63fff47e-8678-4f1c-8f9d-085590fd94e4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HJHJHJH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HJHJHJH>>(v1);
    }

    // decompiled from Move bytecode v6
}

