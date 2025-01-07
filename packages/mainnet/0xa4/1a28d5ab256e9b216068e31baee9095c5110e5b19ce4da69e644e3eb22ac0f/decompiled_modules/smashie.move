module 0xa41a28d5ab256e9b216068e31baee9095c5110e5b19ce4da69e644e3eb22ac0f::smashie {
    struct SMASHIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMASHIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMASHIE>(arg0, 6, b"SMASHIE", b"SMASHIE SUI", b"$SMASHIE is a pickleball addict with a burning desire for crypto stardom on the sui network. The first Pickleball Memecoin-Utility Hybrid on sui, bridging Web3 and real-world communities", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_25_15_29_46_a510d56d79.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMASHIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMASHIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

