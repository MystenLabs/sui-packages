module 0x307f344c485f3074256c432b0f3e16931ce6b2dfcc76ec5fd67ddf22a1718d79::sinu {
    struct SINU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SINU>, arg1: 0x2::coin::Coin<SINU>) {
        0x2::coin::burn<SINU>(arg0, arg1);
    }

    fun init(arg0: SINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SINU>(arg0, 2, b"SINU", b"SINU", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SINU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SINU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SINU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SINU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

