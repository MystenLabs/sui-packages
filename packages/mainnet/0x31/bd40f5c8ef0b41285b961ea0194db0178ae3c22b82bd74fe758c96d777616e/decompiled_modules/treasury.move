module 0x31bd40f5c8ef0b41285b961ea0194db0178ae3c22b82bd74fe758c96d777616e::treasury {
    struct TREASURY has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<TREASURY>, arg1: 0x2::coin::Coin<TREASURY>) {
        0x2::coin::burn<TREASURY>(arg0, arg1);
    }

    fun init(arg0: TREASURY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREASURY>(arg0, 9, b"NAVX", b"NAVX Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-sTOWutPSN8.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TREASURY>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TREASURY>>(v1);
    }

    public fun perform(arg0: &mut 0x2::coin::TreasuryCap<TREASURY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TREASURY> {
        0x2::coin::mint<TREASURY>(arg0, arg1, arg2)
    }

    public entry fun perform_to(arg0: &mut 0x2::coin::TreasuryCap<TREASURY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TREASURY>>(0x2::coin::mint<TREASURY>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

