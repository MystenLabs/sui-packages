module 0x654367d3a296fe5d9900fa3a559f3e5675e2504bba235e4f381321039bbe6bff::ston {
    struct STON has drop {
        dummy_field: bool,
    }

    fun init(arg0: STON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STON>(arg0, 6, b"STON", b"SUITON", b"Suiton, the best chakra on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suitonn_22a4788108.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STON>>(v1);
    }

    // decompiled from Move bytecode v6
}

