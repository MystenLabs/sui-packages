module 0x46a55b551671eea4f3d26c99e4698073ba3523874f9314caae86aff1a0309b48::gocat {
    struct GOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOCAT>(arg0, 6, b"GOCAT", b"Goldfish cat", b"Feeling fin-tastic with my feline flair", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_171558_c8e23317f5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

