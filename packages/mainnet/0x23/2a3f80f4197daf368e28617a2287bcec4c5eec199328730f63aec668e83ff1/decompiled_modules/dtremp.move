module 0x232a3f80f4197daf368e28617a2287bcec4c5eec199328730f63aec668e83ff1::dtremp {
    struct DTREMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTREMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DTREMP>(arg0, 9, b"DTREMP", b"DnaldTremp", b"United States President", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8ddbd7e6-0aa2-472b-b371-a4a9503f5dae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTREMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DTREMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

