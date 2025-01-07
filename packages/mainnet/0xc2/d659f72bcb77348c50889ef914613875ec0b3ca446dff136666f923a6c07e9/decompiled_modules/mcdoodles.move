module 0xc2d659f72bcb77348c50889ef914613875ec0b3ca446dff136666f923a6c07e9::mcdoodles {
    struct MCDOODLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCDOODLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCDOODLES>(arg0, 6, b"McDoodles", b"McCafe Doodles", b"Doodles is an online community building the future of storytelling through animation. This holiday season, we're taking over mornings with McDonald's - grab a drink in a McCaf x Doodles holiday cup and join the movement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016189_d68129c579.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCDOODLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCDOODLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

