module 0x67f16712ca47c79898c88d1e0bc2a69171a2b6311ee8598b624f21ec13da636e::byoz {
    struct BYOZ has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BYOZ>, arg1: 0x2::coin::Coin<BYOZ>) {
        0x2::coin::burn<BYOZ>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BYOZ>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BYOZ>>(0x2::coin::mint<BYOZ>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BYOZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BYOZ>(arg0, 9, b"byoz", b"BYOZ", b"test token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BYOZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BYOZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

