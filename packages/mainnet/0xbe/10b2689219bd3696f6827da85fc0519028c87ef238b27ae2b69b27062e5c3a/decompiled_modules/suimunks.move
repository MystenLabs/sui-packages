module 0xbe10b2689219bd3696f6827da85fc0519028c87ef238b27ae2b69b27062e5c3a::suimunks {
    struct SUIMUNKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMUNKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMUNKS>(arg0, 6, b"SUIMUNKS", b"Alvin and the SUImunks", b"Alvin and the SUImunks are back!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9109_16e9fe84da.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMUNKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMUNKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

