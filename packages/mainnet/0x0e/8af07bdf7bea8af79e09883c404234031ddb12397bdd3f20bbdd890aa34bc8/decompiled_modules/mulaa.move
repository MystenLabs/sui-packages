module 0xe8af07bdf7bea8af79e09883c404234031ddb12397bdd3f20bbdd890aa34bc8::mulaa {
    struct MULAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MULAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MULAA>(arg0, 9, b"MULAA", b"MULA", b"MULAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f2d7b298-af19-4e99-8a8f-10d938ba7de4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MULAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MULAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

