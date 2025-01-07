module 0xd83f1fed1d098477b715f74a1a403a7ff948f6c32f826fe61b05af5d02d0e28a::hello_coin {
    struct HELLO_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HELLO_COIN>, arg1: 0x2::coin::Coin<HELLO_COIN>) {
        0x2::coin::burn<HELLO_COIN>(arg0, arg1);
    }

    fun init(arg0: HELLO_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELLO_COIN>(arg0, 9, b"HLEEOMATY", b"HLEEOMATY", b"it is a hello coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cdn3.iconfinder.com/data/icons/leto-space/64/__space_cat_helmet-1024.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELLO_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HELLO_COIN>>(v0);
    }

    public entry fun mint_in_my_module(arg0: &mut 0x2::coin::TreasuryCap<HELLO_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HELLO_COIN>>(0x2::coin::mint<HELLO_COIN>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

