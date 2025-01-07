module 0x35d38bd46fe73e4e21fce981da1991af6e6253e55745192efe550762b7f3070b::carlywei_coin {
    struct CARLYWEI_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CARLYWEI_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CARLYWEI_COIN>>(0x2::coin::mint<CARLYWEI_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CARLYWEI_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<CARLYWEI_COIN>(arg0, 8, b"CARLYWEI", b"CARLYWEI Coin", b"move coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARLYWEI_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<CARLYWEI_COIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CARLYWEI_COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

