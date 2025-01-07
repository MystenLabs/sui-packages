module 0x807ddddd3cb45c6347f39385d23b80ce3cfe8694eb5806f8ec0aa8dc8c00c41e::cbrett {
    struct CBRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBRETT>(arg0, 6, b"CBRETT", b"CAPTAIN BRETT", b" Set sail with Captain Brett as he trades Wall Street for the high seas on the SUI network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_01_42_48_5a947389fd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CBRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

