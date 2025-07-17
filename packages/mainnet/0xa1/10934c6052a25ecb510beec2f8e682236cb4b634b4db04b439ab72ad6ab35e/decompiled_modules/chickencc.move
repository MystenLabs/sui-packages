module 0xa110934c6052a25ecb510beec2f8e682236cb4b634b4db04b439ab72ad6ab35e::chickencc {
    struct CHICKENCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHICKENCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHICKENCC>(arg0, 9, b"ChickenCC", b"ChickenCC", b"Chicken Community Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHICKENCC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHICKENCC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

