module 0xab93e90506d9f79f56c18004a25137c42bdfd775d5ddd48c5c13d12d43e72751::will_the_san_antonio_spurs_win_the_2026_nba_finals_yes {
    struct WILL_THE_SAN_ANTONIO_SPURS_WIN_THE_2026_NBA_FINALS_YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILL_THE_SAN_ANTONIO_SPURS_WIN_THE_2026_NBA_FINALS_YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILL_THE_SAN_ANTONIO_SPURS_WIN_THE_2026_NBA_FINALS_YES>(arg0, 0, b"WILL_THE_SAN_ANTONIO_SPURS_WIN_THE_2026_NBA_FINALS_YES", b"WILL_THE_SAN_ANTONIO_SPURS_WIN_THE_2026_NBA_FINALS YES", b"WILL_THE_SAN_ANTONIO_SPURS_WIN_THE_2026_NBA_FINALS YES position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILL_THE_SAN_ANTONIO_SPURS_WIN_THE_2026_NBA_FINALS_YES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILL_THE_SAN_ANTONIO_SPURS_WIN_THE_2026_NBA_FINALS_YES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

