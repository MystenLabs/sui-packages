module 0xef187c1d9941d90bcd19a5df3c5b86a3defff6bb8da1aae91a9d6bf636009f39::mojito {
    struct MOJITO has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MOJITO>, arg1: 0x2::coin::Coin<MOJITO>) : u64 {
        0x2::coin::burn<MOJITO>(arg0, arg1)
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOJITO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MOJITO>>(0x2::coin::mint<MOJITO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MOJITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOJITO>(arg0, 6, b"MOJ", b"MOJITO COIN", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOJITO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOJITO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

