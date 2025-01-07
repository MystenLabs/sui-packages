module 0x6e4fb2e079de0b59aefb962e70c896ef8bab2c972d47b6fe6aa980fd079f85b3::lgcoin_two {
    struct LGCOIN_TWO has drop {
        dummy_field: bool,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<LGCOIN_TWO>,
    }

    fun init(arg0: LGCOIN_TWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LGCOIN_TWO>(arg0, 9, b"LGCOIN", b"Lugon Token", b"Testing purpose", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = Treasury{
            id  : 0x2::object::new(arg1),
            cap : v0,
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LGCOIN_TWO>>(v1);
        0x2::transfer::share_object<Treasury>(v2);
    }

    public entry fun mint_coin(arg0: &mut 0x2::coin::TreasuryCap<LGCOIN_TWO>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LGCOIN_TWO>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

