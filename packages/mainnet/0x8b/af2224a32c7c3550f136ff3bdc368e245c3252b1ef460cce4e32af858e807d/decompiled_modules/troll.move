module 0x8baf2224a32c7c3550f136ff3bdc368e245c3252b1ef460cce4e32af858e807d::troll {
    struct TROLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLL>(arg0, 6, b"TROLL", b"The King of memes", b"The first, the genuine one, we are not a copy of ANYONE, we are the king of memes, let's have fun, enjoy the Pump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731481340474.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TROLL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

