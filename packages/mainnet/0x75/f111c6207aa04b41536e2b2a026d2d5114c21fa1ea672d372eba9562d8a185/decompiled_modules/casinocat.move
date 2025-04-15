module 0x75f111c6207aa04b41536e2b2a026d2d5114c21fa1ea672d372eba9562d8a185::casinocat {
    struct CASINOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASINOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CASINOCAT>(arg0, 6, b"CasinoCat", b"Casino Cat", b"Casino Cat 777", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibbfaph7byd3km5eeyxqetszwgs55cb7obb6vnv67jeeukmzbin7q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CASINOCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CASINOCAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

