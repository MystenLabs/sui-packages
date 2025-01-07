module 0xb0b40b525fbbbcf4c84b07fb1cba7a4edfad3b8a900f7ff940c87b45ffaabe7a::suck {
    struct SUCK has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUCK>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUCK>>(0x2::coin::mint<SUCK>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SUCK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUCK>>(0x2::coin::split<SUCK>(&mut arg0, arg1, arg3), arg2);
        if (0x2::coin::value<SUCK>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUCK>>(arg0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUCK>(arg0);
        };
    }

    fun init(arg0: SUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUCK>(arg0, 9, b"MEME", b"MEME  Token", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCK>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<SUCK>>(0x2::coin::mint<SUCK>(&mut v2, 8181054663, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

