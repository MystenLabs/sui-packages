module 0xa751332d9574cb2930946b5039393d09b8d76dca49e36f7f5235fe410d93619e::hopeless {
    struct HOPELESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPELESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPELESS>(arg0, 6, b"HOPeLess", b"HOPe Less", b"Criticism for noob hop devs for making hop fun never ends. LOL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730951985413.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPELESS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPELESS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

