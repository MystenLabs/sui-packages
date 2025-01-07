module 0xe600926e14f7076ee63c784a551b1fcf33b0db095eeb8dbaa48a8b6fdd4211::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE>(arg0, 6, b"DOGE", b"Downsuizing of Government Employees", b"Downsizing of Government as Tweeted by Elon: https://x.com/elonmusk/status/1855837662952968304", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DOGE_ICON_2_bc656baefc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

