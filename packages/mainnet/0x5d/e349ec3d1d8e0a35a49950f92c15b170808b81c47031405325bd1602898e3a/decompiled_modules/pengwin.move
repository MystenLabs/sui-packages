module 0x5de349ec3d1d8e0a35a49950f92c15b170808b81c47031405325bd1602898e3a::pengwin {
    struct PENGWIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGWIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGWIN>(arg0, 6, b"PENGWIN", b"SUI PENGWIN", b"LFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiezzc2ylsmmo7b3fszm22i4o2z5cy2rbsic2wffsnfm52emiaunae")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGWIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PENGWIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

