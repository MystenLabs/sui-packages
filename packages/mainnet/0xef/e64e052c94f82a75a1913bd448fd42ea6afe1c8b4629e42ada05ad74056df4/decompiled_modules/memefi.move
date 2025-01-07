module 0xefe64e052c94f82a75a1913bd448fd42ea6afe1c8b4629e42ada05ad74056df4::memefi {
    struct MEMEFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEFI>(arg0, 6, b"MEMEFI", b"MEMEFI Test Token", x"5765e280997665206275696c742061206c656164696e672054656c656772616d206170702065636f73797374656d2077697468206d6f7265207468616e2035304d2075736572732e0a5669612067616d696669636174696f6e20616e64206d617373207573652063617365732c207765e280997265206272696e67696e67207468657365207573657273206f6e2d636861696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732036833103.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEFI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEFI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

