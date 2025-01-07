module 0x954ce57812a3f853fcd839bb33e1a22e714f7ea90205cbfb8dad27dbfbfee621::babygorilla {
    struct BABYGORILLA has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BABYGORILLA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BABYGORILLA>>(0x2::coin::mint<BABYGORILLA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BABYGORILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYGORILLA>(arg0, 6, b"SUI BABY GORILLA", b"SuiBabyGorilla", b"SUI BABY GORILLA MEME COIN", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYGORILLA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYGORILLA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

