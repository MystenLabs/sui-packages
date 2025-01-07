module 0x6fc36a2776aa76693d30d885dd0c718d056f41f3773bb0c7e560f8784a7a692f::bawk {
    struct BAWK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAWK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAWK>(arg0, 6, b"BAWK", b"Happy Chicken", b"C'mon ya happy chickens c'mon! Happy Chickens! C'mon ya happy chickens cmon! BAWK BAWK!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731453420948.PNG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAWK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAWK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

