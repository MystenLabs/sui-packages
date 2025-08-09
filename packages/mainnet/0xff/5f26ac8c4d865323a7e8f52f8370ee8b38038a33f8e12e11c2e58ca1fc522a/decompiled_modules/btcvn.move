module 0xff5f26ac8c4d865323a7e8f52f8370ee8b38038a33f8e12e11c2e58ca1fc522a::btcvn {
    struct BTCVN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<BTCVN>, arg1: 0x2::coin::Coin<BTCVN>) {
        0x2::coin::burn<BTCVN>(arg0, arg1);
    }

    fun init(arg0: BTCVN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCVN>(arg0, 8, b"BTCvn", b"BTCvn", b"An vishwa token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTCVN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCVN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BTCVN>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BTCVN>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

