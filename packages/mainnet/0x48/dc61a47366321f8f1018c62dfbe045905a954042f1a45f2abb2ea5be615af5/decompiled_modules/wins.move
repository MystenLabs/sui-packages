module 0x48dc61a47366321f8f1018c62dfbe045905a954042f1a45f2abb2ea5be615af5::wins {
    struct WINS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 9;
        let v1 = b"undefined";
        if (0x1::vector::length<u8>(&v1) > 0) {
            0x1::option::some<vector<u8>>(v1);
        };
        let (v2, v3) = 0x2::coin::create_currency<WINS>(arg0, v0, b"WINS", b"WINS", b"undefined", 0x1::option::none<0x2::url::Url>(), arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WINS>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINS>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<WINS>>(0x2::coin::mint<WINS>(&mut v4, 501000 * 0x2::math::pow(10, v0), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

