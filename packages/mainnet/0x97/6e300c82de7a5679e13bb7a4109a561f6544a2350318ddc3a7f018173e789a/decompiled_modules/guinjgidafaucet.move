module 0x976e300c82de7a5679e13bb7a4109a561f6544a2350318ddc3a7f018173e789a::guinjgidafaucet {
    struct GUINJGIDAFAUCET has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GUINJGIDAFAUCET>, arg1: 0x2::coin::Coin<GUINJGIDAFAUCET>) {
        0x2::coin::burn<GUINJGIDAFAUCET>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GUINJGIDAFAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GUINJGIDAFAUCET>>(0x2::coin::mint<GUINJGIDAFAUCET>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GUINJGIDAFAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUINJGIDAFAUCET>(arg0, 6, b"GUINJGIDAFAUCET", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUINJGIDAFAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<GUINJGIDAFAUCET>>(v0);
    }

    // decompiled from Move bytecode v6
}

