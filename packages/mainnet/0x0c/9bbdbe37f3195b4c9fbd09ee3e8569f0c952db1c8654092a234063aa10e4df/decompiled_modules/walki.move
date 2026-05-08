module 0xc9bbdbe37f3195b4c9fbd09ee3e8569f0c952db1c8654092a234063aa10e4df::walki {
    struct WALKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALKI>(arg0, 6, b"WALKI", b"WALLY", b"DSDSDS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidzliieob6hmbc552x7ogqaoyi74zgungbkezigtqbcy3pmdn5d3y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WALKI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

