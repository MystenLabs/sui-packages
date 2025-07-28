module 0xc454c920ed07bb1a1c1b47cb99391f64c4ed1c52733846b64ee806350f5c5a7f::crock {
    struct CROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROCK>(arg0, 6, b"CROCK", b"Sui Witc Crock", b"Mulitalent blue duck CROCK that will rock the basics, its trendy look will catch all eyes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeie66poxi2yfzzsdudg3nlqinkqvxrp2aayeztw5wtpb3cwsmejj7a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CROCK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

