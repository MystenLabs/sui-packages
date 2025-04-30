module 0x6567c2b392cc225320077583e046509d5f348b45a346f1d2722041ba864c26ac::jiggi_toke {
    struct JIGGI_TOKE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<JIGGI_TOKE>, arg1: 0x2::coin::Coin<JIGGI_TOKE>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<JIGGI_TOKE>(arg0, arg1);
    }

    fun init(arg0: JIGGI_TOKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIGGI_TOKE>(arg0, 9, b"Jigg", b"SUPER JIG", b"Best jig", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/dqlywbmwc/image/upload/v1746029395/qmrvfhticuw94xtvfing.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JIGGI_TOKE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIGGI_TOKE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JIGGI_TOKE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JIGGI_TOKE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

