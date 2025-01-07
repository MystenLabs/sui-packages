module 0x455df032612f74f8705fff5b690abb72633afc4359b02e0f3d5a330673f1b4e4::milton {
    struct MILTON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILTON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILTON>(arg0, 9, b"milton", b"hurricane milton", b"Enter search term(s)... Search Donate Login  Journalism you trust. Your News. Your Way. Subscribe Home Log in Search Newsletters Help Chat Go to the e-Newspaper Featured Hurricane The Marked Man Buying up the Bay Elections The Housing Experiment Latest News Regions Pinellas Hillsborough Pasco Hernando St. Petersburg Tampa Clearwater Topics Education Business Real Estate Politics Crime Obituaries Weather Sports Bucs icon Bucs Rays icon Rays Lightning icon Lightning   High Schools Bulls icon Bulls Gators icon Gators Seminoles icon Seminoles Opinion Life & Culture Things To Do Calendar Food Videos Photos Investigations Connect with us Games & Puzzles Shop  Hurricane News Sports Opinion Life & Culture Food Obituaries Classifieds Today's Paper Newsletters e-Newspaper Subscribe  Advertisement Hurricane Tampa Bay scrambles to prepare for next hurricane as it cleans up from last one", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/5FDJ5NpDaBiQ5aq9hJwnD8xbXmMCZ8KzjGppawr2pump.png?size=lg&key=086e02")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MILTON>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILTON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILTON>>(v1);
    }

    // decompiled from Move bytecode v6
}

