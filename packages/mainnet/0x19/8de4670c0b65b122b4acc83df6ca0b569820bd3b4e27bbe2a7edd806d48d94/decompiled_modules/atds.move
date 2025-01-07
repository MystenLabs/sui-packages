module 0x198de4670c0b65b122b4acc83df6ca0b569820bd3b4e27bbe2a7edd806d48d94::atds {
    struct ATDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATDS>(arg0, 6, b"ATDS", b"AVCD", b"AAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024102018163441_batcheditor_fotor_16c2afaab2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

