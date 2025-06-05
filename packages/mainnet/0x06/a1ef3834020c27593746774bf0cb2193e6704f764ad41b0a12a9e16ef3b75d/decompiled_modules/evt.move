module 0x6a1ef3834020c27593746774bf0cb2193e6704f764ad41b0a12a9e16ef3b75d::evt {
    struct EVT has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVT>(arg0, 6, b"EVT", b"Elon VS Trump", b"Who will win in the fight against Elon versus Trump?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifs6hkbyr7h5kdhg472eann3j43aybvrp5ibu6i2wqjmccx4l7wi4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EVT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

