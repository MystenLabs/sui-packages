module 0x573c87f72c19291770fd46f67c7e97863d955cccb002242a0b5bf801aa8435d3::strn {
    struct STRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRN>(arg0, 9, b"STRN", b"Stranger ", b"Stranger coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.app.goo.gl/jtTdDKp3GiLNLcZB9")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STRN>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRN>>(v1);
    }

    // decompiled from Move bytecode v6
}

