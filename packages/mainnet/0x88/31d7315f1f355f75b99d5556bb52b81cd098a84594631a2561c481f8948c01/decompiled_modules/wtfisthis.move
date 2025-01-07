module 0x8831d7315f1f355f75b99d5556bb52b81cd098a84594631a2561c481f8948c01::wtfisthis {
    struct WTFISTHIS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WTFISTHIS>, arg1: 0x2::coin::Coin<WTFISTHIS>) {
        0x2::coin::burn<WTFISTHIS>(arg0, arg1);
    }

    fun init(arg0: WTFISTHIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTFISTHIS>(arg0, 2, b"WTFISTHIS", b"DC", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WTFISTHIS>(&mut v2, 1000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WTFISTHIS>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WTFISTHIS>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WTFISTHIS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WTFISTHIS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

