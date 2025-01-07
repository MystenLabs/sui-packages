module 0xcd9341b198dff1ae17f7bf8de67cef691b272b9174d5c7e14552fd982733e792::suidogwrap {
    struct SUIDOGWRAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOGWRAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOGWRAP>(arg0, 6, b"SUIDOGWRAP", b"SUDOGEWRAP", x"537569205772617070656420446f670a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xe6b43a6f4f220f7d454097195c12688e7dcb258ac1f5cf87219e2609cefe1346_nago_nago_4be7fe3541.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOGWRAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOGWRAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

