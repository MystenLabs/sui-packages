module 0xf65d07f05f8f110854ebc1e85e353d4c9b6b50b8a40c99000296a7f1be5c4b04::dummy {
    struct DUMMY has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<DUMMY>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DUMMY>>(arg0, arg1);
    }

    fun init(arg0: DUMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUMMY>(arg0, 9, b"DUMMY", b"Dummy", b"This is a stupid token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/3d1GSCv/frog.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUMMY>>(v1);
        0x2::coin::mint_and_transfer<DUMMY>(&mut v2, 10000000000000000000, @0x73147c511a3a4371a5fe39c6d3f85af0442fa1e7f7b702433ab64f5f9103ac2e, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUMMY>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun update_coin_description(arg0: &0x2::coin::TreasuryCap<DUMMY>, arg1: &mut 0x2::coin::CoinMetadata<DUMMY>, arg2: 0x1::string::String) {
        0x2::coin::update_description<DUMMY>(arg0, arg1, arg2);
    }

    public entry fun update_coin_name(arg0: &0x2::coin::TreasuryCap<DUMMY>, arg1: &mut 0x2::coin::CoinMetadata<DUMMY>, arg2: 0x1::string::String) {
        0x2::coin::update_name<DUMMY>(arg0, arg1, arg2);
    }

    public entry fun update_coin_symbol(arg0: &0x2::coin::TreasuryCap<DUMMY>, arg1: &mut 0x2::coin::CoinMetadata<DUMMY>, arg2: 0x1::ascii::String) {
        0x2::coin::update_symbol<DUMMY>(arg0, arg1, arg2);
    }

    public entry fun update_coin_url(arg0: &0x2::coin::TreasuryCap<DUMMY>, arg1: &mut 0x2::coin::CoinMetadata<DUMMY>, arg2: 0x1::ascii::String) {
        0x2::coin::update_icon_url<DUMMY>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

