module 0xdd80a71bc64f08fd330eb9dcb4f55c359e719bc00e90e7f54d1faf26bc69b52b::will_ivanka_trump_win_the_2028_republican_presidential_nomination_yes {
    struct WILL_IVANKA_TRUMP_WIN_THE_2028_REPUBLICAN_PRESIDENTIAL_NOMINATION_YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILL_IVANKA_TRUMP_WIN_THE_2028_REPUBLICAN_PRESIDENTIAL_NOMINATION_YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILL_IVANKA_TRUMP_WIN_THE_2028_REPUBLICAN_PRESIDENTIAL_NOMINATION_YES>(arg0, 0, b"WILL_IVANKA_TRUMP_WIN_THE_2028_REPUBLICAN_PRESIDENTIAL_NOMINATION_YES", b"WILL_IVANKA_TRUMP_WIN_THE_2028_REPUBLICAN_PRESIDENTIAL_NOMINATION YES", b"WILL_IVANKA_TRUMP_WIN_THE_2028_REPUBLICAN_PRESIDENTIAL_NOMINATION YES position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILL_IVANKA_TRUMP_WIN_THE_2028_REPUBLICAN_PRESIDENTIAL_NOMINATION_YES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILL_IVANKA_TRUMP_WIN_THE_2028_REPUBLICAN_PRESIDENTIAL_NOMINATION_YES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

