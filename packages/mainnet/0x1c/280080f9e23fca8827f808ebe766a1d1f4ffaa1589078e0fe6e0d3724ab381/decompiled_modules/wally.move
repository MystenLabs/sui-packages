module 0x1c280080f9e23fca8827f808ebe766a1d1f4ffaa1589078e0fe6e0d3724ab381::wally {
    struct WALLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALLY>(arg0, 6, b"WALLY", b"Sui Wally", b"Introducing $WALLY. Inspired by an orange walrus in a hoodie, crafted by artist Matt Furie. Built for those who love art, community, and a touch of fun. Join the movement and be part of something creative!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifyhltzpiryiuht74hppbgv2bervup52unur3w6ysmw7rnokiu5ei")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WALLY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

