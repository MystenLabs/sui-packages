module 0x17aa45ad971b94e2182c202c1d078c2a4ba00fd09399097ee38371dd7753a82a::bert {
    struct BERT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BERT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BERT>(arg0, 6, b"BERT", b"BERUI", b"Meet Bert", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/25fbdfb24d5f4bf06aa43b0ae818ed78_f482bed983.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BERT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BERT>>(v1);
    }

    // decompiled from Move bytecode v6
}

