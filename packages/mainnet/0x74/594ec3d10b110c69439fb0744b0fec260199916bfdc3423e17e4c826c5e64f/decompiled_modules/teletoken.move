module 0x74594ec3d10b110c69439fb0744b0fec260199916bfdc3423e17e4c826c5e64f::teletoken {
    struct TELETOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TELETOKEN>, arg1: 0x2::coin::Coin<TELETOKEN>) {
        0x2::coin::burn<TELETOKEN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TELETOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TELETOKEN>>(0x2::coin::mint<TELETOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TELETOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TELETOKEN>(arg0, 9, b"teletoken", b"TELETOKEN", b"teletoken", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TELETOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TELETOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

