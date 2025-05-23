module 0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy {
    struct DUMMY has drop {
        dummy_field: bool,
    }

    public entry fun burn_coin(arg0: &mut 0x2::coin::TreasuryCap<DUMMY>, arg1: 0x2::coin::Coin<DUMMY>) {
        0x2::coin::burn<DUMMY>(arg0, arg1);
    }

    public entry fun change_icon_url(arg0: &mut 0x2::coin::CoinMetadata<DUMMY>, arg1: &0x2::coin::TreasuryCap<DUMMY>, arg2: 0x1::ascii::String) {
        0x2::coin::update_icon_url<DUMMY>(arg1, arg0, arg2);
    }

    public entry fun change_name(arg0: &mut 0x2::coin::CoinMetadata<DUMMY>, arg1: &0x2::coin::TreasuryCap<DUMMY>, arg2: 0x1::string::String) {
        0x2::coin::update_name<DUMMY>(arg1, arg0, arg2);
    }

    public entry fun change_symbol(arg0: &mut 0x2::coin::CoinMetadata<DUMMY>, arg1: &0x2::coin::TreasuryCap<DUMMY>, arg2: 0x1::ascii::String) {
        0x2::coin::update_symbol<DUMMY>(arg1, arg0, arg2);
    }

    public entry fun freeze_metadata(arg0: 0x2::coin::CoinMetadata<DUMMY>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUMMY>>(arg0);
    }

    fun init(arg0: DUMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUMMY>(arg0, 9, b"dmy", b"DUMMY", b"Currency of dummy protocol!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/media/E9-YWHQXEAEY2vd.jpg:large"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DUMMY>(&mut v2, 10000000000000000000, @0x8f6ff638438081e30f3c823e83778118947e617f9d8ab08eca8613d724d77335, arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DUMMY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUMMY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

