module 0x8c7298c9cb8dddb06057eae7b70674af7f6842d5533b0255027191720a62de5b::trex {
    struct TREX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREX>(arg0, 6, b"Trex", b"suirex", b"Something big and blue is coming  exclusively", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_c51629270e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TREX>>(v1);
    }

    // decompiled from Move bytecode v6
}

