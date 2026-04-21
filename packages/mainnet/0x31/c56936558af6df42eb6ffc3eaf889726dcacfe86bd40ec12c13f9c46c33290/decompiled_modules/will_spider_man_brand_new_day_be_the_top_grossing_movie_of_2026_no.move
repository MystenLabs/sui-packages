module 0x31c56936558af6df42eb6ffc3eaf889726dcacfe86bd40ec12c13f9c46c33290::will_spider_man_brand_new_day_be_the_top_grossing_movie_of_2026_no {
    struct WILL_SPIDER_MAN_BRAND_NEW_DAY_BE_THE_TOP_GROSSING_MOVIE_OF_2026_NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILL_SPIDER_MAN_BRAND_NEW_DAY_BE_THE_TOP_GROSSING_MOVIE_OF_2026_NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILL_SPIDER_MAN_BRAND_NEW_DAY_BE_THE_TOP_GROSSING_MOVIE_OF_2026_NO>(arg0, 0, b"WILL_SPIDER_MAN_BRAND_NEW_DAY_BE_THE_TOP_GROSSING_MOVIE_OF_2026_NO", b"WILL_SPIDER_MAN_BRAND_NEW_DAY_BE_THE_TOP_GROSSING_MOVIE_OF_2026 NO", b"WILL_SPIDER_MAN_BRAND_NEW_DAY_BE_THE_TOP_GROSSING_MOVIE_OF_2026 NO position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILL_SPIDER_MAN_BRAND_NEW_DAY_BE_THE_TOP_GROSSING_MOVIE_OF_2026_NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILL_SPIDER_MAN_BRAND_NEW_DAY_BE_THE_TOP_GROSSING_MOVIE_OF_2026_NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

