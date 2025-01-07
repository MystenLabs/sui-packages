module 0x88861d5310081029f3e2bec3cb0d70856b300ddd4dab2443350b84bad0abbe26::inuinu {
    struct INUINU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<INUINU>, arg1: 0x2::coin::Coin<INUINU>) {
        0x2::coin::burn<INUINU>(arg0, arg1);
    }

    fun init(arg0: INUINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INUINU>(arg0, 6, b"INUINU", b"InuInu", b"Woof woof", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INUINU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INUINU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<INUINU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<INUINU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

