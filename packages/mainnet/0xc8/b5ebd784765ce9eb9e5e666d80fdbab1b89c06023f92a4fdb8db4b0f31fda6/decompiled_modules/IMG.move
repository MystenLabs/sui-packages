module 0xc8b5ebd784765ce9eb9e5e666d80fdbab1b89c06023f92a4fdb8db4b0f31fda6::IMG {
    struct IMG has drop {
        dummy_field: bool,
    }

    fun init(arg0: IMG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = mint(arg0, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<IMG>>(v0);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IMG>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: IMG, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<IMG>, 0x2::coin::CoinMetadata<IMG>) {
        let (v0, v1) = 0x2::coin::create_currency<IMG>(arg0, 9, b"TSTK", b"Test Token", b"Test Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://thumbs.dreamstime.com/b/flying-bird-sparrow-isolated-white-background-house-transparent-png-272795544.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IMG>(&mut v2, 1000000000000000000, @0xc2a817f85bc23136b0337a51c848f18a8355f91f6483c5c70536e3c7f8b3c5e2, arg1);
        (v2, v1)
    }

    // decompiled from Move bytecode v6
}

