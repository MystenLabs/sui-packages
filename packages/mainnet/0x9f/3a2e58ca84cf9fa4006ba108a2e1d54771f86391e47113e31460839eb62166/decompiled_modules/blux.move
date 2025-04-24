module 0x9f3a2e58ca84cf9fa4006ba108a2e1d54771f86391e47113e31460839eb62166::blux {
    struct BLUX has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUX>(arg0, 6, b"Blux", b"Bluxie", b"Bluxi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid3gjg7p7fxq6ez7qy42fq5pletg2jxkszfu6b4j32t6ljtff3j3y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLUX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

