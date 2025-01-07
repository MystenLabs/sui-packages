module 0xafd89711040e5ad7e789d7a30187627604aede9007a3462927a25f453c06b903::hal9000 {
    struct HAL9000 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAL9000, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAL9000>(arg0, 6, b"HAL9000", b"HAL 9000 SUI", b"HAL9000 Terminal - Make Terminals Great Again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/asdqwe123123123_d0650f690a.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAL9000>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAL9000>>(v1);
    }

    // decompiled from Move bytecode v6
}

