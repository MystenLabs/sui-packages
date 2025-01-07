module 0x7a9c749a4614fd4e808eab57ccc723331a9a91812d51d8e9e4110f427fa3e2be::rkitty {
    struct RKITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RKITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RKITTY>(arg0, 6, b"RKitty", b"Roaring Kitty", b"This is 100% true.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4d_H5ql_f_400x400_18c0328442.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RKITTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RKITTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

