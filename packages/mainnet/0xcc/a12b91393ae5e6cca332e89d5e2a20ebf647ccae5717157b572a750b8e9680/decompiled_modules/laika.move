module 0xcca12b91393ae5e6cca332e89d5e2a20ebf647ccae5717157b572a750b8e9680::laika {
    struct LAIKA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LAIKA>, arg1: 0x2::coin::Coin<LAIKA>) {
        0x2::coin::burn<LAIKA>(arg0, arg1);
    }

    fun init(arg0: LAIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAIKA>(arg0, 9, b"LK", b"LAIKA", b"Laika token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigdxf7biamfqdifni73ca7twmaakkkgylo47ovekl4qjmduu3qaxi")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAIKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAIKA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LAIKA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LAIKA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

