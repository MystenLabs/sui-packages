module 0x45121dfdf7543de7fce5c102d9219079bc80788ca02c27c75de63203d03f162c::tralala {
    struct TRALALA has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TRALALA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TRALALA>>(0x2::coin::mint<TRALALA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TRALALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRALALA>(arg0, 4, b"TRALALA", b"TRALALA", b"LALA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://upload.wikimedia.org/wikipedia/commons/5/55/Pepe_2018.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRALALA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TRALALA>>(0x2::coin::mint<TRALALA>(&mut v2, 10000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRALALA>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

