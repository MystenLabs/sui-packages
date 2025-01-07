module 0xb883fd1e656f5ca392581a34b7c3ff3102df62827fba323159b7db5d001cc355::sango {
    struct SANGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANGO>(arg0, 6, b"SANGO", b"Sango The Cat", b"Hello, I'm Sango, the 1st Black cat on SUI! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000006963_38710f0d71.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

