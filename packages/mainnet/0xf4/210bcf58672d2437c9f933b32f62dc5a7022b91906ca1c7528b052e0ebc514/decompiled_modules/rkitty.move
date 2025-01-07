module 0xf4210bcf58672d2437c9f933b32f62dc5a7022b91906ca1c7528b052e0ebc514::rkitty {
    struct RKITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RKITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RKITTY>(arg0, 6, b"Rkitty", b"Roaring Kitty", x"54686973206973203130302520747275652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4d_H5ql_f_400x400_3a8b6addee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RKITTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RKITTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

