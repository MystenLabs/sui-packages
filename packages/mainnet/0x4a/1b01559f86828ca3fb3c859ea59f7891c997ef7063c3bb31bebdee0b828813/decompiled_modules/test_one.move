module 0x4a1b01559f86828ca3fb3c859ea59f7891c997ef7063c3bb31bebdee0b828813::test_one {
    struct TEST_ONE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TEST_ONE>, arg1: 0x2::coin::Coin<TEST_ONE>) {
        0x2::coin::burn<TEST_ONE>(arg0, arg1);
    }

    fun init(arg0: TEST_ONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_ONE>(arg0, 9, b"PIPISA", b"Pipisa Coin", b"Grow Pipisa with PIPISA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.steamstatic.com/b6ae2d2d6618711224d55a5fdc5d976e8b909c0d_full.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_ONE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_ONE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEST_ONE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TEST_ONE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

