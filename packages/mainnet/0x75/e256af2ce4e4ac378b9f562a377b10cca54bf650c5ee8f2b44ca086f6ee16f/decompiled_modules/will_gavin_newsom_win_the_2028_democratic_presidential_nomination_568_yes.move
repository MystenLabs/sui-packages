module 0x75e256af2ce4e4ac378b9f562a377b10cca54bf650c5ee8f2b44ca086f6ee16f::will_gavin_newsom_win_the_2028_democratic_presidential_nomination_568_yes {
    struct WILL_GAVIN_NEWSOM_WIN_THE_2028_DEMOCRATIC_PRESIDENTIAL_NOMINATION_568_YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILL_GAVIN_NEWSOM_WIN_THE_2028_DEMOCRATIC_PRESIDENTIAL_NOMINATION_568_YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILL_GAVIN_NEWSOM_WIN_THE_2028_DEMOCRATIC_PRESIDENTIAL_NOMINATION_568_YES>(arg0, 0, b"WILL_GAVIN_NEWSOM_WIN_THE_2028_DEMOCRATIC_PRESIDENTIAL_NOMINATION_568_YES", b"WILL_GAVIN_NEWSOM_WIN_THE_2028_DEMOCRATIC_PRESIDENTIAL_NOMINATION_568 YES", b"WILL_GAVIN_NEWSOM_WIN_THE_2028_DEMOCRATIC_PRESIDENTIAL_NOMINATION_568 YES position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILL_GAVIN_NEWSOM_WIN_THE_2028_DEMOCRATIC_PRESIDENTIAL_NOMINATION_568_YES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILL_GAVIN_NEWSOM_WIN_THE_2028_DEMOCRATIC_PRESIDENTIAL_NOMINATION_568_YES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

