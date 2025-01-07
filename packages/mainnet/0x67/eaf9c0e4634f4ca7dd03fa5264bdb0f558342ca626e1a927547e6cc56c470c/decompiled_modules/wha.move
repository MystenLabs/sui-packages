module 0x67eaf9c0e4634f4ca7dd03fa5264bdb0f558342ca626e1a927547e6cc56c470c::wha {
    struct WHA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WHA>, arg1: 0x2::coin::Coin<WHA>) {
        0x2::coin::burn<WHA>(arg0, arg1);
    }

    fun init(arg0: WHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHA>(arg0, 9, b"WHA", b"WHA", b"Whaleme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigdxf7biamfqdifni73ca7twmaakkkgylo47ovekl4qjmduu3qaxi")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WHA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WHA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

