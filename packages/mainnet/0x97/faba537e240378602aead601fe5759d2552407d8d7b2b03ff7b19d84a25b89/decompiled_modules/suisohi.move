module 0x97faba537e240378602aead601fe5759d2552407d8d7b2b03ff7b19d84a25b89::suisohi {
    struct SUISOHI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUISOHI>, arg1: 0x2::coin::Coin<SUISOHI>) {
        0x2::coin::burn<SUISOHI>(arg0, arg1);
    }

    fun init(arg0: SUISOHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISOHI>(arg0, 2, b"SUISOHI", b"SUISOHI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.sohimeme.com/picture/hero-shib.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISOHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISOHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUISOHI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUISOHI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

