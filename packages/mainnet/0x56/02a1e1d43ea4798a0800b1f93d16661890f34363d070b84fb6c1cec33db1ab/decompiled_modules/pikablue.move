module 0x5602a1e1d43ea4798a0800b1f93d16661890f34363d070b84fb6c1cec33db1ab::pikablue {
    struct PIKABLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKABLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKABLUE>(arg0, 6, b"PIKABLUE", b"Pikablue on SUI", b"PIKACHU BLUE is the blue evolution of Pikachu! Now bringing its electric energy to the SUI Chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiai6h3w7ru43oupczixyi7uwvf2cnnx25vbgwupjkctsnac36le24")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKABLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PIKABLUE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

