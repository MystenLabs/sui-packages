module 0x112523f152137813dd9411e7c5f2de2ad683eb54a88dcccb56b1625c354536af::pspindaa {
    struct PSPINDAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSPINDAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSPINDAA>(arg0, 6, b"PSPINDAA", b"DRUNK POKEMON", x"5370696e646120746865206472756e6b20506f6bc3a96d6f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifvfi5g5ppvh7t7oag6ipabxfewitxshlqyqhyvv7wxjcfuqciyxi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSPINDAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PSPINDAA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

