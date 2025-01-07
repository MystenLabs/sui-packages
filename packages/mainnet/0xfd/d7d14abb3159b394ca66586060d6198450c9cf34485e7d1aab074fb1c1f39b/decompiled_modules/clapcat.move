module 0xfdd7d14abb3159b394ca66586060d6198450c9cf34485e7d1aab074fb1c1f39b::clapcat {
    struct CLAPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLAPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAPCAT>(arg0, 6, b"CLAPCAT", b"CLAPCAT ON SUI", b"clapcat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d5f7bc44c8b52d23af697ed3924fa4af_851440238c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLAPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

