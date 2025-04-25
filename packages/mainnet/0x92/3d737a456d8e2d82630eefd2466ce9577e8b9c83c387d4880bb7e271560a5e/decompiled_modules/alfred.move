module 0x923d737a456d8e2d82630eefd2466ce9577e8b9c83c387d4880bb7e271560a5e::alfred {
    struct ALFRED has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALFRED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALFRED>(arg0, 6, b"ALFRED", b"Sui Alfred", b"Alfred is revolutionizing Sui by empowering crypto innovation and building a vibrant community through real-world assets and harness racing.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000062208_6f9ece6a48.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALFRED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALFRED>>(v1);
    }

    // decompiled from Move bytecode v6
}

