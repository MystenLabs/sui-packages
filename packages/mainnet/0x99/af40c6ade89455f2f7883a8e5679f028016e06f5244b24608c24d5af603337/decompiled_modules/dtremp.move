module 0x99af40c6ade89455f2f7883a8e5679f028016e06f5244b24608c24d5af603337::dtremp {
    struct DTREMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTREMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DTREMP>(arg0, 9, b"DTREMP", b"DnaldTremp", b"United States President", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c47d4763-5c40-4eb5-9c44-82ba8627fca1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTREMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DTREMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

