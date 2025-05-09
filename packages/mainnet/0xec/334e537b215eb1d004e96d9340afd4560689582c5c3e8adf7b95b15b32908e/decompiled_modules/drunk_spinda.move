module 0xec334e537b215eb1d004e96d9340afd4560689582c5c3e8adf7b95b15b32908e::drunk_spinda {
    struct DRUNK_SPINDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRUNK_SPINDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRUNK_SPINDA>(arg0, 6, b"Drunk Spinda", b"POKEMON", x"5370696e646120746865206472756e6b20506f6bc3a96d6f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigdynvjv7sxqoxhrguwsavygeqfazz4zpgly5as2vqtvkfqogimhm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRUNK_SPINDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DRUNK_SPINDA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

