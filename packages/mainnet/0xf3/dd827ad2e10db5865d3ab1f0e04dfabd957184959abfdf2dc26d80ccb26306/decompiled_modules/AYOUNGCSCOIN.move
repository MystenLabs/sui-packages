module 0xf3dd827ad2e10db5865d3ab1f0e04dfabd957184959abfdf2dc26d80ccb26306::AYOUNGCSCOIN {
    struct AYOUNGCSCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AYOUNGCSCOIN>, arg1: 0x2::coin::Coin<AYOUNGCSCOIN>) {
        0x2::coin::burn<AYOUNGCSCOIN>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<AYOUNGCSCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AYOUNGCSCOIN>>(0x2::coin::mint<AYOUNGCSCOIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: AYOUNGCSCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AYOUNGCSCOIN>(arg0, 6, b"AYOUNGCSCOIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AYOUNGCSCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AYOUNGCSCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

