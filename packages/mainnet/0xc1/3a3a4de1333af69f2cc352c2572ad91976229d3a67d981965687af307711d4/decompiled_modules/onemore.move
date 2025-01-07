module 0xc13a3a4de1333af69f2cc352c2572ad91976229d3a67d981965687af307711d4::onemore {
    struct ONEMORE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONEMORE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONEMORE>(arg0, 6, b"ONEMORE", b"One more", b"1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732613362341.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONEMORE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONEMORE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

