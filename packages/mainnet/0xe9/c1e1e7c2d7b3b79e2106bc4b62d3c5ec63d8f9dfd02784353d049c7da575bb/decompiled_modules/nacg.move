module 0xe9c1e1e7c2d7b3b79e2106bc4b62d3c5ec63d8f9dfd02784353d049c7da575bb::nacg {
    struct NACG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NACG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NACG>(arg0, 6, b"NACG", b"not a chill guy", b"I'm not a chill guy ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733126061001.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NACG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NACG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

