module 0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos {
    struct TURBOS has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<TURBOS>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TURBOS>>(arg0, arg1);
    }

    fun init(arg0: TURBOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOS>(arg0, 9, b"TURBOS", b"Turbos", b"Turbos Finance Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbfGQugNb5Te96jVmR21kiKNcmD4k1ntXgyKbFTXioihQ?filename=turbostoken.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

