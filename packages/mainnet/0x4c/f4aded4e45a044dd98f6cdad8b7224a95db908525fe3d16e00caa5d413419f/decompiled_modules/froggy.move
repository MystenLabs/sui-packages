module 0x4cf4aded4e45a044dd98f6cdad8b7224a95db908525fe3d16e00caa5d413419f::froggy {
    struct FROGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGGY>(arg0, 6, b"Froggy", b"Froggernaut", b"The first project of a 3rd year computer science student! Join us!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifqbbwytwhnsifruepkgln6l5bowx3rd4tuwedqflufx5uvj76i7u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FROGGY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

