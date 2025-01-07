module 0x21c3141e613c0715e80365011d3a3119a6a991568a491a5961a1d00ab861dc1c::trky {
    struct TRKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRKY>(arg0, 6, b"TRKY", b"BOZKURT", b"Aaaaaauuuuuuuuuuuuuu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1194_86659035a3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

