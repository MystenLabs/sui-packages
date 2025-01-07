module 0x950f919bdaeaf645a12484bff82997e0413c856c7d551c8b28c24498f558088d::pengsu {
    struct PENGSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGSU>(arg0, 9, b"PENGSU", b"Pengsu On Sui", x"f09f90a7205468652066697273742063726f73732d657965642070656e6775696e206f6e2053756920f09f8c8a0a576164646c696e67206163726f737320746865206f6365616e7320f09f909f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/fec4e4c064daf31b0837e87910c1eba8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENGSU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGSU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

