module 0x4139637f0b7ea3f8d36d0096a34d2692e4cac72bf6fb2430686209d7b6d72b8e::baked {
    struct BAKED has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAKED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAKED>(arg0, 6, b"BAKED", b"Baked SUI", b"Red-eyes SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih7lanb7hp7y7qx4kr7idpcxijvzadain4yczwik2yfisee5252dq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAKED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BAKED>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

