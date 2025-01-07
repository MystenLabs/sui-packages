module 0xd3cfee0d2ebf6d74a280d736ab61186dc5a2b4c54db616aa76a019dd0983e260::xdoge {
    struct XDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: XDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XDOGE>(arg0, 6, b"XDOGE", b"ELON X TRUMP DOGE", b"Trump x Elon DOGE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Doge_c81ecfbbf2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

