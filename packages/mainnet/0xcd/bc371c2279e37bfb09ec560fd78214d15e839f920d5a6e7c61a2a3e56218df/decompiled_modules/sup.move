module 0xcdbc371c2279e37bfb09ec560fd78214d15e839f920d5a6e7c61a2a3e56218df::sup {
    struct SUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUP>(arg0, 6, b"SUP", b"SUI UPP", b"hoping sui to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibbw5hxopvvuuyxvvfbyzjp4u3hamirlpqh2eryacdbhxzflgds3m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

