module 0xad91443aca21124e41a9e8420ab392d3af1eaa3535f713b51184776a96c11332::test10b {
    struct TEST10B has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST10B, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST10B>(arg0, 9, b"test10b", b"Sorry guys just test", b"Sorry guys just test", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST10B>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST10B>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEST10B>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TEST10B>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

