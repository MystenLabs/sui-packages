module 0x2659db63ee5d9d55ee66f6c04ed15978e74d84420401c6a522f96d701694c12b::selon {
    struct SELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SELON>(arg0, 6, b"SELON", b"ELON ON SUI", b"elon must within sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid7jnnzrx6fqlf6a4d4lbfvl6ixjjc3xcdmw4hpngrbbfp47qhldy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SELON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

