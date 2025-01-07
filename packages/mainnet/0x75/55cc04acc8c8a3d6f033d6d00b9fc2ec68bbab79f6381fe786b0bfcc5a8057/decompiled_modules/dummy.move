module 0x7555cc04acc8c8a3d6f033d6d00b9fc2ec68bbab79f6381fe786b0bfcc5a8057::dummy {
    struct DUMMY has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<DUMMY>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DUMMY>>(arg0, arg1);
    }

    fun init(arg0: DUMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUMMY>(arg0, 8, b"DUMMY", b"Dummy", b"This is a stupid token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/3d1GSCv/frog.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUMMY>>(v1);
        0x2::coin::mint_and_transfer<DUMMY>(&mut v2, 12000000000000000000, @0x8f6ff638438081e30f3c823e83778118947e617f9d8ab08eca8613d724d77335, arg1);
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

