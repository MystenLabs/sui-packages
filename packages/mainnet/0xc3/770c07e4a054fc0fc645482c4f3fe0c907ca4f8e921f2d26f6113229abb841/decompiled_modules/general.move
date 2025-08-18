module 0xc3770c07e4a054fc0fc645482c4f3fe0c907ca4f8e921f2d26f6113229abb841::general {
    struct GENERAL has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GENERAL>, arg1: 0x2::coin::Coin<GENERAL>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<GENERAL>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GENERAL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GENERAL>>(0x2::coin::mint<GENERAL>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GENERAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENERAL>(arg0, 9, b"GENERAL", b"SUI GENERAL ", b"The fearless commander of the SUI trenches. Leading the degen army.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmafiEwttccRdY18vebB4zuA3JFeapdk6oaLFNDT4XHFhv?filename=general.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENERAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GENERAL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

