module 0xe27a0ab66901fa55a6c47f148bc074934d20dbdd384f5d74584422f346a49a25::oister {
    struct OISTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: OISTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OISTER>(arg0, 6, b"OISTER", b"Oister SUI", x"0a244f495354455220697320612070657266656374206578616d706c65206f6620686f772061206d656d652d62617365642070726f6a6563742063616e2065766f6c766520696e746f206120636f6d706c657820616e6420686967686c792076616c7561626c652065636f73797374656d2e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_oister_8b9756230e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OISTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OISTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

