module 0x195fc1f638b00abb31350179072d52dc2bac05fe8fa8fa369323fa1db658a2a::bakkt {
    struct BAKKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAKKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAKKT>(arg0, 6, b"BAKKT", b"Bakkt", b"DONALD TRUMPS SOCIAL MEDIA COMPANY IS IN ADVANCED TALKS TO BUY BAKKT, A CRYPTOCURRENCY TRADING VENUE OWNED BY INTERCONTINENTAL EXCHANGE- FT - RTRS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000162761_ad324864d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAKKT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAKKT>>(v1);
    }

    // decompiled from Move bytecode v6
}

