module 0x6b4f5b34891e177cd21073252697a50985e2223b59db424005f78a04c3fe5642::grass_coin {
    struct GRASS_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRASS_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<GRASS_COIN>(arg0, 5, b"GRASS", b"Grass Token", b"Grass Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://static.vecteezy.com/system/resources/previews/020/190/957/original/grass-icon-free-vector.jpg"))), false, arg1);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRASS_COIN>>(v0, v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<GRASS_COIN>>(v1, v3);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GRASS_COIN>>(v2, v3);
    }

    // decompiled from Move bytecode v6
}

