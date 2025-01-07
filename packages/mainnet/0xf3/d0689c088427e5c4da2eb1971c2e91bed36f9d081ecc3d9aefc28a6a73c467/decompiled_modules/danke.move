module 0xf3d0689c088427e5c4da2eb1971c2e91bed36f9d081ecc3d9aefc28a6a73c467::danke {
    struct DANKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DANKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DANKE>(arg0, 6, b"DANKE", b"SUIDANK", b"Dank on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5507_20e65f2408.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DANKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DANKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

