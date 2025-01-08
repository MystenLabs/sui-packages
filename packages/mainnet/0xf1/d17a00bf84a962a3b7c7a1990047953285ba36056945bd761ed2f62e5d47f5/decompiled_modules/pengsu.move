module 0xf1d17a00bf84a962a3b7c7a1990047953285ba36056945bd761ed2f62e5d47f5::pengsu {
    struct PENGSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGSU>(arg0, 9, b"PENGSU", b"Pengsu on Sui", x"546865206375746573742063726f73732d657965642070656e6775696e206973206865726520f09f9299", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f4ef698c5cf909cc2653b88f49781444blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENGSU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGSU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

