module 0x6a8fc118677f1909db6536130cf0671b49b2b7e1c579187251acb25c4419f93c::suizumi {
    struct SUIZUMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZUMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZUMI>(arg0, 6, b"Suizumi", b"Izumi inu", x"497a756d6920697320612073796d626f6c206f662074686520226c6567656e6422206f6620736176696f7220646f677320696e204a6170616e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3938_74685ebf39.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZUMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZUMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

