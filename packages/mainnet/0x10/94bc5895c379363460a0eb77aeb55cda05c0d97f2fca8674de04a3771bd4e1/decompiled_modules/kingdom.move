module 0x1094bc5895c379363460a0eb77aeb55cda05c0d97f2fca8674de04a3771bd4e1::kingdom {
    struct KINGDOM has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KINGDOM>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KINGDOM>>(0x2::coin::mint<KINGDOM>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: KINGDOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINGDOM>(arg0, 9, b"KNDOM", b"KINGDOM", b"Inspired by zombie world against the Sui KINGDOM!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1364334914498416640/aGuvp6mY_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KINGDOM>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KINGDOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGDOM>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

