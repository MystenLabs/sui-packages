module 0xbb09f15375fe99d0daedb5c961a627bdb7eccd2f3fa8e210790c280353078884::cetusbaby {
    struct CETUSBABY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CETUSBABY>, arg1: 0x2::coin::Coin<CETUSBABY>) {
        0x2::coin::burn<CETUSBABY>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CETUSBABY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CETUSBABY>>(0x2::coin::mint<CETUSBABY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CETUSBABY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CETUSBABY>(arg0, 9, b"CETUSBABY", b"CETUSBABY", b"CETUSBABY", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CETUSBABY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CETUSBABY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

