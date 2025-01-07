module 0xbb7512ffa9f1aa06818d9c643f9f701a7fc906aaa31aed317e690bea7b9036aa::empty {
    struct EMPTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMPTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMPTY>(arg0, 9, b"EMPTY", b"EMPTY", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EMPTY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMPTY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<EMPTY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<EMPTY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

