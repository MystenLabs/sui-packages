module 0xb101deb25eea05bbaad1e7eaeb0ce697933d289f20c20d0e2b166fe9b092d121::dummy2 {
    struct DUMMY2 has drop {
        dummy_field: bool,
    }

    public entry fun burn_coin(arg0: &mut 0x2::coin::TreasuryCap<DUMMY2>, arg1: 0x2::coin::Coin<DUMMY2>) {
        0x2::coin::burn<DUMMY2>(arg0, arg1);
    }

    public entry fun change_icon_url(arg0: &mut 0x2::coin::CoinMetadata<DUMMY2>, arg1: &0x2::coin::TreasuryCap<DUMMY2>, arg2: 0x1::ascii::String) {
        0x2::coin::update_icon_url<DUMMY2>(arg1, arg0, arg2);
    }

    public entry fun change_name(arg0: &mut 0x2::coin::CoinMetadata<DUMMY2>, arg1: &0x2::coin::TreasuryCap<DUMMY2>, arg2: 0x1::string::String) {
        0x2::coin::update_name<DUMMY2>(arg1, arg0, arg2);
    }

    public entry fun change_symbol(arg0: &mut 0x2::coin::CoinMetadata<DUMMY2>, arg1: &0x2::coin::TreasuryCap<DUMMY2>, arg2: 0x1::ascii::String) {
        0x2::coin::update_symbol<DUMMY2>(arg1, arg0, arg2);
    }

    public entry fun freeze_metadata(arg0: 0x2::coin::CoinMetadata<DUMMY2>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUMMY2>>(arg0);
    }

    fun init(arg0: DUMMY2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUMMY2>(arg0, 9, b"dmy2", b"DUMMY2", b"Currency of dummy protocol!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmcxzLNH6iTYAmpwYhGjR6QJozw4z5HsdXDSseCWYHNR9e"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DUMMY2>(&mut v2, 10000000000000000000, @0x8f6ff638438081e30f3c823e83778118947e617f9d8ab08eca8613d724d77335, arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DUMMY2>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUMMY2>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

