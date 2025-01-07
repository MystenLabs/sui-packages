module 0x22358fbbbd5dc9e0b0cfd5cb8704b6df92941d0b22740cada3fad8c01c11fcd4::sabrinon_coin {
    struct SABRINON_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SABRINON_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SABRINON_COIN>>(0x2::coin::mint<SABRINON_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SABRINON_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<SABRINON_COIN>(arg0, 8, b"SABRINON", b"SABRINON Coin", b"move coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SABRINON_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<SABRINON_COIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SABRINON_COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

