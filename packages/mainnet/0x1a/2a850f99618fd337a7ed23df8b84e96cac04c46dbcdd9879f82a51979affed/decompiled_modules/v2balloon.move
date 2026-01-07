module 0x1a2a850f99618fd337a7ed23df8b84e96cac04c46dbcdd9879f82a51979affed::v2balloon {
    struct V2BALLOON has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<V2BALLOON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<V2BALLOON>>(0x2::coin::mint<V2BALLOON>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: V2BALLOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<V2BALLOON>(arg0, 9, b"V2B", b"V2BALLOON", b"V2 Balloon Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://black-late-hoverfly-823.mypinata.cloud/ipfs/bafybeifggzzdgm62sv7bq5ebtxk7h26fmk2emv6lrzdoy62pgwbn6bdqoy"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<V2BALLOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<V2BALLOON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

