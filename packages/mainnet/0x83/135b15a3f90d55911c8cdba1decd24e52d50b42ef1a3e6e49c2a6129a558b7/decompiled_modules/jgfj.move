module 0x83135b15a3f90d55911c8cdba1decd24e52d50b42ef1a3e6e49c2a6129a558b7::jgfj {
    struct JGFJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: JGFJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JGFJ>(arg0, 9, b"JGFJ", b"GJ", b"DHFF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/df1dcdff-33e1-41a4-b581-7b79162fccc0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JGFJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JGFJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

