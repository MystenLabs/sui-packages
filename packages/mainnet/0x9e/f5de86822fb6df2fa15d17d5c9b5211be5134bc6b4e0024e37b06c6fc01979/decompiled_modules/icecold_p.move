module 0x9ef5de86822fb6df2fa15d17d5c9b5211be5134bc6b4e0024e37b06c6fc01979::icecold_p {
    struct ICECOLD_P has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICECOLD_P, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICECOLD_P>(arg0, 9, b"ICECOLD_P", b"Ice Cold P", b"For Cole Palmer fans around the world ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3d9e7fa5-4ca5-45bf-b18d-b434131554c9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICECOLD_P>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ICECOLD_P>>(v1);
    }

    // decompiled from Move bytecode v6
}

