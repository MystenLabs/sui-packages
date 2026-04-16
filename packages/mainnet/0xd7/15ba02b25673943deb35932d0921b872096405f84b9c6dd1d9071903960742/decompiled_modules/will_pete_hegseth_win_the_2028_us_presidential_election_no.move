module 0xd715ba02b25673943deb35932d0921b872096405f84b9c6dd1d9071903960742::will_pete_hegseth_win_the_2028_us_presidential_election_no {
    struct WILL_PETE_HEGSETH_WIN_THE_2028_US_PRESIDENTIAL_ELECTION_NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILL_PETE_HEGSETH_WIN_THE_2028_US_PRESIDENTIAL_ELECTION_NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILL_PETE_HEGSETH_WIN_THE_2028_US_PRESIDENTIAL_ELECTION_NO>(arg0, 0, b"WILL_PETE_HEGSETH_WIN_THE_2028_US_PRESIDENTIAL_ELECTION_NO", b"WILL_PETE_HEGSETH_WIN_THE_2028_US_PRESIDENTIAL_ELECTION NO", b"WILL_PETE_HEGSETH_WIN_THE_2028_US_PRESIDENTIAL_ELECTION NO position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILL_PETE_HEGSETH_WIN_THE_2028_US_PRESIDENTIAL_ELECTION_NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILL_PETE_HEGSETH_WIN_THE_2028_US_PRESIDENTIAL_ELECTION_NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

