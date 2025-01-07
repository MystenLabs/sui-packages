module 0x16130fcdc4025495414e28d488453dd3c52650bfb6fad477a587650ca6b43dc4::soge {
    struct SOGE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SOGE>, arg1: 0x2::coin::Coin<SOGE>) {
        0x2::coin::burn<SOGE>(arg0, arg1);
    }

    fun init(arg0: SOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOGE>(arg0, 9, b"SOGE", b"Sogecoin", b"Woof.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SOGE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SOGE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

