module 0x2dfd47780fab61591d6363cdfe8974ab7acd8f138063f8463d314ba938e67bd9::djytwy {
    struct DJYTWY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJYTWY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJYTWY>(arg0, 9, b"TWY", b"DJYTWY", b"lets move task2 my token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ambrus-asset.s3.amazonaws.com/official_website/USDC.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DJYTWY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJYTWY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DJYTWY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DJYTWY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

