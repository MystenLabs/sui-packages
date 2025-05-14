module 0xe63a10968e71fd131887f74ef305d66a6a93fbe89836c2a1585a2573c8cb807f::babysui {
    struct BABYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYSUI>(arg0, 6, b"BABYSUI", b"BabySui", b"The Baby on SUI in now here, crying all the way to pump the chart.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000069704_39238a7f13.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

