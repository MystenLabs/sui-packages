module 0xd76f2e3260f9b37a190e3310f1b26985835474a0a5e0057ba5501770803d5e5::test4 {
    struct TEST4 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TEST4>, arg1: 0x2::coin::Coin<TEST4>) {
        0x2::coin::burn<TEST4>(arg0, arg1);
    }

    fun init(arg0: TEST4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST4>(arg0, 9, b"test4", b"Test4", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://34.27.172.105/uploads/logo_1761407323335_2995e224.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST4>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST4>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEST4>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TEST4>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

