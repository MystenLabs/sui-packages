module 0xdb031736216ee6df8e66a8bf4a7c523019ed29225b875fc5e5c905e3f8e91cd::bobo {
    struct BOBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBO>(arg0, 6, b"BOBO", b"BOBOSUI", b"just meme BOBO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c1a9d949_3071_41b2_be8b_4f1d03b19739_bf3c21049b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

