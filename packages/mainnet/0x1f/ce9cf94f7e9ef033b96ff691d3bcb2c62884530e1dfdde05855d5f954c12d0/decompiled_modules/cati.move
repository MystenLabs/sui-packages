module 0x1fce9cf94f7e9ef033b96ff691d3bcb2c62884530e1dfdde05855d5f954c12d0::cati {
    struct CATI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATI>(arg0, 6, b"CATI", b"Catizen", b" Catizen's vibe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_789355dcf7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATI>>(v1);
    }

    // decompiled from Move bytecode v6
}

