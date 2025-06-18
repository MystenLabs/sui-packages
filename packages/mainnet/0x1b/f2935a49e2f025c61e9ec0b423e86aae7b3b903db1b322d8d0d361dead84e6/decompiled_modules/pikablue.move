module 0x1bf2935a49e2f025c61e9ec0b423e86aae7b3b903db1b322d8d0d361dead84e6::pikablue {
    struct PIKABLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKABLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKABLUE>(arg0, 6, b"Pikablue", b"Pikablue on Sui", b"PIKACHU BLUE is the blue evolution of Pikachu! Now bringing its electric energy to the SUI Chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiai6h3w7ru43oupczixyi7uwvf2cnnx25vbgwupjkctsnac36le24")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKABLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PIKABLUE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

