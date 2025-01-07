module 0x5a2b79f272d8c19b7a602ded133f1f9a5469ca0440efbdcaebadf6484a30ed1::RAIKO {
    struct RAIKO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<RAIKO>, arg1: 0x2::coin::Coin<RAIKO>) {
        0x2::coin::burn<RAIKO>(arg0, arg1);
    }

    fun init(arg0: RAIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAIKO>(arg0, 9, b"RAIKO", b"RAIKO", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAIKO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAIKO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<RAIKO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<RAIKO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

