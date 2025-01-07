module 0xa0615e88415df45f47335481f3ec14078082360e5b921d53b8f8cd4d0c586ae5::hrumpp {
    struct HRUMPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HRUMPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HRUMPP>(arg0, 6, b"Hrumpp", b"Hrump", b"Hrump as like Trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5497_04b00e1757.GIF")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HRUMPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HRUMPP>>(v1);
    }

    // decompiled from Move bytecode v6
}

