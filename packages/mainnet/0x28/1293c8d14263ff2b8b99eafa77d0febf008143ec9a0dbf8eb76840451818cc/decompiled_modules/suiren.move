module 0x281293c8d14263ff2b8b99eafa77d0febf008143ec9a0dbf8eb76840451818cc::suiren {
    struct SUIREN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIREN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIREN>(arg0, 6, b"SUIREN", b"Suiren", b"Suiren (\"Fire starter Person\"), also known as Suihuang (\"Fire Starter Emperor\"), is credited as a culture hero who introduced humans to the production of fire and its use for cooking. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIREN_4b20e0829c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIREN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIREN>>(v1);
    }

    // decompiled from Move bytecode v6
}

