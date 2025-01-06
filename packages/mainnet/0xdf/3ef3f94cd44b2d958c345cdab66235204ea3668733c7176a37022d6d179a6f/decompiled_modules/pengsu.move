module 0xdf3ef3f94cd44b2d958c345cdab66235204ea3668733c7176a37022d6d179a6f::pengsu {
    struct PENGSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGSU>(arg0, 9, b"PENGSU", b"Pengsu On Sui", x"f09f90a7205468652066697273742063726f73732d657965642070656e6775696e206f6e2053756920f09f8c8a0a576164646c696e67206163726f737320746865206f6365616e7320f09f909f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/2a1528fff0f4b67a17081a352b146fcbblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENGSU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGSU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

