module 0x3c71ffc8ef220c8092638d661b88f277efde039c7759370de39bb13b548f9932::will_the_baltimore_ravens_win_the_2027_nfl_league_championship_yes {
    struct WILL_THE_BALTIMORE_RAVENS_WIN_THE_2027_NFL_LEAGUE_CHAMPIONSHIP_YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILL_THE_BALTIMORE_RAVENS_WIN_THE_2027_NFL_LEAGUE_CHAMPIONSHIP_YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILL_THE_BALTIMORE_RAVENS_WIN_THE_2027_NFL_LEAGUE_CHAMPIONSHIP_YES>(arg0, 0, b"WILL_THE_BALTIMORE_RAVENS_WIN_THE_2027_NFL_LEAGUE_CHAMPIONSHIP_YES", b"WILL_THE_BALTIMORE_RAVENS_WIN_THE_2027_NFL_LEAGUE_CHAMPIONSHIP YES", b"WILL_THE_BALTIMORE_RAVENS_WIN_THE_2027_NFL_LEAGUE_CHAMPIONSHIP YES position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILL_THE_BALTIMORE_RAVENS_WIN_THE_2027_NFL_LEAGUE_CHAMPIONSHIP_YES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILL_THE_BALTIMORE_RAVENS_WIN_THE_2027_NFL_LEAGUE_CHAMPIONSHIP_YES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

