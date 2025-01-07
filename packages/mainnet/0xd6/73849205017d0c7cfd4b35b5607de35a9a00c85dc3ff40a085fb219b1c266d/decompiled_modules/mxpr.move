module 0xd673849205017d0c7cfd4b35b5607de35a9a00c85dc3ff40a085fb219b1c266d::mxpr {
    struct MXPR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MXPR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MXPR>(arg0, 9, b"MXPR", b"MaxPro", b"Maximum Professional ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4f303eeb-8da0-437c-a963-766628f7b8f7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MXPR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MXPR>>(v1);
    }

    // decompiled from Move bytecode v6
}

