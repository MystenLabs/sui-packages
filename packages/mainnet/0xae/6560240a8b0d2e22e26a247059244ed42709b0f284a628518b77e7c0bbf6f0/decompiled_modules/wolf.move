module 0xae6560240a8b0d2e22e26a247059244ed42709b0f284a628518b77e7c0bbf6f0::wolf {
    struct WOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOLF>(arg0, 6, b"WOLF", b"Wolfoo", b"The anime wolfoo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicvofmhvtjps5b2qs5emoyp6lffuq3fmyiu3a7xkpf7n7kfxiy75y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WOLF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

