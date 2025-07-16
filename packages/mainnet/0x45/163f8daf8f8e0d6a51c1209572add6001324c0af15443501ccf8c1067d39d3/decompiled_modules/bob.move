module 0x45163f8daf8f8e0d6a51c1209572add6001324c0af15443501ccf8c1067d39d3::bob {
    struct BOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOB>(arg0, 6, b"BOB", b"Boobs Or Butt", b"Boobs or Butt? The age-old debate is finally on-chain. Pick a side, pump it hard, and let the market decide.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidjm3nh3ae6ylvkfautq5fooggs5brbecnq362w5fqxr6t23vx3na")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

