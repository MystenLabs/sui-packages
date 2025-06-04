module 0x55e4ed44493902341bdfdb09b719d6e1ba86bf94b0c9ad0ef138ca84eeceaa7f::super {
    struct SUPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPER>(arg0, 6, b"SUPER", b"Super League", b"Super League Token is more than just a game; it's a community-driven ecosystem where football enthusiasts can connect,compete, and celebrate the sport they love", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibuujxh52vayh2wpkuwrfim2izjrk3jmejese7gpillgpygotnqxe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUPER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

